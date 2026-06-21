-- ============================================================
-- Client Editor
-- Interactive sticker placement/editing with controls for
-- position, scale, rotation, mirror, and lock
-- ============================================================

--- Starts the sticker editor
---@param mapId number The decal identifier to use
---@param stickerName string Name of the sticker texture
---@param existingSticker table|nil Existing sticker data (nil for new placement)
---@param vehicle number Vehicle entity handle
---@param callback function Called with result table on completion (nil = cancelled)
function StartEditor(mapId, stickerName, existingSticker, vehicle, callback)
    CreateThread(function()
        -- ========== Control Setup ==========
        local CTRL_CONFIRM       = Config.Controls.EDITOR_CONFIRM or 176       -- Enter
        local CTRL_CANCEL        = Config.Controls.EDITOR_CANCEL or 177        -- Backspace
        local CTRL_REMOVE        = Config.Controls.EDITOR_REMOVE or 178        -- Delete
        local CTRL_SPEED         = Config.Controls.EDITOR_SPEED or 155         -- Left Shift
        local CTRL_LOCK          = Config.Controls.EDITOR_LOCK or 171          -- Capslock
        local CTRL_MIRROR        = Config.Controls.EDITOR_MIRROR or 132        -- Left Ctrl
        local CTRL_SCALE_UP      = Config.Controls.EDITOR_SCALE_UP or 181      -- Scrollwheel Up
        local CTRL_SCALE_DOWN    = Config.Controls.EDITOR_SCALE_DOWN or 180    -- Scrollwheel Down
        local CTRL_ROTATE_LEFT   = Config.Controls.EDITOR_ROTATE_LEFT or 174   -- Arrow Left
        local CTRL_ROTATE_RIGHT  = Config.Controls.EDITOR_ROTATE_RIGHT or 175  -- Arrow Right

        -- ========== Text Labels ==========
        local TEXT_PLACE      = Config.Text.EDITOR_PLACE or "Place ($%s)"
        local TEXT_SCALE      = Config.Text.EDITOR_SCALE or "Scale (%sx)"
        local TEXT_ROTATE     = Config.Text.EDITOR_ROTATE or "Rotate (%s\194\176)"
        local TEXT_SPEED      = Config.Text.EDITOR_SPEED or "Speed (Hold)"
        local TEXT_LOCK_ON    = Config.Text.EDITOR_LOCK_ON or "Lock Position (On)"
        local TEXT_LOCK_OFF   = Config.Text.EDITOR_LOCK_OFF or "Lock Position (Off)"
        local TEXT_MIRROR_ON  = Config.Text.EDITOR_MIRROR_ON or "Mirror (On)"
        local TEXT_MIRROR_OFF = Config.Text.EDITOR_MIRROR_OFF or "Mirror (Off)"
        local TEXT_REMOVE     = Config.Text.EDITOR_REMOVE or "Remove"
        local TEXT_CANCEL     = Config.Text.EDITOR_CANCEL or "Cancel"

        -- ========== Sticker Config ==========
        local stickerConfig = GetStickerFromConfig(stickerName)

        -- ========== State ==========
        local lastHitPos = vector3(0.0, 0.0, 0.0)
        local lastNormal = vector3(0.0, 0.0, 0.0)
        local hitEntity = 0
        local isLocked = existingSticker and true or false
        local isMirrored = false

        -- Primary sticker data
        local sticker = {
            id       = existingSticker and existingSticker.id or 0,
            mapId    = existingSticker and existingSticker.mapId or mapId,
            dict     = existingSticker and existingSticker.dict or stickerConfig.dict,
            handle   = existingSticker and existingSticker.handle or 0,
            vehicleId = existingSticker and existingSticker.vehicleId or NetworkGetNetworkIdFromEntity(vehicle),
            name     = existingSticker and existingSticker.name or stickerConfig.name,
            scale    = existingSticker and existingSticker.scale or 1.0,
            rot      = existingSticker and existingSticker.rot or 180.0,
            rFrom    = existingSticker and existingSticker.rFrom or vector3(0.0, 0.0, 0.0),
            rTo      = existingSticker and existingSticker.rTo or vector3(0.0, 0.0, 0.0),
        }

        -- Mirror sticker data (for flip mode)
        local mirrorSticker = table.clone(sticker)

        -- Get vehicle dimensions for side detection
        local modelMin, modelMax = GetModelDimensions(GetEntityModel(vehicle))
        local modelSize = modelMax - modelMin

        -- ========== Tooltip Setup ==========
        Tooltip:Load()

        -- Slot 0: Place/Confirm
        Tooltip:BeginMethod("SET_DATA_SLOT", 0,
            GetControlInstructionalButton(2, CTRL_CONFIRM, true),
            TEXT_PLACE:format(existingSticker and 0 or stickerConfig.price)
        )

        -- Slot 1: Scale
        Tooltip:BeginMethod("SET_DATA_SLOT", 1,
            GetControlInstructionalButton(2, CTRL_SCALE_DOWN, true),
            GetControlInstructionalButton(2, CTRL_SCALE_UP, true),
            TEXT_SCALE:format(math.floor(sticker.scale * 100) / 100)
        )

        -- Slot 2: Rotate
        Tooltip:BeginMethod("SET_DATA_SLOT", 2,
            GetControlInstructionalButton(2, CTRL_ROTATE_RIGHT, true),
            GetControlInstructionalButton(2, CTRL_ROTATE_LEFT, true),
            TEXT_ROTATE:format(math.floor(sticker.rot * 10) / 10)
        )

        -- Slot 3: Speed
        Tooltip:BeginMethod("SET_DATA_SLOT", 3,
            GetControlInstructionalButton(2, CTRL_SPEED, true),
            TEXT_SPEED
        )

        -- Slot 4: Lock
        Tooltip:BeginMethod("SET_DATA_SLOT", 4,
            GetControlInstructionalButton(2, CTRL_LOCK, true),
            isLocked and TEXT_LOCK_ON or TEXT_LOCK_OFF
        )

        -- Slot 5 & 6 depend on mode (edit vs new)
        if existingSticker ~= nil then
            -- Edit mode: Remove + Cancel
            Tooltip:BeginMethod("SET_DATA_SLOT", 5,
                GetControlInstructionalButton(2, CTRL_REMOVE, true),
                TEXT_REMOVE
            )
            Tooltip:BeginMethod("SET_DATA_SLOT", 6,
                GetControlInstructionalButton(2, CTRL_CANCEL, true),
                TEXT_CANCEL
            )

            -- Restore position from existing sticker
            lastHitPos, lastNormal = GetSurfaceNormalFromRelativeCoords(existingSticker.rFrom, existingSticker.rTo, vehicle)
            hitEntity = vehicle
        else
            -- New mode: Mirror + Cancel
            Tooltip:BeginMethod("SET_DATA_SLOT", 5,
                GetControlInstructionalButton(2, CTRL_MIRROR, true),
                TEXT_MIRROR_OFF
            )
            Tooltip:BeginMethod("SET_DATA_SLOT", 6,
                GetControlInstructionalButton(2, CTRL_CANCEL, true),
                TEXT_CANCEL
            )
        end

        -- ========== Flip/Mirror Setup ==========
        if stickerConfig.flip then
            local mirrorId = GetUsableIdentifier()
            if mirrorId == nil then
                mirrorId = FreeIdentifier(vehicle)
            end

            mirrorSticker.name = stickerConfig.name2
            mirrorSticker.mapId = mirrorId
            ActiveIdentifiers[mirrorSticker.mapId] = true
        end

        -- Patch textures for both stickers
        PatchDecalDiffuseMap(sticker.mapId, sticker.dict, sticker.name)
        PatchDecalDiffuseMap(mirrorSticker.mapId, mirrorSticker.dict, mirrorSticker.name)

        -- ========== Main Editor Loop ==========
        while true do
            Wait(0)
            Tooltip:Draw()

            -- Raycast from camera
            local _, _, rayPos, rayNormal, rayEntity = ShapeTestFromGameplayCam()

            -- Raycasting variables for mirror
            local mirrorRetval = 0
            local mirrorHit = 0
            local mirrorPos = 0
            local mirrorNormal = 0
            local mirrorEntity = 0

            -- Player and vehicle positions
            local playerPos = GetEntityCoords(PlayerPedId())
            local vehiclePos = GetEntityCoords(vehicle)

            -- Use locked position if enabled
            if isLocked then
                rayPos = lastHitPos
                rayNormal = lastNormal
                rayEntity = hitEntity
            end

            -- Debug line
            if Config.EnableDebug then
                DrawLine(rayPos.x, rayPos.y, rayPos.z, playerPos.x, playerPos.y, playerPos.z, 255, 0, 0, 255.0)
            end

            -- Only proceed if we hit the target vehicle
            if vehicle == rayEntity then
                local entityPos = GetEntityCoords(rayEntity)
                local entityForward = GetEntityForwardVector(rayEntity)
                local hitDirection = norm(rayPos - entityPos)

                -- Determine which side of the vehicle we're looking at (for mirror)
                if isMirrored then
                    local dotProduct = math.abs(
                        entityForward.x * hitDirection.x +
                        entityForward.y * hitDirection.y +
                        entityForward.z * hitDirection.z
                    )

                    if dotProduct <= 0.95 then
                        -- Cast a ray to the opposite side for mirror sticker
                        local crossProduct = entityForward.y * hitDirection.x - entityForward.x * hitDirection.y

                        local probeStartX, probeStartY
                        if crossProduct < 0 then
                            probeStartX = rayPos.x + entityForward.y * modelSize.x
                            probeStartY = rayPos.y - entityForward.x * modelSize.x
                        else
                            probeStartX = rayPos.x - entityForward.y * modelSize.x
                            probeStartY = rayPos.y + entityForward.x * modelSize.x
                        end

                        local probeHandle = StartExpensiveSynchronousShapeTestLosProbe(
                            probeStartX, probeStartY, rayPos.z,
                            rayPos.x, rayPos.y, rayPos.z,
                            2, nil, 4
                        )

                        mirrorRetval, mirrorHit, mirrorPos, mirrorNormal, mirrorEntity = GetShapeTestResult(probeHandle)
                    elseif not isLocked then
                        -- Front/back hit - disable mirror temporarily
                        isMirrored = false
                        Tooltip:BeginMethod("SET_DATA_SLOT", 5,
                            GetControlInstructionalButton(2, CTRL_MIRROR, true),
                            TEXT_MIRROR_OFF
                        )
                        RemoveSticker(mirrorSticker)
                    end
                end

                -- Auto-flip sticker name based on side (for flip-capable stickers)
                if stickerConfig.flip and not isLocked then
                    local crossProduct = entityForward.y * hitDirection.x - entityForward.x * hitDirection.y

                    if crossProduct < 0 then
                        -- Left side
                        if isMirrored then
                            sticker.name = stickerConfig.name
                            mirrorSticker.name = stickerConfig.name2
                        else
                            sticker.name = stickerConfig.name
                        end
                    else
                        -- Right side
                        if isMirrored then
                            sticker.name = stickerConfig.name2
                            mirrorSticker.name = stickerConfig.name
                        else
                            sticker.name = stickerConfig.name2
                        end
                    end

                    PatchDecalDiffuseMap(sticker.mapId, sticker.dict, sticker.name)
                    PatchDecalDiffuseMap(mirrorSticker.mapId, mirrorSticker.dict, mirrorSticker.name)
                end

                -- Render mirror sticker
                if mirrorHit ~= 0 then
                    if not IsDecalAlive(mirrorSticker.handle) then
                        local mw, mh = GetStickerResolution(mirrorSticker.name, mirrorSticker.dict, sticker.scale)
                        local mirrorRot = sticker.rot >= 180.0 and (540.0 - sticker.rot) or (180.0 - sticker.rot)
                        mirrorSticker.handle = AddSticker(mirrorPos, -mirrorNormal, mirrorRot, mw, mh, 1.0, mirrorSticker.mapId, mirrorEntity)
                    end
                end

                -- Render/update main sticker when position changes
                if not isLocked then
                    local moveDist = #(lastHitPos - rayPos)
                    if moveDist > 0.001 then
                        local w, h = GetStickerResolution(sticker.name, sticker.dict, sticker.scale)

                        -- Update mirror sticker
                        if mirrorHit ~= 0 then
                            local mw, mh = GetStickerResolution(mirrorSticker.name, mirrorSticker.dict, sticker.scale)
                            RemoveSticker(mirrorSticker)
                            local mirrorRot = sticker.rot >= 180.0 and (540.0 - sticker.rot) or (180.0 - sticker.rot)
                            mirrorSticker.handle = AddSticker(mirrorPos, -mirrorNormal, mirrorRot, mw, mh, 1.0, mirrorSticker.mapId, mirrorEntity)
                        end

                        -- Update main sticker
                        RemoveSticker(sticker)
                        sticker.handle = AddSticker(rayPos, -rayNormal, sticker.rot, w, h, 1.0, sticker.mapId, rayEntity)
                    end
                end

                -- ========== CONFIRM (Place) ==========
                if IsControlJustPressed(2, CTRL_CONFIRM) then
                    Tooltip:Release()
                    RemoveSticker(mirrorSticker)
                    RemoveSticker(sticker)

                    -- Store relative coordinates
                    sticker.rFrom = GetOffsetFromEntityGivenWorldCoords(rayEntity, rayPos.x + rayNormal.x, rayPos.y + rayNormal.y, rayPos.z + rayNormal.z)
                    sticker.rTo = GetOffsetFromEntityGivenWorldCoords(rayEntity, rayPos.x - rayNormal.x, rayPos.y - rayNormal.y, rayPos.z - rayNormal.z)

                    if isMirrored and mirrorHit ~= 0 then
                        -- Save mirror sticker data
                        mirrorSticker.scale = sticker.scale
                        mirrorSticker.rot = sticker.rot >= 180.0 and (540.0 - sticker.rot) or (180.0 - sticker.rot)
                        mirrorSticker.rFrom = GetOffsetFromEntityGivenWorldCoords(mirrorEntity, mirrorPos.x + mirrorNormal.x, mirrorPos.y + mirrorNormal.y, mirrorPos.z + mirrorNormal.z)
                        mirrorSticker.rTo = GetOffsetFromEntityGivenWorldCoords(mirrorEntity, mirrorPos.x - mirrorNormal.x, mirrorPos.y - mirrorNormal.y, mirrorPos.z - mirrorNormal.z)

                        return callback({ sticker, mirrorSticker })
                    else
                        return callback({ sticker })
                    end
                end

                -- ========== SCALE UP ==========
                if IsControlPressed(2, CTRL_SCALE_UP) then
                    local maxScale = Config.EditorOptions.maxScale or 6.0
                    local minScale = Config.EditorOptions.minScale or 0.1
                    local increment = IsControlPressed(2, CTRL_SPEED) and 0.01 or 0.1

                    if sticker.scale >= maxScale - increment then
                        sticker.scale = minScale
                    else
                        sticker.scale = sticker.scale + increment
                    end

                    -- Update tooltip
                    local w, h = GetStickerResolution(sticker.name, sticker.dict, sticker.scale)
                    Tooltip:BeginMethod("SET_DATA_SLOT", 1,
                        GetControlInstructionalButton(2, CTRL_SCALE_DOWN, true),
                        GetControlInstructionalButton(2, CTRL_SCALE_UP, true),
                        TEXT_SCALE:format(math.floor(sticker.scale * 100) / 100)
                    )

                    -- Redraw mirror
                    if mirrorHit ~= 0 then
                        local mw, mh = GetStickerResolution(mirrorSticker.name, mirrorSticker.dict, sticker.scale)
                        RemoveSticker(mirrorSticker)
                        local mirrorRot = sticker.rot >= 180.0 and (540.0 - sticker.rot) or (180.0 - sticker.rot)
                        mirrorSticker.handle = AddSticker(mirrorPos, -mirrorNormal, mirrorRot, mw, mh, 1.0, mirrorSticker.mapId, mirrorEntity)
                    end

                    -- Redraw main
                    RemoveSticker(sticker)
                    sticker.handle = AddSticker(rayPos, -rayNormal, sticker.rot, w, h, 1.0, sticker.mapId, rayEntity)
                end

                -- ========== SCALE DOWN ==========
                if IsControlPressed(2, CTRL_SCALE_DOWN) then
                    local maxScale = Config.EditorOptions.maxScale or 6.0
                    local minScale = Config.EditorOptions.minScale or 0.1
                    local decrement = IsControlPressed(2, CTRL_SPEED) and 0.01 or 0.1

                    if sticker.scale <= minScale + decrement then
                        sticker.scale = maxScale
                    else
                        sticker.scale = sticker.scale - decrement
                    end

                    -- Update tooltip
                    local w, h = GetStickerResolution(sticker.name, sticker.dict, sticker.scale)
                    Tooltip:BeginMethod("SET_DATA_SLOT", 1,
                        GetControlInstructionalButton(2, CTRL_SCALE_DOWN, true),
                        GetControlInstructionalButton(2, CTRL_SCALE_UP, true),
                        TEXT_SCALE:format(math.floor(sticker.scale * 100) / 100)
                    )

                    -- Redraw mirror
                    if mirrorHit ~= 0 then
                        local mw, mh = GetStickerResolution(mirrorSticker.name, mirrorSticker.dict, sticker.scale)
                        RemoveSticker(mirrorSticker)
                        local mirrorRot = sticker.rot >= 180.0 and (540.0 - sticker.rot) or (180.0 - sticker.rot)
                        mirrorSticker.handle = AddSticker(mirrorPos, -mirrorNormal, mirrorRot, mw, mh, 1.0, mirrorSticker.mapId, mirrorEntity)
                    end

                    -- Redraw main
                    RemoveSticker(sticker)
                    sticker.handle = AddSticker(rayPos, -rayNormal, sticker.rot, w, h, 1.0, sticker.mapId, rayEntity)
                end

                -- ========== ROTATE RIGHT ==========
                if IsControlPressed(2, CTRL_ROTATE_RIGHT) then
                    local increment = IsControlPressed(2, CTRL_SPEED) and 0.1 or 1.0

                    if sticker.rot >= 359.9 then
                        sticker.rot = 0.0
                    else
                        sticker.rot = sticker.rot + increment
                    end

                    local w, h = GetStickerResolution(sticker.name, sticker.dict, sticker.scale)
                    Tooltip:BeginMethod("SET_DATA_SLOT", 2,
                        GetControlInstructionalButton(2, CTRL_ROTATE_RIGHT, true),
                        GetControlInstructionalButton(2, CTRL_ROTATE_LEFT, true),
                        TEXT_ROTATE:format(math.floor(sticker.rot * 10) / 10)
                    )

                    if mirrorHit ~= 0 then
                        local mw, mh = GetStickerResolution(mirrorSticker.name, mirrorSticker.dict, sticker.scale)
                        RemoveSticker(mirrorSticker)
                        local mirrorRot = sticker.rot >= 180.0 and (540.0 - sticker.rot) or (180.0 - sticker.rot)
                        mirrorSticker.handle = AddSticker(mirrorPos, -mirrorNormal, mirrorRot, mw, mh, 1.0, mirrorSticker.mapId, mirrorEntity)
                    end

                    RemoveSticker(sticker)
                    sticker.handle = AddSticker(rayPos, -rayNormal, sticker.rot, w, h, 1.0, sticker.mapId, rayEntity)
                end

                -- ========== ROTATE LEFT ==========
                if IsControlPressed(2, CTRL_ROTATE_LEFT) then
                    local decrement = IsControlPressed(2, CTRL_SPEED) and 0.1 or 1.0

                    if sticker.rot <= decrement then
                        sticker.rot = 360.0
                    else
                        sticker.rot = sticker.rot - decrement
                    end

                    local w, h = GetStickerResolution(sticker.name, sticker.dict, sticker.scale)
                    Tooltip:BeginMethod("SET_DATA_SLOT", 2,
                        GetControlInstructionalButton(2, CTRL_ROTATE_RIGHT, true),
                        GetControlInstructionalButton(2, CTRL_ROTATE_LEFT, true),
                        TEXT_ROTATE:format(math.floor(sticker.rot * 10) / 10)
                    )

                    if mirrorHit ~= 0 then
                        local mw, mh = GetStickerResolution(mirrorSticker.name, mirrorSticker.dict, sticker.scale)
                        RemoveSticker(mirrorSticker)
                        local mirrorRot = sticker.rot >= 180.0 and (540.0 - sticker.rot) or (180.0 - sticker.rot)
                        mirrorSticker.handle = AddSticker(mirrorPos, -mirrorNormal, mirrorRot, mw, mh, 1.0, mirrorSticker.mapId, mirrorEntity)
                    end

                    RemoveSticker(sticker)
                    sticker.handle = AddSticker(rayPos, -rayNormal, sticker.rot, w, h, 1.0, sticker.mapId, rayEntity)
                end

                -- Update last known position
                lastHitPos = rayPos
                lastNormal = rayNormal
                hitEntity = rayEntity

            else
                -- Not hitting the vehicle
                if IsControlJustPressed(2, CTRL_CONFIRM) then
                    if rayEntity == 0 then
                        ShowNotification(Config.Text.ERROR_WRONG_ENTITY or "You can place stickers on vehicles only.")
                    else
                        ShowNotification(Config.Text.ERROR_NO_ACCESS_PLACE or "You cannot place stickers on this vehicle.")
                    end
                end

                -- Still remove/redraw stickers when not on vehicle
                RemoveSticker(mirrorSticker)
                RemoveSticker(sticker)
            end

            -- ========== LOCK TOGGLE ==========
            if IsControlJustPressed(2, CTRL_LOCK) then
                isLocked = not isLocked
                Tooltip:BeginMethod("SET_DATA_SLOT", 4,
                    GetControlInstructionalButton(2, CTRL_LOCK, true),
                    isLocked and TEXT_LOCK_ON or TEXT_LOCK_OFF
                )
            end

            -- ========== MIRROR TOGGLE (new stickers only) ==========
            if IsControlJustPressed(2, CTRL_MIRROR) then
                if existingSticker == nil then
                    isMirrored = not isMirrored

                    if isMirrored then
                        Tooltip:BeginMethod("SET_DATA_SLOT", 0,
                            GetControlInstructionalButton(2, CTRL_CONFIRM, true),
                            TEXT_PLACE:format(stickerConfig.price * 2)
                        )
                        Tooltip:BeginMethod("SET_DATA_SLOT", 5,
                            GetControlInstructionalButton(2, CTRL_MIRROR, true),
                            TEXT_MIRROR_ON
                        )
                    else
                        Tooltip:BeginMethod("SET_DATA_SLOT", 0,
                            GetControlInstructionalButton(2, CTRL_CONFIRM, true),
                            TEXT_PLACE:format(stickerConfig.price)
                        )
                        Tooltip:BeginMethod("SET_DATA_SLOT", 5,
                            GetControlInstructionalButton(2, CTRL_MIRROR, true),
                            TEXT_MIRROR_OFF
                        )
                        RemoveSticker(mirrorSticker)
                    end
                end
            end

            -- ========== CANCEL ==========
            if IsControlJustPressed(2, CTRL_CANCEL) then
                Tooltip:Release()
                RemoveSticker(mirrorSticker)
                RemoveSticker(sticker)

                -- Restore existing sticker if editing
                if existingSticker ~= nil then
                    ApplySticker(existingSticker, 1.0)
                end

                return callback(nil)
            end

            -- ========== REMOVE (edit mode only) ==========
            if IsControlJustPressed(2, CTRL_REMOVE) then
                if existingSticker ~= nil then
                    Tooltip:Release()
                    RemoveSticker(sticker)
                    -- Return empty table to signal deletion
                    return callback({})
                end
            end

            -- ========== MAX DISTANCE CHECK ==========
            local distToVehicle = #(vehiclePos - playerPos)
            if distToVehicle > (Config.EditorOptions.maxDistance or 10.0) then
                Tooltip:Release()
                RemoveSticker(mirrorSticker)
                RemoveSticker(sticker)

                ShowNotification(Config.Text.ERROR_OUT_OF_RANGE or "You went too far from the vehicle.")

                if existingSticker ~= nil then
                    ApplySticker(existingSticker, 1.0)
                end

                return callback(nil)
            end
        end
    end)
end
