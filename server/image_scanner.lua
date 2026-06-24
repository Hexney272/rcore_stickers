-- ============================================================
-- Server Image Scanner
-- Scans the stickers/ folder for PNG/WebP images,
-- organizes them by subfolder (= category), and sends
-- the list to clients on request
-- ============================================================

local fs = require('fs') -- Node.js fs module (available in FiveM server JS context)
-- Note: We use Lua's LoadResourceFile to check existence instead

local imageCategories = nil -- Cached scan result

--- Scans stickers/ folder and builds category structure
---@return table Array of {category=string, stickers=[{name, file, price}]}
function ScanStickerImages()
    if imageCategories then return imageCategories end

    local resourceName = GetCurrentResourceName()
    local resourcePath = GetResourcePath(resourceName)
    local stickerBasePath = resourcePath .. '/stickers'

    imageCategories = {}

    -- Use os-level directory listing via io.popen (server-side only)
    local dirHandle = io.popen('find "' .. stickerBasePath .. '" -maxdepth 1 -mindepth 1 -type d 2>/dev/null')
    if not dirHandle then
        print('[rcore_stickers] ^3WARN: Cannot scan stickers/ folder (io.popen not available)^7')
        return imageCategories
    end

    local subdirs = {}
    for line in dirHandle:lines() do
        table.insert(subdirs, line)
    end
    dirHandle:close()

    for _, dirPath in ipairs(subdirs) do
        local categoryName = dirPath:match('([^/\\]+)$')
        if categoryName then
            local stickers = {}

            -- Find all png/webp/jpg files in this subfolder
            local fileHandle = io.popen('find "' .. dirPath .. '" -maxdepth 1 -type f \\( -iname "*.png" -o -iname "*.webp" -o -iname "*.jpg" -o -iname "*.jpeg" \\) 2>/dev/null')
            if fileHandle then
                for fileLine in fileHandle:lines() do
                    local fileName = fileLine:match('([^/\\]+)$')
                    if fileName then
                        -- Sticker neve = fájlnév kiterjesztés nélkül
                        local stickerName = fileName:match('(.+)%.[^.]+$') or fileName
                        local relativePath = 'stickers/' .. categoryName .. '/' .. fileName

                        table.insert(stickers, {
                            name = stickerName,
                            file = relativePath,
                            price = Config.DefaultStickerPrice or 500,
                        })
                    end
                end
                fileHandle:close()
            end

            if #stickers > 0 then
                table.insert(imageCategories, {
                    category = categoryName,
                    stickers = stickers,
                })
                print(('[rcore_stickers] ^2Kategória: %s (%d matrica)^7'):format(categoryName, #stickers))
            end
        end
    end

    print(('[rcore_stickers] ^2Összesen %d képes matrica kategória betöltve a stickers/ mappából^7'):format(#imageCategories))
    return imageCategories
end

-- ========== Client requests image sticker list ==========
RegisterNetEvent('rcore_stickers:server:requestImageStickers')
AddEventHandler('rcore_stickers:server:requestImageStickers', function()
    local src = source
    local categories = ScanStickerImages()
    TriggerClientEvent('rcore_stickers:client:imageCategories', src, categories)
end)

-- Scan on resource start
CreateThread(function()
    Wait(1000)
    ScanStickerImages()
end)
