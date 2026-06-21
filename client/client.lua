-- ============================================================
-- Client Main
-- Menu opening, sticker sync events, refresh loop, texture loading
-- ============================================================

-- Open menu via event or command
if Config.Accessibility.event then
    RegisterNetEvent('rcore_stickers:openMenu')
    AddEventHandler('rcore_stickers:openMenu', function()
        SelectedVehicle = 0
        local _, _, _, _, entity = ShapeTestFromGameplayCam()

        if entity ~= 0 then
            local netId = NetworkGetNetworkIdFromEntity(entity)
            TriggerServerEvent("lsrp_stickers:openMenu", netId)
        else
            local msg = Config.Text.ERROR_NO_ENTITY or "You are not looking at any vehicle."
            ShowNotification(msg)
        end
    end)
else
    RegisterCommand("stickers", function()
        SelectedVehicle = 0
        local _, _, _, _, entity = ShapeTestFromGameplayCam()

        if entity ~= 0 then
            local netId = NetworkGetNetworkIdFromEntity(entity)
            TriggerServerEvent("lsrp_stickers:openMenu", netId)
        else
            local msg = Config.Text.ERROR_NO_ENTITY or "You are not looking at any vehicle."
            ShowNotification(msg)
        end
    end, false)
end

-- Server tells us to open the menu
RegisterNetEvent('lsrp_stickers:openMenu')
AddEventHandler('lsrp_stickers:openMenu', function(vehicleNetId, errorAdd, errorEdit)
    SelectedVehicle = vehicleNetId
    ErrorMsgAdd = errorAdd
    ErrorMsgEdit = errorEdit
    WarMenu.OpenMenu("STICKERS_MAIN")
end)

-- Server sends sticker data for nearby vehicles (periodic refresh)
RegisterNetEvent('lsrp_stickers:refreshStickers')
AddEventHandler('lsrp_stickers:refreshStickers', function(stickersData)
    -- If empty data, remove all active stickers
    if next(stickersData) == nil then
        for _, sticker in pairs(ActiveStickers) do
            RemoveSticker(sticker)
            ActiveIdentifiers[sticker.mapId] = false
            ActiveStickers[sticker.id] = nil
        end
        return
    end

    -- Track which sticker IDs are still valid
    local validIds = {}

    for vehicleNetId, stickerList in pairs(stickersData) do
        local closestVehicle = GetClosestVehicleToPlayer(not NO_FRAMEWORK)

        for _, stickerInfo in ipairs(stickerList) do
            if DoesStickerTextureExist(stickerInfo.name, stickerInfo.dict) then
                validIds[stickerInfo.id] = stickerInfo

                local existing = ActiveStickers[stickerInfo.id]

                if existing == nil then
                    -- New sticker - try to apply it
                    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
                    local identifier = GetUsableIdentifier()

                    if identifier == nil then
                        -- No free identifier, try to free one from the closest vehicle
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
                    -- Existing sticker - check if it's still alive, re-apply if not
                    if not IsDecalAlive(existing.handle) then
                        ApplySticker(existing, 1.0)
                    end
                end
            end
        end
    end

    -- Remove stickers that are no longer in the server data
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

-- Manual refresh command: removes all active sticker decals
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

-- ============================================================
-- Main Menu Thread
-- ============================================================
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

                            if identifier == nil then
                                identifier = FreeIdentifier(vehicle)
                            end

                            ActiveIdentifiers[identifier] = true

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

-- ============================================================
-- Texture Dictionary Loading Thread
-- ============================================================
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
