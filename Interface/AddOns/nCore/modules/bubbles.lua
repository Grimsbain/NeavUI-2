local _, nCore = ...

local select = select

local function SkinFrame(frame)
    for i = 1, select("#", frame:GetRegions()) do
        local region = select(i, frame:GetRegions())
        if ( region:GetObjectType() == "FontString" ) then
            frame.text = region
        else
            region:Hide()
        end
    end

    frame.text:SetFontObject("GameFontHighlight")
    frame.text:SetJustifyH("LEFT")

    -- frame:ClearAllPoints()
    -- frame:SetPoint("TOPLEFT", frame.text, -10, 25)
    -- frame:SetPoint("BOTTOMRIGHT", frame.text, 10, -10)
    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tileSize = 16,
        edgeSize = 16,
        insets = {left=3, right=3, top=3, bottom=3},
    })
    frame:SetBackdropColor(0, 0, 0, 1)
    frame:SetBackdropBorderColor(.5, .5, .5, 0.9)

    -- frame.sender = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    -- frame.sender:SetPoint("BOTTOMLEFT", frame.text, "TOPLEFT", 0, 4)
    -- frame.sender:SetJustifyH("LEFT")

    frame:HookScript("OnHide", function()
        frame.inUse = false
    end)
end

local function UpdateFrame(frame, guid, name)
    -- if ( not frame.text ) then
        -- SkinFrame(frame)
    -- end
    frame.inUse = true

    local class
    if ( guid ~= nil and guid ~= "" ) then
        _, class, _, _, _, _ = GetPlayerInfoByGUID(guid)
    end

    if ( name ) then
        local color = RAID_CLASS_COLORS[class] or { r = 0.5, g = 0.5, b = 0.5 }
        ActionStatusText:SetText(("|cFF%2x%2x%2x%s|r"):format(color.r * 255, color.g * 255, color.b * 255, name))
		-- frame.sender:SetText(("|cFF%2x%2x%2x%s|r"):format(color.r * 255, color.g * 255, color.b * 255, name))
        
		-- if ( frame.text:GetWidth() < frame.sender:GetWidth() ) then
            -- frame.text:SetWidth(frame.sender:GetWidth())
        -- end
    end
end

local function FindFrame(msg)
	-- print(msg, WorldFrame:GetNumChildren())
    for i = 1, WorldFrame:GetNumChildren() do
        local frame = select(i, WorldFrame:GetChildren())
		-- print(frame, select("#", frame:GetRegions()))
        -- if ( not frame:GetName() and not frame.inUse ) then
            for i = 1, select("#", frame:GetRegions()) do
                local region = select(i, frame:GetRegions())
				print(region:GetObjectType())
                if region:GetObjectType() == "FontString" then --and region:GetText() then --== msg then
                    print(region:GetText())
					return frame
                end
            end
        -- end
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_SAY")
f:RegisterEvent("CHAT_MSG_YELL")
f:RegisterEvent("CHAT_MSG_PARTY")
f:RegisterEvent("CHAT_MSG_PARTY_LEADER")
f:RegisterEvent("CHAT_MSG_MONSTER_SAY")
f:RegisterEvent("CHAT_MSG_MONSTER_YELL")
f:RegisterEvent("CHAT_MSG_MONSTER_PARTY")

f:SetScript("OnEvent", function(self, event, ...)
	-- print(event, ...)

	local message, sender, lang, channel, target, flag, zone, localid, name, instanceId, lineId, guidString, bnId, isMobile, isSubtitle, hideSenderInLetterbox = ...
	
	local frame = FindFrame(message)
	
	if ( frame ) then
		UpdateFrame(frame, guidString, sender)
	end
	-- local bubbles = {  }
	-- print(#bubbles, type(bubbles))
	-- for k, v in pairs(bubbles) do
		-- for a, b in pairs(v) do
			-- print(a,b)
		-- end
	-- end
	
	-- for _, frame in pairs(C_ChatBubbles.GetAllChatBubbles(false)) do
		-- if ( frame ) then
			-- -- print(frame:GetName())
			-- print(#frame)
			
			-- -- UpdateFrame(frame, guidString, sender)
		-- end
	-- end
end)