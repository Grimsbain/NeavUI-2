local _, nMainbar = ...
local cfg = nMainbar.Config

local path = "Interface\\AddOns\\nMainbar\\Media\\"

	-- Functions

function nMainbar:IsTaintable()
	return (InCombatLockdown() or (UnitAffectingCombat("player") or UnitAffectingCombat("pet")))
end

	-- End Caps

if ( cfg.MainMenuBar.hideGryphons ) then
    MainMenuBarArtFrame.LeftEndCap:SetTexCoord(0, 0, 0, 0)
    MainMenuBarArtFrame.RightEndCap:SetTexCoord(0, 0, 0, 0)
end

	-- Fill Status Bar Gap

if ( not MainMenuBarArtFrame.BottomArt ) then
	MainMenuBarArtFrame.BottomArt = MainMenuBarArtFrame:CreateTexture("MainMenuBarBottomArt", "OVERLAY")
	MainMenuBarArtFrame.BottomArt:SetPoint("LEFT", MainMenuBarArtFrame.LeftEndCap, "RIGHT", -30, 0)
	MainMenuBarArtFrame.BottomArt:SetPoint("RIGHT", MainMenuBarArtFrame.RightEndCap, "LEFT", 30, 0)
	MainMenuBarArtFrame.BottomArt:SetPoint("BOTTOM", UIParent)
	MainMenuBarArtFrame.BottomArt:SetColorTexture(0.40 ,0.40 ,0.40, 1.0)
	MainMenuBarArtFrame.BottomArt:SetHeight(1)
end

	--  Update Action Bars

hooksecurefunc("MultiActionBar_Update", function(self)
	if ( nMainbar:IsTaintable() ) then return end

		-- Main / Vehicle Action Bars

	MainMenuBar:SetScale(cfg.MainMenuBar.scale)
	OverrideActionBar:SetScale(cfg.vehicleBar.scale)

		-- Right Bars Scale & Alpha

	MultiBarLeft:SetAlpha(cfg.multiBarRight.alpha)
	MultiBarLeft:SetScale(cfg.multiBarRight.scale)
	MultiBarRight:SetAlpha(cfg.multiBarRight.alpha)
	MultiBarRight:SetScale(cfg.multiBarRight.scale)

		-- Move Right Bars (Checks if player is using stacking right bar option.)

	if ( GetCVar("multiBarRightVerticalLayout") == "0" ) then
		VerticalMultiBarsContainer:ClearAllPoints()
		VerticalMultiBarsContainer:SetPoint("TOPRIGHT", UIParent, "RIGHT", -2, (VerticalMultiBarsContainer:GetHeight() / 2))
	end
end)

    -- Move ExtraActionButton

ExtraActionButton1:SetScript("OnShow", function(self)
    if ( nMainbar:IsTaintable() ) then return end

	ExtraActionButton1:ClearAllPoints()
	ExtraActionButton1:SetPoint("CENTER", UIParent, "CENTER", -300, -150)
end)

	-- Possess Bar

PossessBarFrame:SetScale(cfg.possessBar.scale)
PossessBarFrame:SetAlpha(cfg.possessBar.alpha)

	-- Stance Bar

StanceBarFrame:SetFrameStrata("MEDIUM")

StanceBarFrame:SetScale(cfg.stanceBar.scale)
StanceBarFrame:SetAlpha(cfg.stanceBar.alpha)

if ( cfg.stanceBar.hide ) then
	hooksecurefunc("StanceBar_Update", function()
		if ( StanceBarFrame:IsShown() and not nMainbar:IsTaintable() ) then
			RegisterStateDriver(StanceBarFrame, "visibility", "hide")
		end
	end)
end

	-- Pet Bar

PetActionBarFrame:SetFrameStrata("MEDIUM")

PetActionBarFrame:SetScale(cfg.petBar.scale)
PetActionBarFrame:SetAlpha(cfg.petBar.alpha)

if ( cfg.petBar.vertical ) then
    for i = 2, 10 do
        local button = _G["PetActionButton"..i]
        button:ClearAllPoints()
        button:SetPoint("TOP", _G["PetActionButton"..(i - 1)], "BOTTOM", 0, -8)
    end
end

hooksecurefunc("PetActionButton_SetHotkeys", function(self)
    local hotkey = _G[self:GetName().."HotKey"]
    if ( not cfg.button.showKeybinds ) then
        hotkey:Hide()
    end
end)

if ( not cfg.button.showKeybinds ) then
    for i = 1, NUM_PET_ACTION_SLOTS, 1 do
        local buttonName = _G["PetActionButton"..i]
        PetActionButton_SetHotkeys(buttonName)
    end
end
