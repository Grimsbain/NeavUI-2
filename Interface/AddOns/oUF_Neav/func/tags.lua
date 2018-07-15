local _, ns = ...

local len = string.len
local gsub = string.gsub
local format = string.format
local match = string.match
local floor = math.floor

local function FormatValue(value)
    if ( value >= 1e6 ) then
        return tonumber(format("%.1f", value/1e6)).."m"
    elseif ( value >= 1e3 ) then
        return tonumber(format("%.1f", value/1e3)).."k"
    else
        return value
    end
end

oUF.Tags.Events["neav:AdditionalPower"] = "UNIT_POWER_UPDATE UNIT_DISPLAYPOWER UNIT_MAXPOWER"
oUF.Tags.Methods["neav:AdditionalPower"] = function(unit)
    local min, max = UnitPower(unit, Enum.PowerType.Mana), UnitPowerMax(unit, Enum.PowerType.Mana)
    if ( min == max ) then
        return FormatValue(min)
    else
        return FormatValue(min).."/"..FormatValue(max)
    end
end

oUF.Tags.Events["neav:pvptimer"] = "PLAYER_ENTERING_WORLD PLAYER_FLAGS_CHANGED"
oUF.Tags.Methods["neav:pvptimer"] = function(unit)
    if ( not IsPVPTimerRunning() or GetPVPTimer() == 301000 or GetPVPTimer() == 999 ) then
        return ""
    end

    return ns.FormatTime(floor(GetPVPTimer()/1000))
end

oUF.Tags.Events["neav:level"] = "UNIT_LEVEL PLAYER_LEVEL_UP UNIT_FACTION UNIT_TARGETABLE_CHANGED"
oUF.Tags.Methods["neav:level"] = function(unit)
    local r, g, b
    local targetEffectiveLevel = UnitEffectiveLevel(unit)

	if ( UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit) ) then
		targetEffectiveLevel = UnitBattlePetLevel(unit)
		r, g, b = 1.0, 0.82, 0.0
	elseif ( targetEffectiveLevel > 0 ) then
		if ( UnitCanAttack("player", unit) ) then
			local color = GetCreatureDifficultyColor(targetEffectiveLevel)
			r, g, b = color.r, color.g, color.b
		else
			r, g, b = 1.0, 0.82, 0.0
		end
    else
		r, g, b = 1, 0, 0
        targetEffectiveLevel = "??"
    end

    return format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, targetEffectiveLevel)
end

oUF.Tags.Events["neav:name"] = "UNIT_NAME_UPDATE"
oUF.Tags.Methods["neav:name"] = function(unit)
    local r, g, b
    local name, _ = UnitName(unit) or UNKNOWN
    local _, class = UnitClass(unit)

    if ( unit == "player" or unit:match("party(%d)") ) then
		local color = oUF.colors.class[class]
        r, g, b = color[1], color[2], color[3]
    elseif ( unit == "targettarget" or unit == "focustarget" or unit:match("arena(%d)target") ) then
        r, g, b = GameTooltip_UnitColor(unit)
    else
        r, g, b = 1, 1, 1
    end

    name = (len(name) > 15) and gsub(name, "%s?(.[\128-\191]*)%S+%s", "%1. ") or name

    return format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, name)
end

local timer = {}

oUF.Tags.Events["neav:afk"] = "PLAYER_FLAGS_CHANGED"
oUF.Tags.Methods["neav:afk"] = function(unit)
    local name, _ = UnitName(unit) or UNKNOWN

    if ( UnitIsAFK(unit) ) then
        if ( not timer[name] ) then
            timer[name] = GetTime()
        end

        local time = (GetTime() - timer[name])

        return ns.FormatTime(time)
    elseif timer[name] then
        timer[name] = nil
    end
end