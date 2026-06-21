CreateThread(function()
    if Config.Framework == nil or string.len(Config.Framework) == 0 then
        ShowNotification = function(source, text)
            TriggerClientEvent('rcore_stickers:showNotification', source, text)
        end

        GetPlayerId = function(source)
            return ''
        end

        GetPlayerJob = function(source)
            return '', 0
        end

        GetPlayerMoney = function(source)
            return 0
        end

        RemovePlayerMoney = function(source, amount)
            return true
        end

        -- Edit this function to your needs if you want this script to be accessible only for certain players
        IsPlayerAllowedScript = function(source)
            return true
        end

        -- Edit this function to your needs if you want certain stickers to be accessible only for certain players
        IsPlayerAllowedSticker = function(source, stickerName)
            return true
        end
    end
end)