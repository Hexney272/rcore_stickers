-- ============================================================
-- Client Main
-- NUI menu integration, sticker sync events, texture loading
-- ============================================================

local isMenuOpen = false
local previewActive = false
local previewDict = nil
local previewName = nil

-- ========== Menu Open (via event or command) ==========
if Config.Accessibility.event then
    RegisterNetEvent('rcore_stickers:openMenu')
    AddEventHandler('rcore_stickers:openMenu', function()
        OpenStickerMenu()
    end)
else
    RegisterCommand("stickers", function()
        OpenStickerMenu()
    end, false)
end

function OpenStickerMenu()
    SelectedVehicle = 0
    local _, _, _, _, entity = ShapeTestFromGameplayCam()

    if entity ~= 0 then
        local netId = NetworkGetNetworkIdFromEntity(entity)
        TriggerServerEvent("lsrp_stickers:openMenu", netId)
    else
        local msg = Config.Text.ERROR_NO_ENTITY or "You are not looking at any vehicle."
        ShowNotification(msg)
    end
end

-- ========== Server tells us to open the menu ==========
RegisterNetEvent('lsrp_stickers:openMenu')
AddEventHandler('lsrp_stickers:openMenu', function(vehicleNetId, errorAdd, errorEdit)
    SelectedVehicle = vehicleNetId
    ErrorMsgAdd = errorAdd
    ErrorMsgEdit = errorEdit

    -- Build category data for NUI
    local categories = {}
    for _, cat in ipairs(Config.Stickers) do
        local stickers = {}
        for _, sticker in ipairs(cat.stickers) do
            if DoesStickerTextureExist(sticker.name, sticker.dict) then
                table.insert(stickers, {
                    name = sticker.name,
                    name2 = sticker.name2,
                    price = sticker.price,
                    flip = sticker.flip,
                    dict = sticker.dict,
                    premium = sticker.premium,
                })
            end
        end
        table.insert(categories, {
            category = cat.category,
            stickers = stickers,
        })
    end

    -- Build active stickers list for edit tab
    local activeList = {}
    for id, sticker in pairs(ActiveStickers) do
        if sticker.vehicleId == vehicleNetId then
            table.insert(activeList, {
                id = sticker.id,
                name = sticker.name,
                dict = sticker.dict,
                mapId = sticker.mapId,
            })
        end
    end

    -- Open NUI
    SetNuiFocus(true, true)
    isMenuOpen = true

    SendNUIMessage({
        action = 'open',
        categories = categories,
        activeStickers = activeList,
        errorAdd = errorAdd,
        errorEdit = errorEdit,
        noFramework = NO_FRAMEWORK,
    })
end)

-- ========== NUI Callbacks ==========

-- Close menu
RegisterNUICallback('closeMenu', function(data, cb)
    CloseNUIMenu()
    cb('ok')
end)

-- Preview sticker (hover) - triggers DrawSprite
RegisterNUICallback('previewSticker', function(data, cb)
    previewActive = true
    previewDict = data.dict
    previewName = data.name
    cb('ok')
end)

-- Clear preview
RegisterNUICallback('clearPreview', function(data, cb)
    previewActive = false
    previewDict = nil
    previewName = nil
    cb('ok')
end)

-- Select sticker for placement -> open editor
RegisterNUICallback('selectSticker', function(data, cb)
    local savedVehicleNet = SelectedVehicle
    local stickerName = data.name

    CloseNUIMenu()
    cb('ok')

    -- Give FiveM a moment to restore game controls after NUI focus release
    CreateThread(function()
        Wait(200)

        local vehicle = NetworkGetEntityFromNetworkId(savedVehicleNet)
        local identifier = GetUsableIdentifier()

        if identifier == nil then
            identifier = FreeIdentifier(vehicle)
        end

        if identifier then
            ActiveIdentifiers[identifier] = true

            StartEditor(identifier, stickerName, nil, vehicle, function(result)
                if result ~= nil then
                    for _, stickerResult in ipairs(result) do
                        ActiveIdentifiers[stickerResult.mapId] = false
                        TriggerServerEvent("lsrp_stickers:placeSticker", savedVehicleNet, stickerResult)
                    end
                end
                SelectedVehicle = 0
            end)
        else
            SelectedVehicle = 0
        end
    end)
end)

-- Edit existing sticker -> open editor
RegisterNUICallback('editSticker', function(data, cb)
    local savedVehicleNet = SelectedVehicle
    local stickerId = data.id

    CloseNUIMenu()
    cb('ok')

    -- Give FiveM a moment to restore game controls after NUI focus release
    CreateThread(function()
        Wait(200)

        local sticker = ActiveStickers[stickerId]
        if sticker then
            local vehicle = NetworkGetEntityFromNetworkId(savedVehicleNet)

            RemoveSticker(sticker)
            ApplySticker(sticker, 1.0)

            StartEditor(sticker.mapId, sticker.name, sticker, vehicle, function(result)
                if result then
                    if next(result) then
                        TriggerServerEvent("lsrp_stickers:editSticker", savedVehicleNet, result[1])
                    else
                        TriggerServerEvent("lsrp_stickers:deleteSticker", savedVehicleNet, sticker)
                    end
                end
                SelectedVehicle = 0
            end)
        else
            SelectedVehicle = 0
        end
    end)
end)

-- Highlight sticker on hover (edit tab)
RegisterNUICallback('highlightSticker', function(data, cb)
    local sticker = ActiveStickers[data.id]
    if sticker then
        RemoveSticker(sticker)
        ApplySticker(sticker, 0.3)
    end
    cb('ok')
end)

-- Unhighlight sticker (edit tab)
RegisterNUICallback('unhighlightSticker', function(data, cb)
    local sticker = ActiveStickers[data.id]
    if sticker then
        RemoveSticker(sticker)
        ApplySticker(sticker, 1.0)
    end
    cb('ok')
end)

-- ========== Helper ==========
function CloseNUIMenu()
    SetNuiFocus(false, false)
    isMenuOpen = false
    previewActive = false
    previewDict = nil
    previewName = nil

    SendNUIMessage({ action = 'close' })
end

-- ========== DrawSprite Preview Thread ==========
CreateThread(function()
    while true do
        Wait(0)

        if previewActive and previewDict and previewName then
            local w, h = GetStickerResolution(previewName, previewDict, 0.5)
            DrawSprite(previewDict, previewName, 0.75, 0.5, w, h, 0.0, 255, 255, 255, 255)
        else
            Wait(100)
        end
    end
end)

-- ========== Sticker Sync Events (unchanged logic) ==========

-- Server sends sticker data for nearby vehicles (periodic refresh)
RegisterNetEvent('lsrp_stickers:refreshStickers')
AddEventHandler('lsrp_stickers:refreshStickers', function(stickersData)
    if next(stickersData) == nil then
        for _, sticker in pairs(ActiveStickers) do
            RemoveSticker(sticker)
            ActiveIdentifiers[sticker.mapId] = false
            ActiveStickers[sticker.id] = nil
        end
        return
    end

    local validIds = {}

    for vehicleNetId, stickerList in pairs(stickersData) do
        local closestVehicle = GetClosestVehicleToPlayer(not NO_FRAMEWORK)

        for _, stickerInfo in ipairs(stickerList) do
            if DoesStickerTextureExist(stickerInfo.name, stickerInfo.dict) then
                validIds[stickerInfo.id] = stickerInfo

                local existing = ActiveStickers[stickerInfo.id]

                if existing == nil then
                    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
                    local identifier = GetUsableIdentifier()

                    if identifier == nil then
                        if closestVehicle == vehicle and SelectedVehicle == 0 then
                            identifier = FreeIdentifier(vehicle)
                        end
                    end

                    if identifier then
                        stickerInfo.mapId = identifier
                        ApplySticker(stickerInfo, 1.0)
                        ActiveIdentifiers[stickerInfo.mapId] = true
                        ActiveStickers[stickerInfo.id] = stickerInfo
                    end
                else
                    if not IsDecalAlive(existing.handle) then
                        ApplySticker(existing, 1.0)
                    end
                end
            end
        end
    end

    for id, sticker in pairs(ActiveStickers) do
        if validIds[id] == nil then
            RemoveSticker(sticker)
            ActiveIdentifiers[sticker.mapId] = false
            ActiveStickers[id] = nil
        end
    end
end)

-- A new sticker was placed (broadcast to all clients)
RegisterNetEvent('lsrp_stickers:placeSticker')
AddEventHandler('lsrp_stickers:placeSticker', function(vehicleNetId, stickerData)
    if not IsVehicleInRange(vehicleNetId) then return end
    if not DoesStickerTextureExist(stickerData.name, stickerData.dict) then return end

    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    local identifier = GetUsableIdentifier()

    if identifier == nil then
        local closestVehicle = GetClosestVehicleToPlayer(not NO_FRAMEWORK)
        if closestVehicle == vehicle and SelectedVehicle == 0 then
            identifier = FreeIdentifier(vehicle)
        else
            return
        end
    end

    if identifier then
        stickerData.mapId = identifier
        ApplySticker(stickerData, 1.0)
        ActiveIdentifiers[stickerData.mapId] = true
        ActiveStickers[stickerData.id] = stickerData
    end
end)

-- A sticker was edited (broadcast to all clients)
RegisterNetEvent('lsrp_stickers:editSticker')
AddEventHandler('lsrp_stickers:editSticker', function(vehicleNetId, stickerData)
    if not IsVehicleInRange(vehicleNetId) then return end
    if not DoesStickerTextureExist(stickerData.name, stickerData.dict) then return end

    local existing = ActiveStickers[stickerData.id]
    if existing ~= nil then
        RemoveSticker(existing)
        ApplySticker(stickerData, 1.0)
        ActiveIdentifiers[stickerData.mapId] = true
        ActiveStickers[stickerData.id] = stickerData
    end
end)

-- A sticker was deleted (broadcast to all clients)
RegisterNetEvent('lsrp_stickers:deleteSticker')
AddEventHandler('lsrp_stickers:deleteSticker', function(vehicleNetId, stickerData)
    if not IsVehicleInRange(vehicleNetId) then return end
    if not DoesStickerTextureExist(stickerData.name, stickerData.dict) then return end

    local existing = ActiveStickers[stickerData.id]
    if existing ~= nil then
        RemoveSticker(existing)
        ActiveIdentifiers[existing.mapId] = false
        ActiveStickers[stickerData.id] = nil
    end
end)

-- All stickers on a vehicle were deleted (vehicle despawned on server)
RegisterNetEvent('lsrp_stickers:deleteAllStickers')
AddEventHandler('lsrp_stickers:deleteAllStickers', function(vehicleNetId)
    for id, sticker in pairs(ActiveStickers) do
        if sticker.vehicleId == vehicleNetId then
            RemoveSticker(sticker)
            ActiveIdentifiers[sticker.mapId] = false
            ActiveStickers[id] = nil
        end
    end
end)

-- Manual refresh
RegisterNetEvent('rcore_stickers:refreshStickers')
AddEventHandler('rcore_stickers:refreshStickers', function()
    for _, sticker in pairs(ActiveStickers) do
        RemoveSticker(sticker)
    end
end)

RegisterCommand("refreshstickers", function()
    for _, sticker in pairs(ActiveStickers) do
        RemoveSticker(sticker)
    end
end, false)

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if isMenuOpen then
            CloseNUIMenu()
        end
        for _, sticker in pairs(ActiveStickers) do
            RemoveSticker(sticker)
        end
    end
end)

-- ========== Texture Dictionary Loading Thread ==========
CreateThread(function()
    local loadedDicts = {}

    for _, category in ipairs(Config.Stickers) do
        for _, sticker in ipairs(category.stickers) do
            local dict = sticker.dict
            if dict and not loadedDicts[dict] then
                RequestStreamedTextureDict(dict, 0)
                repeat
                    Wait(0)
                until HasStreamedTextureDictLoaded(dict)
                loadedDicts[dict] = true
            end
        end
    end
end)
