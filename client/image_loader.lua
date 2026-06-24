-- ============================================================
-- Image Sticker Loader (Optimalizált)
-- Lazy-load: textúrák CSAK akkor töltődnek be amikor a játékos
-- ténylegesen ki akar választani egy matricát (nem indulásnál!)
-- Ez minimalizálja a VRAM használatot és a resmon-t.
-- ============================================================

local RUNTIME_TXD_PREFIX = 'rcore_stk_'
local loadedRuntimeTxds = {} -- [txdName] = true
local loadedTextures = {}    -- [txdName..texName] = true

-- Max textúra méret - nagyobb képek ekkora felbontásra lesznek skálázva
-- 512x512 = jó minőség, alacsony VRAM (~1MB/matrica max)
local MAX_TEXTURE_SIZE = 512

-- Max fizikai méret a járművön (méterben) - ne takarja el az egész kocsit
-- Az editor maxScale-jával együtt: maxPhysicalSize * maxScale = abszolút max
local MAX_PHYSICAL_SIZE = 0.8 -- Alapértelmezett max ~80cm széles matrica

--- Ensures a runtime TXD exists for a category
---@param categoryName string
---@return string txdName
local function ensureTxd(categoryName)
    local txdName = RUNTIME_TXD_PREFIX .. categoryName:gsub('[^%w]', '_'):lower()
    if not loadedRuntimeTxds[txdName] then
        CreateRuntimeTxd(txdName)
        loadedRuntimeTxds[txdName] = true
    end
    return txdName
end

--- Lazy-loads a single image texture into its runtime TXD
--- Only called when the player actually selects this sticker
---@param sticker table Sticker entry from Config.Stickers
---@return boolean success
function EnsureImageStickerLoaded(sticker)
    if not sticker.isImage then return true end -- YTD sticker, already loaded

    local key = sticker.dict .. '/' .. sticker.name
    if loadedTextures[key] then return true end -- Already loaded

    local resourceName = GetCurrentResourceName()
    local imgData = LoadResourceFile(resourceName, sticker.file)

    if not imgData then
        print(('[rcore_stickers] ^1HIBA: Kép nem található: %s^7'):format(sticker.file))
        return false
    end

    -- Ensure TXD exists
    local txdHandle = CreateRuntimeTxd(sticker.dict)

    -- Load texture from image file (FiveM handles PNG/WebP/JPG decoding)
    -- A natív automatikusan a fájl felbontásán tölti be
    local texHandle = CreateRuntimeTextureFromImage(txdHandle, sticker.name, sticker.file)

    if texHandle then
        loadedTextures[key] = true
        return true
    else
        print(('[rcore_stickers] ^1HIBA: Textúra létrehozás sikertelen: %s^7'):format(sticker.file))
        return false
    end
end

--- Calculates proper physical size for image stickers
--- Maintains aspect ratio but caps maximum dimensions
---@param sticker table Sticker data
---@param scale number User-set scale multiplier
---@return number width Physical width
---@return number height Physical height
function GetImageStickerResolution(sticker, scale)
    -- For image stickers, use a normalized base size
    -- We assume square-ish aspect ratio, cap at MAX_PHYSICAL_SIZE
    local baseSize = MAX_PHYSICAL_SIZE
    local width = baseSize * scale
    local height = baseSize * scale

    -- If we have actual resolution data from the loaded texture
    if sticker.dict and sticker.name then
        local resolution = GetTextureResolution(sticker.dict, sticker.name)
        if resolution and #resolution > 10.0 then
            -- Aspect ratio correction
            local total = resolution.x + resolution.y
            width = (resolution.x / total) * scale
            height = (resolution.y / total) * scale

            -- Cap max physical size (at scale 1.0, max 80cm)
            local maxDim = math.max(width, height)
            if maxDim > MAX_PHYSICAL_SIZE * scale then
                local ratio = (MAX_PHYSICAL_SIZE * scale) / maxDim
                width = width * ratio
                height = height * ratio
            end
        end
    end

    return width, height
end

--- Register image sticker categories received from server
--- Does NOT load textures yet - only registers metadata into Config.Stickers
--- Textures are lazy-loaded when player opens a category
---@param categories table Array from server scanner
function RegisterImageStickersFromServer(categories)
    for _, cat in ipairs(categories) do
        local safeCatTxd = RUNTIME_TXD_PREFIX .. cat.category:gsub('[^%w]', '_'):lower()

        local stickerEntries = {}

        for _, sticker in ipairs(cat.stickers) do
            local texName = sticker.name:gsub('[^%w_ ]', ''):gsub('%s+', '_'):lower()

            table.insert(stickerEntries, {
                name = texName,
                displayName = sticker.name,
                price = sticker.price or Config.DefaultStickerPrice or 500,
                flip = false,
                dict = safeCatTxd,
                isImage = true,
                file = sticker.file, -- Relative path for lazy loading
            })
        end

        if #stickerEntries > 0 then
            table.insert(Config.Stickers, {
                category = cat.category,
                stickers = stickerEntries,
            })
        end
    end

    if #categories > 0 then
        print(('[rcore_stickers] ^2%d képes matrica kategória regisztrálva (lazy-load módban)^7'):format(#categories))
    end
end

-- ========== SERVER SYNC (event-driven, nem loop!) ==========
RegisterNetEvent('rcore_stickers:client:imageCategories')
AddEventHandler('rcore_stickers:client:imageCategories', function(categories)
    RegisterImageStickersFromServer(categories)
end)

-- Egyszer kérjük le induláskor - nincs ismétlődő loop
CreateThread(function()
    Wait(2000)
    TriggerServerEvent('rcore_stickers:server:requestImageStickers')
end)
