-- local _, nMinimap = ...

-- local holder = CreateFrame("FRAME", "ScrollFrameHolder", UIParent)
-- holder:SetSize(300, 150)
-- holder:SetPoint("CENTER")

-- local scrollFrame = CreateFrame("ScrollFrame", "TestScroll", holder, "UIPanelScrollFrameTemplate")
-- scrollFrame:SetPoint("TOPLEFT", holder)
-- scrollFrame:SetPoint("BOTTOMRIGHT", holder, 0, 2)

-- local scrollBar = _G[scrollFrame:GetName().."ScrollBar"]
-- scrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", -16, -16)
-- scrollBar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", -16, 16)

-- scrollFrame.scrollChild = CreateFrame("FRAME", "TestScrollChild")
-- scrollFrame.scrollChild:SetSize(300, 40*(12+5))
-- scrollFrame:SetScrollChild(scrollFrame.scrollChild)
