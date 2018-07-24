local _, nCore = ...

local function UpdateQuestText(self)
	local _, numQuests = GetNumQuestLogEntries()
    WorldMapFrameTitleText:SetFormattedText("%s - %d/%s", MAP_AND_QUEST_LOG, numQuests, MAX_QUESTS)
end

function nQuests_OnLoad(self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("QUEST_ACCEPT_CONFIRM")
	self:RegisterEvent("QUEST_ACCEPTED")
	self:RegisterEvent("QUEST_AUTOCOMPLETE")
	self:RegisterEvent("QUEST_LOG_UPDATE")
	self:RegisterEvent("QUEST_REMOVED")

	UpdateQuestText(self)
end

function nQuests_OnEvent(self, event, ...)
	UpdateQuestText(self)
end
