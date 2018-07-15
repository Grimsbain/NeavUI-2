-- Based on the Gathermate encoder.
local function EncodeLoc(x, y)
	if x > 0.9999 then
		x = 0.9999
	end
	if y > 0.9999 then
		y = 0.9999
	end
	return floor( x * 10000 + 0.5 ) * 1000000 + floor( y * 10000  + 0.5 ) * 100
end

local holder = CreateFrame("Frame", "GathermateData", UIParent, "BasicFrameTemplateWithInset")
holder:SetPoint("CENTER")
holder:SetSize(400, 250)
holder:EnableMouse(true)
holder:SetClampedToScreen(true)
holder:SetMovable(true)
holder:SetUserPlaced(true)
holder:RegisterForDrag("LeftButton")
holder:Hide()

holder:SetScript("OnDragStart", function(self)
    if ( IsShiftKeyDown() ) then
        self:StartMoving()
    end
end)

holder:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

local outputFrame = CreateFrame("ScrollFrame", "GathermateOutputBox", holder, "InputScrollFrameTemplate")
outputFrame:SetPoint("TOPLEFT", holder.InsetBg, 1, -1)
outputFrame:SetPoint("BOTTOMRIGHT", holder.InsetBg, -1, 1)
outputFrame:SetSize(400, 250)
outputFrame.EditBox:SetFontObject("ChatFontNormal")
outputFrame.EditBox:SetSize(400, 250)

outputFrame.TopLeftTex:SetTexture(nil)
outputFrame.TopRightTex:SetTexture(nil)
outputFrame.TopTex:SetTexture(nil)
outputFrame.BottomLeftTex:SetTexture(nil)
outputFrame.BottomRightTex:SetTexture(nil)
outputFrame.BottomTex:SetTexture(nil)
outputFrame.LeftTex:SetTexture(nil)
outputFrame.RightTex:SetTexture(nil)
outputFrame.MiddleTex:SetTexture(nil)

-- DATA

local zone = 882
local nodeID = 260
local foundCoord = "["..zone.."] = {"

local locations = {
{20.1,40.4},{20.8,39.6},{33.9,55.1},{34.1,56.4},{34.1,62.6},{34.2,42},{34.6,40.7},{35.1,44.4},{35.1,44.6},{35.2,39.1},{35.2,46.3},{36.3,54.6},{36.9,55.5},{37,42.6},{37.4,54.6},{37.5,54.6},{37.7,48.5},{37.8,53.3},{38.7,51},{39.2,55.2},{39.5,49.4},{40.3,8.9},{40.8,51.7},{41.6,16.1},{42.4,55.9},{42.6,51.5},{42.6,72},{42.7,61.1},{42.7,64.8},{42.8,49.6},{42.8,51.4},{42.9,18.6},{43,62.3},{43.1,70.2},{43.4,14.4},{43.4,14.5},{43.5,52.9},{44,12.8},{44.2,16.9},{44.6,47.6},{45.6,52.4},{45.7,20.6},{46.7,54.4},{47.4,50.5},{47.8,53.1},{48.6,11},{49.6,10.6},{49.6,52.8},{49.7,78},{50.9,53.9},{51.2,80.1},{52.1,81.6},{52.3,81.4},{53.4,8.9},{53.5,9.1},{55.1,10.9},{56.9,10.3},{61,30.2},{61.1,31.6},{61.8,33.9},{62.2,36.6},{63.3,38.9},{64.2,40.6},{65.6,61.4},{65.6,61.5},{66.5,59.6},{67.9,42.3},{68.6,54.6},{69.3,53.3},{69.9,41.4},{71.4,37.5},{72.1,35.6},{73.1,37.9}
}

for id, location in pairs(locations) do
	local x, y = location[1], location[2]
	foundCoord = foundCoord.."\n["..EncodeLoc(x/100, y/100).."] = "..nodeID..","
end

foundCoord = foundCoord.."\n},"
outputFrame.EditBox:SetText(foundCoord)
