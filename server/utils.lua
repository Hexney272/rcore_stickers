-- ============================================================
-- Server Utilities
-- Config lookup for stickers (server-side)
-- ============================================================

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
