-- ============================================================
-- Image Sticker Loader
-- Scans the stickers/ folder for PNG/WebP files, organizes them
-- into categories (subfolder = category), and creates runtime
-- texture dictionaries so they work with the existing decal system
-- ============================================================

local STICKER_FOLDER = 'stickers'
local RUNTIME_TXD_PREFIX = 'rcore_stk_'
local imageStickersLoaded = false
local loadedRuntimeTxds = {}

-- A képes matricák listája (autómatikusan feltöltődik)
ImageStickerCategories = {}

--- Scans the stickers/ directory structure and builds categories
--- Called once on resource start
function LoadImageStickers()
    if imageStickersLoaded then return end

    local resourceName = GetCurrentResourceName()

    -- A server oldalon scaneljük a fájlokat és elküldjük a kliensnek
    -- Kliensen a fxmanifest files{} alapján tudjuk hogy mi van
    -- De mivel NUI fájlokat a kliens eléri, a szerver fogja scanelni és szinkronizálni

    imageStickersLoaded = true
end

--- Creates a runtime texture dictionary from an image file path
---@param categoryName string Category/folder name (used as txd name part)
---@param imageName string Image filename without extension
---@param imagePath string Full relative path to the image file
---@return string txdName The runtime texture dictionary name
---@return string texName The texture name within the txd
function CreateRuntimeStickerTexture(categoryName, imageName, imagePath)
    local safeCat = categoryName:gsub('[^%w]', '_'):lower()
    local safeName = imageName:gsub('[^%w]', '_'):lower()
    local txdName = RUNTIME_TXD_PREFIX .. safeCat
    local texName = safeName

    -- Create the TXD if it doesn't exist yet
    if not loadedRuntimeTxds[txdName] then
        CreateRuntimeTxd(txdName)
        loadedRuntimeTxds[txdName] = true
    end

    -- Load the image into the runtime TXD
    local fullPath = imagePath
    CreateRuntimeTextureFromImage(
        CreateRuntimeTxd(txdName),
        texName,
        fullPath
    )

    return txdName, texName
end

--- Register image stickers received from server into Config.Stickers
--- This merges with existing YTD-based stickers
---@param categories table Array of {category, stickers: [{name, file, price}]}
function RegisterImageStickersFromServer(categories)
    for _, cat in ipairs(categories) do
        local safeCatTxd = RUNTIME_TXD_PREFIX .. cat.category:gsub('[^%w]', '_'):lower()

        -- Create runtime TXD for this category
        if not loadedRuntimeTxds[safeCatTxd] then
            CreateRuntimeTxd(safeCatTxd)
            loadedRuntimeTxds[safeCatTxd] = true
        end

        local stickerEntries = {}

        for _, sticker in ipairs(cat.stickers) do
            local texName = sticker.name:gsub('[^%w_ ]', ''):gsub('%s+', '_'):lower()

            -- Load image into runtime TXD
            local resourceName = GetCurrentResourceName()
            local imgData = LoadResourceFile(resourceName, sticker.file)

            if imgData then
                -- CreateRuntimeTextureFromImage expects the txd handle and data
                local txdHandle = CreateRuntimeTxd(safeCatTxd)
                CreateRuntimeTextureFromImage(txdHandle, texName, sticker.file)

                table.insert(stickerEntries, {
                    name = texName,
                    displayName = sticker.name, -- Eredeti fájlnév (szép megjelenítés)
                    price = sticker.price or Config.DefaultStickerPrice or 500,
                    flip = false,
                    dict = safeCatTxd,
                    isImage = true, -- Jelzi hogy image-based sticker
                })
            else
                print(('[rcore_stickers] ^1WARN: Image not found: %s^7'):format(sticker.file))
            end
        end

        if #stickerEntries > 0 then
            table.insert(Config.Stickers, {
                category = cat.category,
                stickers = stickerEntries,
            })
        end
    end

    print(('[rcore_stickers] ^2%d képes matrica kategória betöltve^7'):format(#categories))
end

-- ========== SERVER SYNC ==========
RegisterNetEvent('rcore_stickers:client:imageCategories')
AddEventHandler('rcore_stickers:client:imageCategories', function(categories)
    RegisterImageStickersFromServer(categories)
end)

-- Kérjük a szervertől az image sticker listát
CreateThread(function()
    Wait(2000)
    TriggerServerEvent('rcore_stickers:server:requestImageStickers')
end)
