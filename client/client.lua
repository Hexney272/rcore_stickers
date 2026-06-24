-- ============================================================
-- Client Main
-- WarMenu based sticker selection, editor triggering
-- Sticker sync events, texture loading
-- ============================================================

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
    WarMenu.OpenMenu("STICKERS_MAIN")
end)

-- ========== Main Menu Thread (WarMenu) ==========
CreateThread(function()
    local hoveredStickerId = 0
    local selectedStickers = nil

    -- Create menus
    WarMenu.CreateMenu("STICKERS_MAIN", Config.Text.MENU_MAIN_TITLE or "STICKERS", Config.Text.MENU_MAIN_SUBTITLE or "Options")
    WarMenu.CreateSubMenu("STICKERS_CATEGORY", "STICKERS_MAIN", Config.Text.MENU_CATEGORY_SUBTITLE or "Categories")
    WarMenu.CreateSubMenu("STICKERS_EDIT", "STICKERS_MAIN", Config.Text.MENU_EDIT_SUBTITLE or "Existing stickers")
    WarMenu.CreateSubMenu("STICKERS_ADD", "STICKERS_CATEGORY")

    while true do
        Wait(0)

        if not WarMenu.IsAnyMenuOpened() then
            Wait(500)
        end

        -- Main menu
        if WarMenu.Begin("STICKERS_MAIN") then
            WarMenu.MenuButton(Config.Text.MENU_BUTTON_ADD or "Add", "STICKERS_CATEGORY")
            WarMenu.MenuButton(Config.Text.MENU_BUTTON_EDIT or "Edit", "STICKERS_EDIT")
            WarMenu.End()
        end

        -- Category selection menu
        if WarMenu.Begin("STICKERS_CATEGORY") then
            if ErrorMsgAdd ~= "" then
                WarMenu.ToolTip(ErrorMsgAdd)
            else
                for i, categoryData in ipairs(Config.Stickers) do
                    if WarMenu.MenuButton(categoryData.category, "STICKERS_ADD") then
                        WarMenu.SetSubTitle("STICKERS_ADD", categoryData.category)
                        selectedStickers = categoryData.stickers
                    end
                end
            end
            WarMenu.End()
        end

        -- Add sticker menu (shows stickers from selected category)
        if WarMenu.Begin("STICKERS_ADD") then
            if selectedStickers then
                for i, sticker in ipairs(selectedStickers) do
                    local name = sticker.name
                    local price = sticker.price
                    local dict = sticker.dict

                    if DoesStickerTextureExist(name, dict) then
                        -- Show button with price
                        if NO_FRAMEWORK then
                            WarMenu.Button(name)
                        elseif price > 0 then
                            local priceText = (Config.Text.MENU_BUTTON_PRICE or "~g~$%s"):format(price)
                            WarMenu.Button(name, priceText)
                        else
                            WarMenu.Button(name, Config.Text.MENU_BUTTON_FREE or "~g~FREE")
                        end

                        -- Preview on hover
                        if WarMenu.IsItemHovered() then
                            local w, h = GetStickerResolution(name, dict, 0.5)
                            DrawSprite(dict, name, 0.5, 0.5, w, h, 0.0, 255, 255, 255, 255)
                        end

                        -- Start editor on select
                        if WarMenu.IsItemSelected() then
                            local vehicle = NetworkGetEntityFromNetworkId(SelectedVehicle)
                            local identifier = GetUsableIdentifier()

                            print("[STICKER] Selected! SelectedVehicle=" .. tostring(SelectedVehicle) .. " vehicle=" .. tostring(vehicle) .. " identifier=" .. tostring(identifier))

                            if identifier == nil then
                                identifier = FreeIdentifier(vehicle)
                                print("[STICKER] FreeIdentifier result=" .. tostring(identifier))
                            end

                            if identifier then
                                ActiveIdentifiers[identifier] = true
                                print("[STICKER] Starting editor with mapId=" .. tostring(identifier) .. " name=" .. tostring(name))

                                StartEditor(identifier, name, nil, vehicle, function(result)
                                    if result ~= nil then
                                        for _, stickerResult in ipairs(result) do
                                            ActiveIdentifiers[stickerResult.mapId] = false
                                            TriggerServerEvent("lsrp_stickers:placeSticker", SelectedVehicle, stickerResult)
                                        end
                                    end
                                    SelectedVehicle = 0
                                end)

                                WarMenu.CloseMenu()
                            else
                                print("[STICKER] ERROR: No identifier available!")
                            end
                        end
                    end
                end
            end
            WarMenu.End()
        end

        -- Edit existing stickers menu
        if WarMenu.Begin("STICKERS_EDIT") then
            if ErrorMsgEdit ~= "" then
                WarMenu.ToolTip(ErrorMsgEdit)
            else
                for id, sticker in pairs(ActiveStickers) do
                    if sticker.vehicleId == SelectedVehicle then
                        WarMenu.Button(sticker.name)

                        -- Highlight hovered sticker (make it semi-transparent)
                        if WarMenu.IsItemHovered() and id ~= hoveredStickerId then
                            -- Restore previous hovered sticker
                            if hoveredStickerId ~= 0 then
                                local prev = ActiveStickers[hoveredStickerId]
                                if prev then
                                    RemoveSticker(prev)
                                    ApplySticker(prev, 1.0)
                                end
                            end

                            -- Make current sticker semi-transparent
                            RemoveSticker(sticker)
                            ApplySticker(sticker, 0.3)
                            hoveredStickerId = id
                        end

                        -- Open editor on select
                        if WarMenu.IsItemSelected() then
                            RemoveSticker(sticker)
                            ApplySticker(sticker, 1.0)

                            local vehicle = NetworkGetEntityFromNetworkId(SelectedVehicle)

                            StartEditor(sticker.mapId, sticker.name, sticker, vehicle, function(result)
                                if result then
                                    if next(result) then
                                        -- Edited
                                        TriggerServerEvent("lsrp_stickers:editSticker", SelectedVehicle, result[1])
                                    else
                                        -- Deleted (empty table)
                                        TriggerServerEvent("lsrp_stickers:deleteSticker", SelectedVehicle, sticker)
                                    end
                                end
                                SelectedVehicle = 0
                            end)

                            hoveredStickerId = 0
                            WarMenu.CloseMenu()
                        end
                    end
                end
            end
            WarMenu.End()
        elseif hoveredStickerId ~= 0 then
            -- Restore sticker when leaving edit menu
            local prev = ActiveStickers[hoveredStickerId]
            if prev then
                hoveredStickerId = 0
                RemoveSticker(prev)
                ApplySticker(prev, 1.0)
            end
        end
    end
end)

-- ========== Sticker Sync Events ==========

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

-- ========== real_markers Integration ==========
-- Register sticker interaction points using real_markers exports (useImage mode)
CreateThread(function()
    -- Wait for real_markers to be started
    local timeout = 0
    while GetResourceState('real_markers') ~= 'started' and timeout < 10 do
        Wait(1000)
        timeout = timeout + 1
    end

    if GetResourceState('real_markers') ~= 'started' then
        print("^1[rcore_stickers] real_markers resource nincs elindítva! A matrica markerek nem fognak megjelenni.^7")
        return
    end

    Wait(500)

    for _, point in ipairs(Config.StickerPoints or {}) do
        exports['real_markers']:RegisterImageMarker(point.id, {
            coords = point.coords,
            style = point.style or 'mechanic',
            title = point.title or 'Matrica',
            helpText = point.helpText or '~INPUT_CONTEXT~ Matrica',
            icon = 'wrench',
            useImage = true,
            imageScale = 1.8,
            zOffset = 0.85,
            labelDistance = 3.0,
            interactDistance = point.interactDistance or 2.0,
            drawDistance = point.drawDistance or 8.0,
            color = { r=255, g=200, b=60, a=170 },
            theme = 'amber',
            event = 'rcore_stickers:markerInteract',
        })
    end

    print("^2[rcore_stickers] Matrica markerek sikeresen regisztrálva (" .. #(Config.StickerPoints or {}) .. " pont)^7")
end)

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if GetResourceState('real_markers') ~= 'started' then return end

    for _, point in ipairs(Config.StickerPoints or {}) do
        exports['real_markers']:RemoveCustomMarker(point.id)
    end
end)

-- Handle the marker interaction event
AddEventHandler('rcore_stickers:markerInteract', function(markerId, args)
    OpenStickerMenu()
end)
