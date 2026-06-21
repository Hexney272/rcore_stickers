-- ============================================================
-- Client Utilities
-- Manages decal identifiers, raycasting, vehicle detection
-- ============================================================

NO_FRAMEWORK = (Config.Framework == nil or Config.Framework == '')

ActiveIdentifiers = {}
ActiveStickers = {}
SelectedVehicle = 0
ErrorMsgAdd = ""
ErrorMsgEdit = ""

-- Initialize decal identifier pools
-- Range 9100-9123 and 10000-10031 (total 56 slots matching max render limit)
for i = 9100, 9123 do
    ActiveIdentifiers[i] = false
end

for i = 10000, 10031 do
    ActiveIdentifiers[i] = false
end

--- Performs a shape test (raycast) from the gameplay camera forward
---@return number retval
---@return boolean hit
---@return vector3 endCoords
---@return vector3 surfaceNormal
---@return number entityHit
function ShapeTestFromGameplayCam()
    local camRot = GetGameplayCamRot() * (math.pi / 180.0)

    local direction = vector3(
        -math.sin(camRot.z) * math.abs(math.cos(camRot.x)),
        math.cos(camRot.z) * math.abs(math.cos(camRot.x)),
        math.sin(camRot.x)
    )

    local maxDistance = Config.EditorOptions.maxDistance or 10.0
    local camCoord = GetGameplayCamCoord()

    local endPoint = vector3(
        camCoord.x + direction.x * maxDistance,
        camCoord.y + direction.y * maxDistance,
        camCoord.z + direction.z * maxDistance
    )

    local handle = StartExpensiveSynchronousShapeTestLosProbe(camCoord, endPoint, 2, nil, 4)
    return GetShapeTestResult(handle)
end

--- Gets the surface position and normal from relative entity coordinates
---@param rFrom vector3 Relative start position
---@param rTo vector3 Relative end position
---@param entity number Entity handle
---@return vector3 hitPosition
---@return vector3 surfaceNormal
function GetSurfaceNormalFromRelativeCoords(rFrom, rTo, entity)
    local worldFrom = GetOffsetFromEntityInWorldCoords(entity, rFrom)
    local worldTo = GetOffsetFromEntityInWorldCoords(entity, rTo)

    local handle = StartExpensiveSynchronousShapeTestLosProbe(worldFrom, worldTo, 2, nil, 4)
    local _, _, hitPos, surfaceNormal, _ = GetShapeTestResult(handle)

    return hitPos, surfaceNormal
end

--- Gets the closest vehicle to the player
---@param missionOnly boolean If true, only returns mission/networked vehicles (pop type 7)
---@return number|nil Vehicle entity handle or nil
function GetClosestVehicleToPlayer(missionOnly)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local vehicles = GetGamePool("CVehicle")
    local closestDist = math.maxinteger + 0.0
    local closestVehicle = nil
    local loadDistance = Config.EditorOptions.loadDistance or 50.0

    for _, vehicle in ipairs(vehicles) do
        if missionOnly then
            if GetEntityPopulationType(vehicle) ~= 7 then
                goto continue
            end
        end

        local vehCoords = GetEntityCoords(vehicle)
        local dist = #(playerCoords - vehCoords)

        if dist < closestDist and dist < loadDistance then
            closestDist = dist
            closestVehicle = vehicle
        end

        ::continue::
    end

    return closestVehicle
end

--- Gets the first available (unused) decal identifier from the pool
---@return number|nil Available identifier or nil if all are in use
function GetUsableIdentifier()
    for id, inUse in pairs(ActiveIdentifiers) do
        if not inUse then
            return id
        end
    end
    return nil
end

--- Frees a decal identifier by removing a sticker from a different vehicle
--- Used when all identifier slots are taken and we need one for the current vehicle
---@param vehicle number The vehicle entity we need an identifier for
---@return number|nil The freed identifier or nil
function FreeIdentifier(vehicle)
    local vehicleNetId = NetworkGetNetworkIdFromEntity(vehicle)

    for _, sticker in pairs(ActiveStickers) do
        if sticker.vehicleId ~= vehicleNetId then
            RemoveSticker(sticker)
            ActiveIdentifiers[sticker.mapId] = false
            ActiveStickers[sticker.id] = nil
            DebugLog("freed identifier for %s", vehicleNetId)
            return sticker.mapId
        end
    end

    return nil
end

--- Checks if a vehicle (by network ID) is within range of the player
---@param networkId number Network ID of the vehicle
---@return boolean
function IsVehicleInRange(networkId)
    local ped = PlayerPedId()
    local vehicle = NetworkGetEntityFromNetworkId(networkId)

    if DoesEntityExist(vehicle) then
        local pedCoords = GetEntityCoords(ped)
        local vehCoords = GetEntityCoords(vehicle)
        local dist = #(pedCoords - vehCoords)
        local loadDistance = Config.EditorOptions.loadDistance or 50.0
        return dist < loadDistance
    end

    return false
end
