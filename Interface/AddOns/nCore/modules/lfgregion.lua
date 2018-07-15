local _, nCore = ...

local strsplit = strsplit

local Brazil = {
    ["Azralon"] = true,
    ["Gallywix"] = true,
    ["Goldrinn"] = true,
    ["Nemesis"] = true,
    ["Tol Barad"] = true,
}

local Latin = {
    ["Ragnaros"] = true,
    ["Drakkari"] = true,
    ["Quel'Thalas"] = true,
}

local Oceanic = {
    ["Aman'Thul"] = true,
    ["Barthilas"] = true,
    ["Caelestrasz"] = true,
    ["Dath'Remar"] = true,
    ["Dreadmaul"] = true,
    ["Frostmourne"] = true,
    ["Gundrak"] = true,
    ["Jubei'Thos"] = true,
    ["Khaz'goroth"] = true,
    ["Nagrand"] = true,
    ["Saurfang"] = true,
    ["Thaurissan"] = true,
}

local function AddRegion(tooltip, name)
    local _, server = strsplit("-", name, 2)

    if ( Brazil[server] ) then
        tooltip:AddLine(" ")
        tooltip:AddLine("|cffffd200Region:|r |cffffffffBrazil|r")
        tooltip:Show()
    elseif ( Latin[server] ) then
        tooltip:AddLine(" ")
        tooltip:AddLine("|cffffd200Region:|r |cffffffffLatin America|r")
        tooltip:Show()
    elseif ( Oceanic[server] ) then
        tooltip:AddLine(" ")
        tooltip:AddLine("|cffffd200Region:|r |cffffffffOceanic|r")
        tooltip:Show()
    end
end

local function SetSearchEntryTooltip(tooltip, resultID, autoAcceptOption)
    local _, _, _, _, _, _, _, _, _, _, _, _, leaderName = C_LFGList.GetSearchResultInfo(resultID)
    if ( leaderName ) then
        AddRegion(tooltip, leaderName)
    end
end
hooksecurefunc("LFGListUtil_SetSearchEntryTooltip", SetSearchEntryTooltip)

local function LFGHook()
    if ( _G.LFGListApplicationViewerScrollFrameButton1 ) then
        local hooked = {}
        local OnEnter, OnLeave

        function OnEnter(self)
            if ( self.applicantID and self.Members ) then
                for i = 1, #self.Members do
                    local b = self.Members[i]
                    if ( not hooked[b] ) then
                        hooked[b] = 1
                        b:HookScript("OnEnter", OnEnter)
                        b:HookScript("OnLeave", OnLeave)
                    end
                end
            elseif ( self.memberIdx ) then
                local fullName = C_LFGList.GetApplicantMemberInfo(self:GetParent().applicantID, self.memberIdx)
                if ( fullName ) then
                    local hasOwner = GameTooltip:GetOwner()
                    if ( not hasOwner ) then
                        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                    end
                    AddRegion(GameTooltip, fullName)
                end
            end
        end
        function OnLeave(self)
            if ( self.applicantID or self.memberIdx ) then
                GameTooltip:Hide()
            end
        end

        for i = 1, 14 do
            local b = _G["LFGListApplicationViewerScrollFrameButton" .. i]
            b:HookScript("OnEnter", OnEnter)
            b:HookScript("OnLeave", OnLeave)
        end
    end
end

local function LFGRegion_OnEvent(self, event, ...)
    if ( event == "ADDON_LOADED" ) then
        local name = ...
        if ( name == "LFGRegion" ) then
            LFGHook()
        end
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", LFGRegion_OnEvent)
