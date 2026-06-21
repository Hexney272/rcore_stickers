-- ============================================================
-- Debug System
-- Error tracking, debug logging, and optional wrapper overrides
-- for RegisterNetEvent, AddEventHandler, CreateThread, RegisterCommand
-- ============================================================

local debugSessions = {}

--- Starts a new debug session for tracking steps
---@param name string Session identifier
function StartDebugSession(name)
    if Config.ErrorDebug then
        debugSessions[name] = {
            stepCount = 0,
            stepData = {}
        }
    end
end

--- Destroys a debug session
---@param name string Session identifier
function DestoryDebugSession(name)
    if Config.ErrorDebug then
        debugSessions[name] = nil
    end
end

--- Records a step in a debug session
---@param name string Session identifier
---@param step string Step description
function DebugRecordStep(name, step)
    if Config.ErrorDebug then
        local session = debugSessions[name]
        if session then
            session.stepCount = session.stepCount + 1
            session.stepData[session.stepCount] = step
        end
    end
end

--- Prints a formatted debug message (only when EnableDebug is true)
---@param fmt string Format string
---@param ... any Format arguments
function DebugLog(fmt, ...)
    if Config.EnableDebug then
        print(string.format(fmt, ...))
    end
end

--- Displays all recorded steps for a debug session
---@param name string Session identifier
function DisplayCurrentRecordSteps(name)
    local session = debugSessions[name]
    if session then
        for _, step in ipairs(session.stepData) do
            print("^0Step name: ^1" .. tostring(step))
        end
        print("^5=====^0")
        local lastStep = session.stepData[#session.stepData]
        print("^0Last step before the error: ^1" .. tostring(lastStep))
    end
end

--- Helper: Dumps a table to string for debug output
---@param tbl table Table to dump
---@param returnString boolean If true, returns string instead of printing
---@return string|nil
function Dump(tbl, returnString)
    local result = "{\n"
    local indent = 1

    local function serialize(obj, depth)
        local output = ""
        local prefix = string.rep("\t", depth)

        if type(obj) ~= "table" then
            return tostring(obj)
        end

        for k, v in pairs(obj) do
            local keyStr
            if type(k) == "number" or type(k) == "boolean" then
                keyStr = "[" .. tostring(k) .. "]"
            else
                keyStr = "['" .. tostring(k) .. "']"
            end

            if type(v) == "table" then
                output = output .. prefix .. keyStr .. " = " .. serialize(v, depth + 1) .. ",\n"
            elseif type(v) == "string" then
                output = output .. prefix .. keyStr .. " = '" .. v .. "',\n"
            else
                output = output .. prefix .. keyStr .. " = " .. tostring(v) .. ",\n"
            end
        end

        return "{\n" .. output .. string.rep("\t", depth - 1) .. "}"
    end

    result = serialize(tbl, indent)

    if returnString then
        return result
    else
        print(result)
    end
end

-- ============================================================
-- Error Debug Mode: Wrap native functions with error catching
-- ============================================================
if Config.ErrorDebug then
    local _originalAddEventHandler = AddEventHandler
    local _originalRegisterNetEvent = RegisterNetEvent
    local _originalCreateThread = CreateThread
    local _originalRegisterCommand = RegisterCommand
    local _originalRegisterNUICallback = RegisterNUICallback

    --- Wrapped RegisterCommand with xpcall error handling
    RegisterCommand = function(commandName, handler)
        _originalRegisterCommand(commandName, function(source, args, rawCommand)
            local success, err = xpcall(function()
                handler(source, args, rawCommand)
            end, debug.traceback)

            if not success then
                print("^5=========================^0")
                print("^2Error in: ^1RegisterCommand^0")
                print("^2Event name: ^1" .. commandName .. "^0")
                print("^5=========================^0")
                DisplayCurrentRecordSteps(commandName)
                print("^5=========================^0")
                print(err)
                print("^5=========================^0")
            end
        end)
    end

    --- Wrapped RegisterNetEvent with xpcall error handling
    RegisterNetEvent = function(eventName, handler)
        if not handler then
            _originalRegisterNetEvent(eventName)
            return
        end

        _originalRegisterNetEvent(eventName, function(...)
            local args = { ... }
            local success, err = xpcall(function()
                handler(table.unpack(args))
            end, debug.traceback)

            if not success then
                print("^5=========================^0")
                print("^2Error in: ^1RegisterNetEvent^0")
                print("^2Event name: ^1" .. eventName .. "^0")
                print("^5=========================^0")
                DisplayCurrentRecordSteps(eventName)
                print("^5=========================^0")

                for i, arg in pairs(args) do
                    print("^0Argument key: ^1" .. i)
                    print("^0Argument value type: ^1" .. type(arg))
                    if type(arg) == "table" then
                        print("^0Argument value: ^1" .. tostring(arg))
                        Dump(arg)
                    else
                        print("^0Argument value: ^1" .. tostring(arg))
                    end
                    print("^5=====^0")
                end

                print("^5=========================^0")
                print(err)
                print("^5=========================^0")
            end
        end)
    end

    --- Wrapped RegisterNUICallback with xpcall error handling
    RegisterNUICallback = function(callbackName, handler)
        _originalRegisterNUICallback(callbackName, function(...)
            local args = { ... }
            local success, err = xpcall(function()
                handler(table.unpack(args))
            end, debug.traceback)

            if not success then
                print("^5=========================^0")
                print("^2Error in: ^1RegisterNUICallback^0")
                print("^2Event name: ^1" .. callbackName .. "^0")
                print("^5=========================^0")
                DisplayCurrentRecordSteps(callbackName)
                print("^5=========================^0")

                for i, arg in pairs(args) do
                    print("^0Argument key: ^1" .. i)
                    print("^0Argument value type: ^1" .. type(arg))
                    if type(arg) == "table" then
                        print("^0Argument value: ^1" .. tostring(arg))
                        Dump(arg)
                    else
                        print("^0Argument value: ^1" .. tostring(arg))
                    end
                    print("^5=====^0")
                end

                print("^5=========================^0")
                print(err)
                print("^5=========================^0")
            end
        end)
    end

    --- Wrapped CreateThread with xpcall error handling
    CreateThread = function(handler, threadName)
        _originalCreateThread(function()
            local success, err = xpcall(handler, debug.traceback)

            if not success then
                print("=========================")
                print("^2Error in: ^1CreateThread^0")
                print("^1" .. (threadName or "non defined") .. "^0")
                print("=========================")
                DisplayCurrentRecordSteps(threadName)
                print("^5=========================^0")
                print(err)
                print("=========================")
            end
        end)
    end

    --- Wrapped AddEventHandler with xpcall error handling
    AddEventHandler = function(eventName, handler)
        _originalAddEventHandler(eventName, function(...)
            local args = { ... }
            local success, err = xpcall(function()
                handler(table.unpack(args))
            end, debug.traceback)

            if not success then
                print("^5=========================^0")
                print("^2Error in: ^1AddEventHandler^0")
                print("^2Event name: ^1" .. eventName .. "^0")
                print("^5=========================^0")
                DisplayCurrentRecordSteps(eventName)
                print("^5=========================^0")

                for i, arg in pairs(args) do
                    print("^0Argument key: ^1" .. i)
                    print("^0Argument value type: ^1" .. type(arg))
                    if type(arg) == "table" then
                        print("^0Argument value: ^1" .. tostring(arg))
                        Dump(arg)
                    else
                        print("^0Argument value: ^1" .. tostring(arg))
                    end
                    print("^5=====^0")
                end

                print("^5=========================^0")
                print(err)
                print("^5=========================^0")
            end
        end)
    end
end

-- ============================================================
-- Visual Debug Mode: AddDecal logging and clearalldecals command
-- ============================================================
if Config.EnableDebug then
    local _originalAddDecal = AddDecal

    --- Wrapped AddDecal that prints the sticker handle
    AddDecal = function(...)
        local handle = _originalAddDecal(...)
        print("Sticker ID:", handle)
        return handle
    end

    --- Command to remove all decals in range (debug only)
    RegisterCommand("clearalldecals", function()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local range = 50.0

        RemoveDecalsInRange(coords.x, coords.y, coords.z, range)

        -- Remove decals from objects in range
        for object in EnumerateObjects() do
            local objCoords = GetEntityCoords(object)
            if #(coords - objCoords) < range then
                RemoveDecalsFromObject(object)
                RemoveDecalsFromObjectFacing(object, 0.0, 0.0, 1.0)
            end
        end

        -- Remove decals from vehicles in range
        for vehicle in EnumerateVehicles() do
            local vehCoords = GetEntityCoords(vehicle)
            if #(coords - vehCoords) < range then
                RemoveDecalsFromVehicle(vehicle)
            end
        end
    end, false)

    --- Entity enumeration helper using coroutines
    ---@param initFunc function FindFirst* function
    ---@param nextFunc function FindNext* function
    ---@param endFunc function EndFind* function
    function EnumerateEntities(initFunc, nextFunc, endFunc)
        return coroutine.wrap(function()
            local handle, entity = initFunc()

            if not entity or entity == 0 then
                endFunc(handle)
                return
            end

            local wrapper = {
                handle = handle,
                destructor = endFunc,
            }

            setmetatable(wrapper, {
                __gc = function(self)
                    if self.destructor and self.handle then
                        self.destructor(self.handle)
                    end
                    self.destructor = nil
                    self.handle = nil
                end
            })

            local valid = true
            repeat
                coroutine.yield(entity)
                valid, entity = nextFunc(handle)
            until not valid

            wrapper.handle = nil
            wrapper.destructor = nil
            endFunc(handle)
        end)
    end

    --- Enumerate all objects in the world
    function EnumerateObjects()
        return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
    end

    --- Enumerate all vehicles in the world
    function EnumerateVehicles()
        return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
    end
end
