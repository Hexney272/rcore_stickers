DB = {}

CreateThread(function()
    -- Wait for the MySQL global to become available (oxmysql needs a tick to initialize)
    if Config.Database and string.len(Config.Database) ~= 0 then
        local dbType = string.strtrim(string.lower(Config.Database))

        -- For oxmysql and mysql-async, wait until MySQL global is ready
        if dbType == 'oxmysql' or dbType == 'mysql-async' then
            local attempts = 0
            while MySQL == nil do
                Wait(100)
                attempts = attempts + 1
                if attempts > 100 then -- 10 second timeout
                    print("^1================ WARNING ================^7")
                    print("^7Could not find ^2MySQL^7 global. Is your SQL resource started?^7")
                    print("^1================ WARNING ================^7")
                    return
                end
            end
        end

        if dbType == 'mysql-async' then
            DB.fetchAll = function(query, params)
                return MySQL.Sync.fetchAll(query, params)
            end

            DB.fetchScalar = function(query, params)
                return MySQL.Sync.fetchScalar(query, params)
            end

            DB.execute = function(query, params)
                return MySQL.Sync.execute(query, params)
            end
        elseif dbType == 'oxmysql' then
            DB.fetchAll = function(query, params)
                if MySQL.query then
                    return MySQL.query.await(query, params)
                else
                    return exports['oxmysql']:executeSync(query, params)
                end
            end

            DB.fetchScalar = function(query, params)
                if MySQL.scalar then
                    return MySQL.scalar.await(query, params)
                else
                    return exports['oxmysql']:scalarSync(query, params)
                end
            end

            DB.execute = function(query, params)
                if MySQL.update then
                    return MySQL.update.await(query, params)
                else
                    return exports['oxmysql']:executeSync(query, params)
                end
            end
        elseif dbType == 'ghmattimysql' then
            DB.fetchAll = function(query, params)
                return exports['ghmattimysql']:executeSync(query, params)
            end

            DB.fetchScalar = function(query, params)
                return exports['ghmattimysql']:scalarSync(query, params)
            end

            DB.execute = function(query, params)
                return exports['ghmattimysql']:executeSync(query, params)
            end
        else
            print("^1================ WARNING ================^7")
            print("^7Choose your ^2database^7 in the config!^7")
            print("^1================ WARNING ================^7")
        end
    end
end)
