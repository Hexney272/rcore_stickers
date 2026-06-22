-- ============================================================
-- Server Main
-- Handles sticker placement, editing, deletion, syncing
-- ============================================================

NO_FRAMEWORK = (Config.Framework == nil or Config.Framework == '')

StickerCacheDB = {}
CachedStickers = {}  -- [vehicleNetId] = { stickerData, ... }
CachedVehicles = {}  -- [plate..model] = true
StickerCounter = 1   -- Used for standalone/no-framework mode

-- ============================================================
-- Open Menu Event
-- ============================================================
RegisterNetEvent('lsrp_stickers:openMenu')
AddEventHandler('lsrp_stickers:openMenu', function(vehicleNetId)
    local src = source
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)

    if not DoesEntityExist(vehicle) then return end

    -- Fetch vehicle ownership data
    local plate = GetVehicleNumberPlateText(vehicle):gsub("%s+", "")
    local model = GetEntityModel(vehicle)
    local vehicleData = FetchVehicle(plate, model, src)

    -- Determine access permissions
    local errorAdd = ""
    local errorEdit = ""

    if NO_FRAMEWORK then
        -- No framework: anyone can access, just check sticker limits
        if CachedStickers[vehicleNetId] then
            local count = #CachedStickers[vehicleNetId]
            local maxStickers = Config.EditorOptions.maxStickers or 6
            if count >= maxStickers then
                errorAdd = Config.Text.ERROR_MAX_STICKERS or "This vehicle has already reached maximum amount of stickers."
            end
        else
            errorEdit = Config.Text.ERROR_NO_STICKERS or "This vehicle has no stickers on it."
        end

        TriggerClientEvent('lsrp_stickers:openMenu', src, vehicleNetId, errorAdd, errorEdit)
        return
    end

    -- Framework mode: check permissions
    if not vehicleData then
        -- Vehicle not in database (not owned)
        errorAdd = Config.Text.ERROR_NO_ACCESS_PLACE or "You cannot place stickers on this vehicle."
        errorEdit = Config.Text.ERROR_NO_ACCESS_EDIT or "You cannot edit stickers on this vehicle."
        TriggerClientEvent('lsrp_stickers:openMenu', src, vehicleNetId, errorAdd, errorEdit)
        return
    end

    local playerId = GetPlayerId(src)
    local jobName, jobGrade = GetPlayerJob(src)

    -- Default: no access
    errorAdd = Config.Text.ERROR_NO_ACCESS_PLACE or "You cannot place stickers on this vehicle."
    errorEdit = Config.Text.ERROR_NO_ACCESS_EDIT or "You cannot edit stickers on this vehicle."

    -- Check "anyone" access
    if Config.Accessibility.anyone then
        errorAdd = ""
        errorEdit = ""
    end

    -- Check owner access
    if Config.Accessibility.owner and vehicleData.owner == playerId then
        errorAdd = ""
        errorEdit = ""
    end

    -- Check job access
    if Config.Accessibility.jobs then
        local jobConfig = Config.AllowedJobs[jobName]
        if jobConfig then
            if type(jobConfig) == "number" then
                -- Grade-restricted
                if jobGrade >= jobConfig then
                    errorAdd = ""
                    errorEdit = ""
                end
            else
                -- Boolean (any grade)
                errorAdd = ""
                errorEdit = ""
            end
        end
    end

    -- Check restricted (script-level permission)
    if Config.Accessibility.restricted then
        if errorAdd == "" then
            if not IsPlayerAllowedScript(src) then
                errorAdd = Config.Text.ERROR_NO_ACCESS_PLACE or "You cannot place stickers on this vehicle."
            end
        end
        if errorEdit == "" then
            if not IsPlayerAllowedScript(src) then
                errorEdit = Config.Text.ERROR_NO_ACCESS_EDIT or "You cannot edit stickers on this vehicle."
            end
        end
    end

    -- Check sticker limits
    if CachedStickers[vehicleNetId] then
        local count = #CachedStickers[vehicleNetId]
        local maxStickers = Config.EditorOptions.maxStickers or 6
        if count >= maxStickers then
            errorAdd = Config.Text.ERROR_MAX_STICKERS or "This vehicle has already reached maximum amount of stickers."
        end
    else
        errorEdit = Config.Text.ERROR_NO_STICKERS or "This vehicle has no stickers on it."
    end

    TriggerClientEvent('lsrp_stickers:openMenu', src, vehicleNetId, errorAdd, errorEdit)
end)

-- ============================================================
-- Place Sticker Event
-- ============================================================
RegisterNetEvent('lsrp_stickers:placeSticker')
AddEventHandler('lsrp_stickers:placeSticker', function(vehicleNetId, stickerData)
    local src = source
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)

    if not DoesEntityExist(vehicle) then return end

    -- Check max stickers
    if CachedStickers[vehicleNetId] then
        local count = #CachedStickers[vehicleNetId]
        local maxStickers = Config.EditorOptions.maxStickers or 6
        if count >= maxStickers then
            ShowNotification(src, Config.Text.ERROR_MAX_STICKERS or "This vehicle has already reached maximum amount of stickers.")
            return
        end
    end

    local plate = GetVehicleNumberPlateText(vehicle):gsub("%s+", "")
    local model = GetEntityModel(vehicle)

    -- Clear cache so fresh data is fetched
    ClearVehicleStickerCache(model, plate)

    local vehicleData = FetchVehicle(plate, model, src)

    if NO_FRAMEWORK or vehicleData then
        if NO_FRAMEWORK then
            -- Standalone: use incrementing counter as ID
            stickerData.id = StickerCounter
            StickerCounter = StickerCounter + 1
        else
            -- Framework mode: check premium, money, then insert to DB
            local stickerConfig = GetStickerFromConfig(stickerData.name)

            -- Premium check
            if stickerConfig.premium then
                if not IsPlayerAllowedSticker(src, stickerConfig.name) then
                    ShowNotification(src, Config.Text.ERROR_NOT_ALLOWED or "You are not allowed to place this sticker.")
                    return
                end
            end

            -- Money check
            local playerMoney = GetPlayerMoney(src)
            if playerMoney < stickerConfig.price then
                ShowNotification(src, Config.Text.ERROR_NO_MONEY or "You do not have enough money for this sticker.")
                return
            end

            -- Deduct money and insert into database
            RemovePlayerMoney(src, stickerConfig.price)
            stickerData.id = InsertSticker(stickerData, model, plate)
        end

        -- Update cache
        if CachedStickers[vehicleNetId] == nil then
            CachedStickers[vehicleNetId] = {}
        end

        if CachedVehicles[plate .. model] == nil then
            CachedVehicles[plate .. model] = true
        end

        table.insert(CachedStickers[vehicleNetId], stickerData)

        ShowNotification(src, Config.Text.SUCCESS_PLACED or "Sticker has been successfully placed.")
        TriggerClientEvent('lsrp_stickers:placeSticker', -1, vehicleNetId, stickerData)
    end
end)

-- ============================================================
-- Edit Sticker Event
-- ============================================================
RegisterNetEvent('lsrp_stickers:editSticker')
AddEventHandler('lsrp_stickers:editSticker', function(vehicleNetId, stickerData)
    local src = source
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)

    if not DoesEntityExist(vehicle) then return end

    local cached = CachedStickers[vehicleNetId]
    if not cached then return end

    -- Clear DB cache
    local model = GetEntityModel(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle):gsub("%s+", "")
    ClearVehicleStickerCache(model, plate)

    -- Find and update the sticker in cache
    for i, existing in ipairs(cached) do
        if existing.id == stickerData.id then
            cached[i] = stickerData

            EditSticker(stickerData)
            ShowNotification(src, Config.Text.SUCCESS_EDITED or "Sticker has been successfully edited.")
            TriggerClientEvent('lsrp_stickers:editSticker', -1, vehicleNetId, stickerData)
            break
        end
    end
end)

-- ============================================================
-- Delete Sticker Event
-- ============================================================
RegisterNetEvent('lsrp_stickers:deleteSticker')
AddEventHandler('lsrp_stickers:deleteSticker', function(vehicleNetId, stickerData)
    local src = source
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)

    if not DoesEntityExist(vehicle) then return end

    local cached = CachedStickers[vehicleNetId]
    if not cached then return end

    local plate = GetVehicleNumberPlateText(vehicle):gsub("%s+", "")
    local model = GetEntityModel(vehicle)
    ClearVehicleStickerCache(model, plate)

    for i, existing in ipairs(cached) do
        if existing.id == stickerData.id then
            table.remove(cached, i)

            -- If no stickers left, clean up cache entries
            if #cached == 0 then
                CachedStickers[vehicleNetId] = nil
                CachedVehicles[plate .. model] = nil
            end

            DeleteSticker(stickerData)
            ShowNotification(src, Config.Text.SUCCESS_REMOVED or "Sticker has been successfully removed.")
            TriggerClientEvent('lsrp_stickers:deleteSticker', -1, vehicleNetId, stickerData)
            break
        end
    end
end)

-- ============================================================
-- Vehicle Monitoring Thread
-- Checks for despawned vehicles and loads stickers for new ones
-- ============================================================
CreateThread(function()
    local trackedVehicles = {} -- [entityHandle] = { plate, model }

    while true do
        Wait(5000)

        local allVehicles = GetAllVehicles()

        -- Clean up tracked vehicles that no longer exist
        for entity, data in pairs(trackedVehicles) do
            if not DoesEntityExist(entity) then
                ClearVehicleStickerCache(data.model, data.plate)
                trackedVehicles[entity] = nil
            end
        end

        -- Process all vehicles (with throttle)
        local processCount = 50
        for _, vehicle in ipairs(allVehicles) do
            processCount = processCount - 1
            if processCount == 0 then
                processCount = 50
                Wait(50)
            end

            if DoesEntityExist(vehicle) and GetEntityPopulationType(vehicle) == 7 then
                local plate = GetVehicleNumberPlateText(vehicle):gsub("%s+", "")
                local model = GetEntityModel(vehicle)

                -- Track this vehicle
                if not trackedVehicles[vehicle] then
                    trackedVehicles[vehicle] = { plate = plate, model = model }
                end

                -- If this vehicle has stickers in DB, load them into cache
                if CachedVehicles[plate .. model] then
                    local stickers = FetchStickers(model, plate)
                    local netId = NetworkGetNetworkIdFromEntity(vehicle)

                    if #stickers > 0 then
                        if CachedStickers[netId] == nil then
                            CachedStickers[netId] = {}
                        end

                        -- Only populate if cache is empty for this net ID
                        if #CachedStickers[netId] == 0 then
                            for _, dbSticker in ipairs(stickers) do
                                local stickerConfig = GetStickerFromConfig(dbSticker.name)
                                if stickerConfig then
                                    table.insert(CachedStickers[netId], {
                                        id = dbSticker.id,
                                        mapId = 0,
                                        dict = stickerConfig.dict,
                                        handle = 0,
                                        vehicleId = netId,
                                        name = dbSticker.name,
                                        scale = dbSticker.scale,
                                        rot = dbSticker.rotation,
                                        rFrom = vector3(dbSticker.rFromX, dbSticker.rFromY, dbSticker.rFromZ),
                                        rTo = vector3(dbSticker.rToX, dbSticker.rToY, dbSticker.rToZ),
                                    })
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ============================================================
-- Client Sync Thread
-- Sends sticker data to players based on proximity
-- ============================================================
CreateThread(function()
    while true do
        Wait(2000)

        local players = GetPlayers()

        -- Build vehicle position cache
        local vehiclePositions = {}
        for netId, stickerList in pairs(CachedStickers) do
            local entity = NetworkGetEntityFromNetworkId(netId)
            if DoesEntityExist(entity) then
                vehiclePositions[netId] = GetEntityCoords(entity)
            else
                -- Vehicle despawned, notify all clients
                CachedStickers[netId] = nil
                TriggerClientEvent('lsrp_stickers:deleteAllStickers', -1, netId)
            end
        end

        -- Send relevant stickers to each player (with throttle)
        local processCount = 20
        for _, playerId in ipairs(players) do
            processCount = processCount - 1
            if processCount == 0 then
                processCount = 20
                Wait(50)
            end

            local ped = GetPlayerPed(playerId)
            if DoesEntityExist(ped) then
                local playerPos = GetEntityCoords(ped)
                local nearbyStickers = {}
                local totalCount = 0
                local loadDistance = Config.EditorOptions.loadDistance or 50.0

                for netId, stickerList in pairs(CachedStickers) do
                    local vehPos = vehiclePositions[netId]
                    if vehPos then
                        local dist = #(playerPos - vehPos)
                        if dist < loadDistance and totalCount < 56 then
                            nearbyStickers[netId] = stickerList
                            totalCount = totalCount + #stickerList
                        end
                    end
                end

                TriggerClientEvent('lsrp_stickers:refreshStickers', playerId, nearbyStickers)
            end
        end
    end
end)

-- ============================================================
-- Initialization Thread
-- Loads existing stickers from DB on resource start
-- ============================================================
CreateThread(function()
    Wait(1000)

    -- Standalone mode: define stub functions
    if NO_FRAMEWORK then
        FetchVehicle = function(plate, model, playerId) return nil end
        FetchAllStickers = function() return {} end
        FetchStickers = function(vehicleHash, vehiclePlate) return {} end
        InsertSticker = function(sticker, vehicleHash, vehiclePlate) return nil end
        EditSticker = function(sticker) return nil end
        DeleteSticker = function(sticker) return nil end
        return
    end

    -- Wait until DB API functions are ready
    while FetchAllStickers == nil do
        Wait(50)
    end

    -- Clean up stickers whose texture no longer exists in config
    local allStickers = FetchAllStickers()

    for _, dbSticker in ipairs(allStickers) do
        local found = false

        for _, category in ipairs(Config.Stickers) do
            for _, configSticker in ipairs(category.stickers) do
                if configSticker.name == dbSticker.name or configSticker.name2 == dbSticker.name then
                    found = true
                    break
                end
            end
            if found then break end
        end

        if not found then
            DeleteSticker(dbSticker)
        end
    end

    -- Load stickers for vehicles that already exist in the world
    allStickers = FetchAllStickers()
    local allVehicles = GetAllVehicles()

    -- Build a lookup: plate+model -> vehicle entity
    local vehicleLookup = {}
    for _, vehicle in ipairs(allVehicles) do
        if DoesEntityExist(vehicle) and GetEntityPopulationType(vehicle) == 7 then
            local model = GetEntityModel(vehicle)
            local plate = GetVehicleNumberPlateText(vehicle):gsub("%s+", "")
            local stickers = FetchStickers(model, plate)
            if stickers and stickers[1] then
                local key = stickers[1].plate .. stickers[1].model
                vehicleLookup[key] = vehicle
            end
        end
    end

    -- Populate caches
    for _, dbSticker in ipairs(allStickers) do
        local key = dbSticker.plate .. dbSticker.model
        local vehicle = vehicleLookup[key]

        -- Mark vehicle as having stickers
        if CachedVehicles[key] == nil then
            CachedVehicles[key] = true
        end

        if vehicle and DoesEntityExist(vehicle) then
            local netId = NetworkGetNetworkIdFromEntity(vehicle)
            local stickerConfig = GetStickerFromConfig(dbSticker.name)

            if stickerConfig then
                if CachedStickers[netId] == nil then
                    CachedStickers[netId] = {}
                end

                table.insert(CachedStickers[netId], {
                    id = dbSticker.id,
                    mapId = 0,
                    dict = stickerConfig.dict,
                    handle = 0,
                    vehicleId = netId,
                    name = dbSticker.name,
                    scale = dbSticker.scale,
                    rot = dbSticker.rotation,
                    rFrom = vector3(dbSticker.rFromX, dbSticker.rFromY, dbSticker.rFromZ),
                    rTo = vector3(dbSticker.rToX, dbSticker.rToY, dbSticker.rToZ),
                })
            end
        end
    end
end)

-- ============================================================
-- Utility: Clear Vehicle Sticker Cache
-- ============================================================
function ClearVehicleStickerCache(model, plate)
    local key = tostring(plate .. model):gsub("%s+", "")
    StickerCacheDB[key] = nil
end
