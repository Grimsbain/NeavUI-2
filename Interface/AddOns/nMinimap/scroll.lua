local FriendScrollFrame = CreateFrame("ScrollingMessageFrame", nil)
FriendScrollFrame:SetSize(300, 300)
FriendScrollFrame:SetFontObject(GameFontNormal)
FriendScrollFrame:SetTextColor(1, 1, 1, 1)
FriendScrollFrame:SetJustifyH("LEFT")
FriendScrollFrame:SetInsertMode("BOTTOM")
FriendScrollFrame:SetJustifyV("TOP")
FriendScrollFrame:SetHyperlinksEnabled(false)
FriendScrollFrame:SetFading(false)
FriendScrollFrame:SetMaxLines(300)
FriendScrollFrame:SetBackdrop({
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Buttons\\WHITE8x8",
	tile = false, tileSize = 16, edgeSize = 1,
})
FriendScrollFrame:SetBackdropColor(1, 0, 0, .25)
FriendScrollFrame:SetBackdropBorderColor(1, 1, 1, 1)

local scrollBar = CreateFrame("Slider", nil, FriendScrollFrame, "UIPanelStretchableArtScrollBarTemplate")
scrollBar:Hide()

scrollBar:SetScript("OnValueChanged", function(self, value)
	local min, max = self:GetMinMaxValues();
	self:GetParent():SetScrollOffset(max - value)
end)

function nMinimapTab_ScrollFriends(self, delta)
	testFrame.messageFrame:SetScrollOffset(testFrame.messageFrame:GetScrollOffset() + delta);
end