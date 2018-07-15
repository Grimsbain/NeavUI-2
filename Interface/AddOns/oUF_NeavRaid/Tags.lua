local addon, ns = ...
local config = ns.Config

local timer = {}

oUF.Tags.Events["status:raid"] = "PLAYER_FLAGS_CHANGED UNIT_CONNECTION"
oUF.Tags.Methods["status:raid"] = function(unit)
    local name = UnitName(unit) or UNKNOWN

    if ( UnitIsAFK(unit) or not UnitIsConnected(unit) ) then
        if ( not timer[name] ) then
            timer[name] = GetTime()
        end

        local time = GetTime() - timer[name]

        return ns.FormatTime(time)
    elseif ( timer[name] ) then
        timer[name] = nil
    end
end

oUF.Tags.Events["name:raid"] = "UNIT_NAME_UPDATE"
oUF.Tags.Methods["name:raid"] = function(unit)
    local name = UnitName(unit) or UNKNOWN

    return ns.utf8sub(name)
end
