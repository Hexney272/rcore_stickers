CreateThread(function()
    if Config.Framework and string.strtrim(string.lower(Config.Framework)) == 'other' then
        ShowNotification = function(source, text)
            -- Shows a simple notification
        end

        GetPlayerId = function(source)
            -- Must return player's id used in the database
        end

        GetPlayerJob = function(source)
            -- Must return player's job and players grade as two arguments
        end

        GetPlayerMoney = function(source)
            -- Must return the player's current amount of cash
        end

        RemovePlayerMoney = function(source, amount)
            -- Must remove amount of cash from player
        end

        -- Edit this function to your needs if you want this script to be accessible only for certain players
        IsPlayerAllowedScript = function(source)
            return true
        end

        -- Edit this function to your needs if you want certain stickers to be accessible only for certain players
        IsPlayerAllowedSticker = function(source, stickerName)
            return true
        end
    else
        if Config.Framework and string.len(Config.Framework) ~= 0 then
            if string.strtrim(string.lower(Config.Framework)) ~= 'esx' and string.strtrim(string.lower(Config.Framework)) ~= 'qbcore' then
                print("^1================ WARNING ================^7")
                print("^7Choose your ^2framework^7 in the config!^7")
                print("^1================ WARNING ================^7")
            end
        end
    end
end)