-- ============================================================
-- Tooltip (Instructional Buttons Scaleform)
-- Provides on-screen control hints during the sticker editor
-- ============================================================

Tooltip = {}

--- Calls a scaleform method with variable arguments
---@param methodName string The scaleform method name
---@param ... any Arguments (string, boolean, integer, float)
function Tooltip:BeginMethod(methodName, ...)
    local args = { ... }

    BeginScaleformMovieMethod(self.handle, methodName)

    for _, arg in ipairs(args) do
        local argType = type(arg)

        -- For numbers, check if integer or float
        if argType == "number" then
            argType = math.type(arg) or type(arg)
        end

        if argType == "string" then
            ScaleformMovieMethodAddParamPlayerNameString(arg)
        elseif argType == "boolean" then
            ScaleformMovieMethodAddParamBool(arg)
        elseif argType == "integer" then
            ScaleformMovieMethodAddParamInt(arg)
        elseif argType == "float" then
            ScaleformMovieMethodAddParamFloat(arg)
        end
    end

    EndScaleformMovieMethod()
end

--- Releases the scaleform movie handle
function Tooltip:Release()
    SetScaleformMovieAsNoLongerNeeded(self.handle)
    self.handle = 0
end

--- Draws the instructional buttons on screen
function Tooltip:Draw()
    self:BeginMethod("DRAW_INSTRUCTIONAL_BUTTONS")
    DrawScaleformMovieFullscreen(self.handle, 255, 255, 255, 255, 0)
end

--- Loads the instructional buttons scaleform and initializes it
function Tooltip:Load()
    self.handle = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")

    while not HasScaleformMovieLoaded(self.handle) do
        Wait(0)
    end

    self:BeginMethod("CLEAR_ALL", 200)
    self:BeginMethod("SET_BACKGROUND_COLOUR", 0, 0, 0, 64)
end

--- Garbage collection cleanup
function Tooltip:__gc()
    SetScaleformMovieAsNoLongerNeeded(self.handle)
end
