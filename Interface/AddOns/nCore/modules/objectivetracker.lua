local objectiveTrackerFrame = _G["ObjectiveTrackerFrame"]
objectiveTrackerFrame:SetHeight(600)
objectiveTrackerFrame:SetClampedToScreen(true)
objectiveTrackerFrame:SetMovable(true)
objectiveTrackerFrame:SetUserPlaced(true)
objectiveTrackerFrame:ClearAllPoints()
objectiveTrackerFrame:SetPoint("TOPRIGHT", VerticalMultiBarsContainer, "TOPLEFT", -2, 0)

local minimizeButton = objectiveTrackerFrame.HeaderMenu.MinimizeButton
minimizeButton:EnableMouse(true)
minimizeButton:RegisterForDrag("LeftButton")
minimizeButton:SetHitRectInsets(-15, 0, -5, -5)
minimizeButton:SetScript("OnDragStart", function(self)
    if ( IsShiftKeyDown() ) then
        objectiveTrackerFrame:StartMoving()
    end
end)

minimizeButton:SetScript("OnDragStop", function(self)
    objectiveTrackerFrame:StopMovingOrSizing()
end)

minimizeButton:SetScript("OnEnter", function()
    if ( not InCombatLockdown() ) then
		GameTooltip:SetOwner(minimizeButton, "ANCHOR_TOPLEFT", 0, 10)
		GameTooltip:ClearLines()
		GameTooltip:AddLine("Shift + left-click to Drag")
        GameTooltip:Show()
    end
end)

minimizeButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)
