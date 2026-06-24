-- ============================================================
-- Client Sticker Functions
-- Core sticker rendering: add, apply, remove, resolution, config lookup
-- ============================================================

--- Adds a decal (sticker) to the game world on a vehicle surface
---@param position vector3 World position of the decal
---@param normal vector3 Surface normal (negated for correct orientation)
---@param rotation number Rotation angle in degrees
---@param width number Decal width
---@param height number Decal height
---@param opacity number Decal opacity (0.0 - 1.0)
---@param mapId number Decal diffuse map identifier
---@param vehicle number Vehicle entity handle (used for forward vector calculation)
---@return number Decal handle
function AddSticker(position, normal, rotation, width, height, opacity, mapId, vehicle)
    local forward = GetEntityForwardVector(vehicle)

    -- Calculate the dot product of normal with itself (magnitude squared)
    local normalDotNormal = normal.x * normal.x + normal.y * normal.y + normal.z * normal.z

    -- Project forward vector onto the plane defined by the normal
    local forwardDotNormal = forward.x * normal.x + forward.y * normal.y + forward.z * normal.z
    local projScale = forwardDotNormal / normalDotNormal
    local projected = -normal * projScale
    local tangent = projected + forward

    -- Apply rotation quaternion around the normal axis
    local rotQuat = quat(rotation, normal)
    local rotatedTangent = rotQuat * tangent

    return AddDecal(
        mapId,                  -- decal type / texture identifier
        position.x, position.y, position.z,
        normal.x, normal.y, normal.z,
        rotatedTangent.x, rotatedTangent.y, rotatedTangent.z,
        width, height,
        1.0, 1.0, 1.0,         -- RGB color (white = no tint)
        opacity,
        math.maxinteger + 0.0,  -- timeout (effectively infinite)
        1,                      -- unknown flag
        0,                      -- unknown flag
        true                    -- is on entity
    )
end

--- Applies a sticker to a vehicle using stored sticker data
---@param stickerData table Sticker data table with rFrom, rTo, vehicleId, name, dict, scale, rot, mapId
---@param opacity number Opacity (0.0 - 1.0)
function ApplySticker(stickerData, opacity)
    local vehicle = NetworkGetEntityFromNetworkId(stickerData.vehicleId)

    local width, height = GetStickerResolution(stickerData.name, stickerData.dict, stickerData.scale)
    local hitPos, surfaceNormal = GetSurfaceNormalFromRelativeCoords(stickerData.rFrom, stickerData.rTo, vehicle)

    PatchDecalDiffuseMap(stickerData.mapId, stickerData.dict, stickerData.name)

    local handle = AddSticker(hitPos, -surfaceNormal, stickerData.rot, width, height, opacity, stickerData.mapId, vehicle)
    stickerData.handle = handle
end

--- Removes a sticker (decal) from the world
--- Uses a thread to ensure removal even if the decal persists across frames
---@param stickerData table Sticker data table with handle field
function RemoveSticker(stickerData)
    local handle = stickerData.handle

    if IsDecalAlive(handle) then
        CreateThread(function()
            repeat
                RemoveDecal(handle)
                Wait(0)
            until not IsDecalAlive(handle)
        end)
    end
end

--- Checks if a sticker texture exists in the given texture dictionary
---@param name string Texture name
---@param dict string Texture dictionary name
---@return boolean True if texture exists (resolution vector length > 10)
function DoesStickerTextureExist(name, dict)
    local resolution = GetTextureResolution(dict, name)
    return #resolution > 10.0
end

--- Calculates the scaled resolution (width/height) for a sticker
--- Caps physical size for image stickers to prevent full-car coverage
---@param name string Texture name
---@param dict string Texture dictionary name
---@param scale number Scale multiplier
---@param isImage boolean|nil Whether this is a runtime image sticker
---@return number width Scaled width
---@return number height Scaled height
function GetStickerResolution(name, dict, scale, isImage)
    local resolution = GetTextureResolution(dict, name)

    if not resolution or #resolution <= 10.0 then
        -- Fallback: assume square
        local fallbackSize = 0.5 * (scale or 1.0)
        return fallbackSize, fallbackSize
    end

    local total = resolution.x + resolution.y
    local width = (resolution.x / total) * scale
    local height = (resolution.y / total) * scale

    -- Image stickers: cap max physical dimensions
    -- Prevents a 4096x4096 image from covering the entire vehicle
    if isImage then
        local maxPhysical = Config.MaxStickerPhysicalSize or 0.8
        local maxDim = math.max(width, height)
        if maxDim > maxPhysical then
            local ratio = maxPhysical / maxDim
            width = width * ratio
            height = height * ratio
        end
    end

    return width, height
end

--- Finds a sticker configuration entry by name (checks both name and name2)
---@param stickerName string The sticker name to search for
---@return table|nil The sticker config entry or nil if not found
function GetStickerFromConfig(stickerName)
    for _, category in ipairs(Config.Stickers) do
        for _, sticker in ipairs(category.stickers) do
            if sticker.name == stickerName or sticker.name2 == stickerName then
                return sticker
            end
        end
    end
    return nil
end
