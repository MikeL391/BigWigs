﻿------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.0")("Moam")
local L = AceLibrary("AceLocale-2.0"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "moam",

	adds_cmd = "adds",
	adds_name = "Adds Alert",
	adds_desc = "Warn for Adds",
	
	paralyze_cmd = "paralyze",
	paralyze_name = "Paralyze Alert",
	paralyze_desc = "Warn for Paralyze",

	starttrigger = "senses your fear.",
	startwarn = "Moam Enaged! 90 Seconds until adds!",
	addsbar = "Adds",
	addsincoming = "Adds incoming in %s seconds!",
	addstrigger = "drains your mana and turns to stone.",
	addswarn = "Adds spawned! Moam Paralyzed for 90 seconds!",
	paralyzebar = "Paralyze",
	returnincoming = "Moam unparalyzed in %s seconds!",
	returntrigger = "^Energize fades from Moam%.$",
	returnwarn = "Moam unparalyzed! 90 seconds until adds!",	
} end )

L:RegisterTranslations("deDE", function() return {
	starttrigger = "sp\195\188rt Eure Angst.",
	startwarn = "Moam enaged! 90 Sekunden bis Elementare kommen!",
	addsbar = "Elementare",
	addsincoming = "Elementare erscheinen in %s Sekunden!",
	addstrigger = "entzieht Euch Euer Mana und versteinert Euch.",
	addswarn = "Elementare! Moam paralysiert f\195\188r 90 Sekunden.",
	paralyzebar = "Paralyse",
	returnincoming = "Moam erwacht in %s Sekunden!",
	returntrigger = "^Energiezufuhr schwindet von Moam%.$",
	returnwarn = "Moam wach! 90 Sekunden bis Elementare kommen!",
} end )

L:RegisterTranslations("koKR", function() return {
	starttrigger = "당신의 공포를 알아챕니다.",
	startwarn = "모암 행동시작! 90초 후 정령 등장!",
	addsbar = "정령 등장",
	addsincoming = "%s초후 정령 등장!",
	addstrigger = "당신의 마나를 흡수하여 돌처럼 변합니다.",
	addswarn = "정령 등장! 모암 90초간 멈춤!",
	paralyzebar = "모암 멈춤",
	returnincoming = "%s초후 모암 행동 재개!",
	returntrigger = "모암의 몸에서 마력 충전 효과가 사라졌습니다.",
	returnwarn = "모암 행동 재개! 90초 후 정령 등장!",
} end )

L:RegisterTranslations("zhCN", function() return {
	adds_name = "增援警报",
	adds_desc = "敌人增援出现时发出警报",
	
	paralyze_name = "石化警报",
	paralyze_desc = "莫阿姆进入石化状态时发出警报",

	starttrigger = "感觉到了你的恐惧。",
	startwarn = "莫阿姆已激活 - 90秒后敌人增援出现",
	addsbar = "增援",
	addsincoming = "敌人增援将%s秒后出现！",
	addstrigger = "吸取了你的魔法能量，并变成了石头。",
	addswarn = "增援出现！莫阿姆石化90秒！",
	paralyzebar = "石化",
	returnincoming = "莫阿姆将在%s秒后解除石化！",
	returntrigger = "^充能效果从莫阿姆身上消失。$",
	returnwarn = "莫阿姆解除石化！90秒后敌人增援出现！",	
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

BigWigsMoam = BigWigs:NewModule(boss)
BigWigsMoam.zonename = AceLibrary("Babble-Zone-2.0")("Ruins of Ahn'Qiraj")
BigWigsMoam.enabletrigger = boss
BigWigsMoam.toggleoptions = {"adds", "paralyze", "bosskill"}
BigWigsMoam.revision = tonumber(string.sub("$Revision$", 12, -3))

------------------------------
--      Initialization      --
------------------------------

function BigWigsMoam:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath" )
end

function BigWigsMoam:AddsStart()
	if self.db.profile.adds then
		self:ScheduleEvent("BigWigs_Message", 30, format(L"addsincoming", 60), "Green")
		self:ScheduleEvent("BigWigs_Message", 60, format(L"addsincoming", 30), "Yellow")
		self:ScheduleEvent("BigWigs_Message", 75, format(L"addsincoming", 15), "Orange")
		self:ScheduleEvent("BigWigs_Message", 85, format(L"addsincoming", 5), "Red")
		self:TriggerEvent("BigWigs_StartBar", self, L"addsbar", 90, "Interface\\Icons\\Spell_Shadow_CurseOfTounges", "Green", "Yellow", "Orange", "Red") 
	end
end

function BigWigsMoam:CHAT_MSG_MONSTER_EMOTE( msg )
	if msg == L"starttrigger" then
		if self.db.profile.adds then self:TriggerEvent("BigWigs_Message", L"startwarn", "Red") end
		self:AddsStart()
	elseif msg == L"addstrigger" then
		if self.db.profile.adds then
			self:TriggerEvent("BigWigs_Message", L"addswarn", "Red")
		end
		if self.db.profile.paralyze then
			self:ScheduleEvent("BigWigs_Message", 30, format(L"returnincoming", 60), "Green")
			self:ScheduleEvent("BigWigs_Message", 60, format(L"returnincoming", 30), "Yellow")
			self:ScheduleEvent("BigWigs_Message", 75, format(L"returnincoming", 15), "Orange")
			self:ScheduleEvent("BigWigs_Message", 85, format(L"returnincoming", 5), "Red")
			self:TriggerEvent("BigWigs_StartBar", self, L"paralyzebar", 90, "Interface\\Icons\\Spell_Shadow_CurseOfTounges", "Green", "Yellow", "Orange", "Red")
		end
	end
end

function BigWigsMoam:CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS( msg )
	if string.find( msg, L"returntrigger") then
		if self.db.profile.paralyze then self:TriggerEvent("BigWigs_Message", L"returnwarn", "Red") end
		self:AddsStart()
	end
end