-- ============================================================
-- Shared Object Loader
-- Initializes framework triggers, resource names, and SQL table config
-- Then provides a shared object loading event
-- ============================================================

-- Validate and set framework-specific defaults
if Config.Framework and string.len(Config.Framework) ~= 0 then
    local framework = string.strtrim(string.lower(Config.Framework))

    if framework == 'esx' then
        -- ESX defaults
        if not Config.FrameworkTriggers.object or string.len(Config.FrameworkTriggers.object) == 0 then
            Config.FrameworkTriggers.object = 'esx:getSharedObject'
        end
        if not Config.FrameworkTriggers.notify or string.len(Config.FrameworkTriggers.notify) == 0 then
            Config.FrameworkTriggers.notify = 'esx:showNotification'
        end
        if not Config.FrameworkTriggers.resourceName or string.len(Config.FrameworkTriggers.resourceName) == 0 then
            Config.FrameworkTriggers.resourceName = 'es_extended'
        end
        if not Config.FrameworkSQLTables.table or string.len(Config.FrameworkSQLTables.table) == 0 then
            Config.FrameworkSQLTables.table = 'owned_vehicles'
        end
        if not Config.FrameworkSQLTables.identifier or string.len(Config.FrameworkSQLTables.identifier) == 0 then
            Config.FrameworkSQLTables.identifier = 'owner'
        end

    elseif framework == 'qbcore' then
        -- QBCore defaults
        if not Config.FrameworkTriggers.object or string.len(Config.FrameworkTriggers.object) == 0 then
            Config.FrameworkTriggers.object = 'QBCore:GetObject'
        end
        if not Config.FrameworkTriggers.notify or string.len(Config.FrameworkTriggers.notify) == 0 then
            Config.FrameworkTriggers.notify = 'QBCore:Notify'
        end
        if not Config.FrameworkTriggers.resourceName or string.len(Config.FrameworkTriggers.resourceName) == 0 then
            Config.FrameworkTriggers.resourceName = 'qb-core'
        end
        if not Config.FrameworkSQLTables.table or string.len(Config.FrameworkSQLTables.table) == 0 then
            Config.FrameworkSQLTables.table = 'player_vehicles'
        end
        if not Config.FrameworkSQLTables.identifier or string.len(Config.FrameworkSQLTables.identifier) == 0 then
            Config.FrameworkSQLTables.identifier = 'citizenid'
        end

    elseif framework == 'other' then
        -- Custom framework: use whatever is in config, default to empty strings
        Config.FrameworkTriggers.object = Config.FrameworkTriggers.object or ''
        Config.FrameworkTriggers.notify = Config.FrameworkTriggers.notify or ''
        Config.FrameworkTriggers.resourceName = Config.FrameworkTriggers.resourceName or ''
        Config.FrameworkSQLTables.table = Config.FrameworkSQLTables.table or ''
        Config.FrameworkSQLTables.identifier = Config.FrameworkSQLTables.identifier or ''

    else
        print("^1================ WARNING ================^7")
        print("^7Choose your ^2framework^7 in the config!^7")
        print("^1================ WARNING ================^7")
    end
end

-- ============================================================
-- Shared Object Loading Event
-- Framework files trigger this to get their shared object (ESX/QBCore)
-- ============================================================
AddEventHandler('rcore_stickers:shared:getSharedObject', function(cb)
    local sharedObject = nil

    if not Config.Framework then
        print("^1================ WARNING ================^7")
        print("^7Could not ^2load^7 shared object!^7")
        print("^1================ WARNING ================^7")
        return
    end

    local framework = string.strtrim(string.lower(Config.Framework))

    if framework == 'esx' then
        -- Try exports first (new ESX), fall back to event (legacy)
        local success = xpcall(function()
            sharedObject = exports[Config.FrameworkTriggers.resourceName]:getSharedObject()
            cb(sharedObject)
        end, function()
            -- Fallback: try legacy event-based loading
            xpcall(function()
                TriggerEvent(Config.FrameworkTriggers.object, function(obj)
                    sharedObject = obj
                    cb(sharedObject)
                end)

                SetTimeout(100, function()
                    if sharedObject == nil then
                        print("^1================ WARNING ================^7")
                        print("^7Could not ^2load^7 shared object!^7")
                        print("^1================ WARNING ================^7")
                    end
                    cb(sharedObject)
                end)
            end)
        end)

    elseif framework == 'qbcore' then
        -- Try GetCoreObject export first (new QB), then GetSharedObject, then event
        local success = xpcall(function()
            sharedObject = exports[Config.FrameworkTriggers.resourceName]:GetCoreObject()
            cb(sharedObject)
        end, function()
            xpcall(function()
                sharedObject = exports[Config.FrameworkTriggers.resourceName]:GetSharedObject()
                cb(sharedObject)
            end, function()
                xpcall(function()
                    TriggerEvent(Config.FrameworkTriggers.object, function(obj)
                        sharedObject = obj
                        cb(sharedObject)
                    end)

                    SetTimeout(100, function()
                        if sharedObject == nil then
                            print("^1================ WARNING ================^7")
                            print("^7Could not ^2load^7 shared object!^7")
                            print("^1================ WARNING ================^7")
                        end
                        cb(sharedObject)
                    end)
                end)
            end)
        end)

    else
        print("^1================ WARNING ================^7")
        print("^7Could not ^2load^7 shared object!^7")
        print("^1================ WARNING ================^7")
    end
end)
