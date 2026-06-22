-- ============================================================
-- Database API
-- Defines FetchVehicle, FetchAllStickers, FetchStickers,
-- InsertSticker, EditSticker, DeleteSticker
-- ============================================================

-- Standalone mode: define stubs that don't touch the database
if Config.Framework == nil or Config.Framework == '' then
    function FetchVehicle(plate, model, playerId) return nil end
    function FetchAllStickers() return {} end
    function FetchStickers(vehicleHash, vehiclePlate) return {} end
    function InsertSticker(sticker, vehicleHash, vehiclePlate) return nil end
    function EditSticker(sticker) return nil end
    function DeleteSticker(sticker) return nil end
    return
end

-- Framework mode: real database functions
local _table = Config.FrameworkSQLTables['table']
local _identifier = Config.FrameworkSQLTables['identifier']

function FetchVehicle(plate, model, playerId)
    if Config.Accessibility.owner == false then
        return {
            model = model,
            plate = plate,
            owner = GetPlayerId(playerId),
        }
    end

    local queryString = [[
        SELECT
            %s AS owner,
            %s AS plate,
            %s AS model
        FROM %s
        WHERE
            %s = @plate
        AND
            %s = @model
    ]]

    if Config.Framework and string.strtrim(string.lower(Config.Framework)) == 'esx' then
        return DB.fetchAll(string.format(queryString, _identifier, "REPLACE(plate, ' ', '')", "JSON_EXTRACT(vehicle, '$.model')", _table, "REPLACE(plate, ' ', '')", "JSON_EXTRACT(vehicle, '$.model')"), {
            ['@plate'] = plate,
            ['@model'] = model
        })[1]
    elseif Config.Framework and string.strtrim(string.lower(Config.Framework)) == 'qbcore' then
        return DB.fetchAll(string.format(queryString, _identifier, "REPLACE(plate, ' ', '')", "hash", _table, "REPLACE(plate, ' ', '')", "hash"), {
            ['@plate'] = plate,
            ['@model'] = model
        })[1]
    end
end

function FetchAllStickers()
    return DB.fetchAll([[
        SELECT
            id,
            name,
            vehicle_hash AS model,
            vehicle_plate AS plate,
            scale,
            rotation,
            ray_from_x AS rFromX,
            ray_from_y AS rFromY,
            ray_from_z AS rFromZ,
            ray_to_x AS rToX,
            ray_to_y AS rToY,
            ray_to_z AS rToZ
        FROM stickers
    ]])
end

function FetchStickers(vehicleHash, vehiclePlate)
    local key = tostring((vehicleHash .. vehiclePlate)):gsub('%s+', '')
    if not StickerCacheDB[key] then
        StickerCacheDB[key] = DB.fetchAll([[
            SELECT
                id,
                name,
                vehicle_hash AS model,
                vehicle_plate AS plate,
                scale,
                rotation,
                ray_from_x AS rFromX,
                ray_from_y AS rFromY,
                ray_from_z AS rFromZ,
                ray_to_x AS rToX,
                ray_to_y AS rToY,
                ray_to_z AS rToZ
            FROM stickers
            WHERE
                vehicle_hash = @vehicleHash
            AND
                vehicle_plate = @vehiclePlate
        ]], {
            ['@vehicleHash'] = vehicleHash,
            ['@vehiclePlate'] = vehiclePlate
        })
    end

    return StickerCacheDB[key]
end

function InsertSticker(sticker, vehicleHash, vehiclePlate)
    DB.execute([[
        INSERT INTO stickers
        (
            name, vehicle_hash, vehicle_plate, scale, rotation, ray_from_x, ray_from_y, ray_from_z, ray_to_x, ray_to_y, ray_to_z
        )
        VALUES
        (
            @name, @vehicleHash, @vehiclePlate, @scale, @rotation, @rFromX, @rFromY, @rFromZ, @rToX, @rToY, @rToZ
        )
    ]], {
        ['@name'] = sticker.name,
        ['@vehicleHash'] = vehicleHash,
        ['@vehiclePlate'] = vehiclePlate,
        ['@scale'] = sticker.scale,
        ['@rotation'] = sticker.rot,
        ['@rFromX'] = sticker.rFrom.x,
        ['@rFromY'] = sticker.rFrom.y,
        ['@rFromZ'] = sticker.rFrom.z,
        ['@rToX'] = sticker.rTo.x,
        ['@rToY'] = sticker.rTo.y,
        ['@rToZ'] = sticker.rTo.z
    })

    return DB.fetchScalar([[
        SELECT
            id
        FROM stickers
        ORDER BY
            id
        DESC LIMIT 1
    ]])
end

function EditSticker(sticker)
    return DB.execute([[
        UPDATE stickers SET
            scale = @scale,
            rotation = @rotation,
            ray_from_x = @rFromX,
            ray_from_y = @rFromY,
            ray_from_z = @rFromZ,
            ray_to_x = @rToX,
            ray_to_y = @rToY,
            ray_to_z = @rToZ
        WHERE
            id = @id
    ]], {
        ['@id'] = sticker.id,
        ['@scale'] = sticker.scale,
        ['@rotation'] = sticker.rot,
        ['@rFromX'] = sticker.rFrom.x,
        ['@rFromY'] = sticker.rFrom.y,
        ['@rFromZ'] = sticker.rFrom.z,
        ['@rToX'] = sticker.rTo.x,
        ['@rToY'] = sticker.rTo.y,
        ['@rToZ'] = sticker.rTo.z
    })
end

function DeleteSticker(sticker)
    return DB.execute([[
        DELETE FROM stickers
        WHERE id = @id
    ]], {
        ['@id'] = sticker.id
    })
end
