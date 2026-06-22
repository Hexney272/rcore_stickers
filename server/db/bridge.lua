-- ============================================================
-- Database Bridge
-- Provides DB.fetchAll, DB.fetchScalar, DB.execute
-- Adapts to the configured SQL driver (oxmysql, mysql-async, ghmattimysql)
-- ============================================================

DB = {}

if Config.Database and string.len(Config.Database) ~= 0 then
    local dbType = string.strtrim(string.lower(Config.Database))

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
