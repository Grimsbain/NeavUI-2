local _, nCore = ...

-- Find Map ID by name.
SlashCmdList["MAPID"] = function(msg)
	local mapID = tonumber(msg) or C_Map.GetBestMapForUnit("player")
	
	if ( C_Map.GetMapInfo(mapID) ) then
		local mapInfo = C_Map.GetMapInfo(mapID)
		local groupID = C_Map.GetMapGroupID(mapID)

		print(mapInfo.name, mapInfo.mapID, mapInfo.mapType, mapInfo.parentMapID, groupID)

		if ( mapInfo.parentMapID ) then
			local parentMapInfo = C_Map.GetMapInfo(mapInfo.parentMapID)
			print(parentMapInfo.name, parentMapInfo.mapID, parentMapInfo.mapType, parentMapInfo.parentMapID)
		end
	else
		print(msg.." is not a valid map id.")
	end
end
SLASH_MAPID1 = "/mapid"

-- Get Instance ID
SlashCmdList["INSTANCEID"] = function(msg)
	local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapID, instanceGroupSize = GetInstanceInfo()
	print(name, instanceMapID)
end
SLASH_INSTANCEID1 = "/instanceid"

-- Get current setting of a cvar.
SlashCmdList["GETCVAR"] = function(msg)
    if ( not msg or msg == "" ) then print("/getcvar [cvar]") return end

    local result = GetCVar(msg) or "CVar setting not found."
    print(result)
end
SLASH_GETCVAR1 = "/getcvar"

-- Get frame name.
SlashCmdList["FRAMENAME"] = function()
    local name = GetMouseFocus():GetName()

    if ( name ) then
        print(name)
    else
        print("This frame has no name!")
    end
end
SLASH_FRAMENAME1 = "/frame"
