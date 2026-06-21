CreateThread(function()
    if Config.Framework and string.strtrim(string.lower(Config.Framework)) == 'qbcore' then
        local SharedObject = promise:new()

        TriggerEvent('rcore_stickers:shared:getSharedObject', function(object)
            SharedObject:resolve(object)
        end)

        local QBCore = Citizen.Await(SharedObject)

        ShowNotification = function(source, text)
            TriggerClientEvent(Config.FrameworkTriggers['notify'], source, text)
        end

        GetPlayerId = function(source)
            return QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        end

        GetPlayerJob = function(source)
            local playerJobData = QBCore.Functions.GetPlayer(source)
            return playerJobData.PlayerData.job.name, playerJobData.PlayerData.job.grade.level
        end

        GetPlayerMoney = function(source)
            return QBCore.Functions.GetPlayer(source).PlayerData.money.cash
        end

        RemovePlayerMoney = function(source, amount)
            return QBCore.Functions.GetPlayer(source).Functions.RemoveMoney('cash', amount)
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
            if string.strtrim(string.lower(Config.Framework)) ~= 'esx' and string.strtrim(string.lower(Config.Framework)) ~= 'other' then
                print("^1================ WARNING ================^7")
                print("^7Choose your ^2framework^7 in the config!^7")
                print("^1================ WARNING ================^7")
            end
        end
    end
end)