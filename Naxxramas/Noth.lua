local bboss = BabbleLib:GetInstance("Boss 1.2")
local metro = Metrognome:GetInstance("1")

BigWigsNoth = AceAddon:new({
	name          = "BigWigsNoth",
	cmd           = AceChatCmd:new({}, {}),

	zonename = BabbleLib:GetInstance("Zone 1.2")("Naxxramas"),
	enabletrigger = bboss("Noth the Plaguebringer"),
	bossname = bboss("Noth the Plaguebringer"),

	toggleoptions = GetLocale() == "koKR" and {
		notStartWarn = "시작 알림",
		notBlink = "점멸 경고",
		notBlink5Sec = "점멸 시간 경고",
		notBlinkBar = "점멸 타이머바",
		notTeleport = "순간이동 경고",
		notTeleport10Sec = "순간이동 10초전 경고",
		notTeleportBar = "순간이동 타이머바",
		notBosskill = "보스 사망 알림",
		notCurseWarn = "저주 경고",
		notCurseBar = "저주 타이머바",
	} or {
		notStartWarn = "Start warning",
		notBlink = "Blink warning",
		notBlink5Sec = "Blink 5-sec warning",
		notBlinkBar = "Blink timerbar",
		notTeleport = "Teleport warning",
		notTeleport10Sec = "Teleport 10-sec warning",
		notTeleportBar = "Teleport bar",
		notBosskill = "Boss death",
		notCurseWarn = "Curse warning",
		notCurseBar = "Curse timerbar",
	},
	optionorder = {"notStartWarn", "notCurseWarn", "notCurseBar", "notBlink", "notBlink5Sec", "notBlinkBar", "notTeleport", "notTeleport10Sec", "notTeleportBar", "notBosskill"},

	loc = GetLocale() == "deDE" and {
		disabletrigger = "Noth der Seuchenf\195\188rst stirbt.",		
		bosskill = "Noth der Seuchenf\195\188rst wurde besiegt!",

		starttrigger1 = "Sterbt, Eindringling!",
		starttrigger2 = "Ehre unserem Meister!",
		starttrigger3 = "Euer Leben ist verwirkt!",
		startwarn = "Noth engaged! 90 Sekunden bis Teleport!",

		blinktrigger = "Noth der Seuchenf\195\188rst bekommt 'Blinzeln'.",
		blinkwarn = "Stop DPS!",
		blinkwarn2 = "Blink in ~5 s!",
		blinkbar = "Blink",

		teleportwarn = "Teleport! Er ist auf dem Balkon!",
		teleportwarn2 = "Teleport in 10 Sekunden!",

		teleportbar = "Teleport!",
		backbar = "R\195\188ckteleport!",
		
		backwarn = "Er ist wieder im Raum! DPS f\195\188r %d Sekunden.",
		backwarn2 = "10 Sekunden bis R\195\188ckteleport!",
    
		cursetrigger = "von Fluch des Seuchenf\195\188rsten betroffen",
		cursewarn	 = "Fluch! N\195\164chster in ~55 Sekunden",
		curse10secwarn = "Fluch in ~10 Sekunden",
		
		cursebar = "Fluch",
	} 
		or GetLocale() == "koKR" and 
	{ 	
		disabletrigger = "역병술사 노스|1이;가; 죽었습니다.",		
		bosskill = "역병술사 노스를 물리쳤습니다!",

		starttrigger1 = "죽어라, 침입자들아!",
		starttrigger2 = "주인님께 영광을!",
		starttrigger3 = "너희 생명은 끝이다!",
		startwarn = "역병술사 노스와 전투 시작! 90초후 순간이동",		
	 	-- "이제 숨을 거두어라!",
		
		addtrigger = "일어나라,병사들이여! 다시 일어나 싸워라!",

		blinktrigger = "역병술사 노스|1이;가; 점멸 효과를 얻었습니다.",
		blinkwarn = "점멸! 공격 금지!",
		blinkwarn2 = "점멸 약 5초후!",
		blinkbar = "점멸",
		
		teleportwarn = "순간이동! 발코니에 위치!",
		teleportwarn2 = "순간이동 10초후!",

		teleportbar = "순간이동!",
		backbar = "방으로 복귀!",
		
		backwarn = "방으로 복귀! %d 초간 최대한 공격!!",
		backwarn2 = "10초후 방으로 복귀!",
		
		cursetrigger = "(.+)|1이;가; 역병술사의 저주에 걸렸습니다.",
		cursewarn	 = "저주! 다음 저주 약 55초후",
		curse10secwarn = "저주 약 10초후",
		
		cursebar = "다음 저주",	
	} or {
		disabletrigger = "Noth the Plaguebringer dies.",		
		bosskill = "Noth the Plaguebringer has been defeated!",

		starttrigger1 = "Die, trespasser!",
		starttrigger2 = "Glory to the master!",
		starttrigger3 = "Your life is forfeit!",
		startwarn = "Noth the Plaguebringer engaged! 90 seconds till teleport",
		
		addtrigger = "Rise, my soldiers! Rise and fight once more!",

		blinktrigger = "Noth the Plaguebringer gains Blink.",
		blinkwarn = "Blink! Stop DPS!",
		blinkwarn2 = "Blink in ~5 seconds!",
		blinkbar = "Blink",
		
		teleportwarn = "Teleport! He's on the balcony!",
		teleportwarn2 = "Teleport in 10 seconds!",

		teleportbar = "Teleport!",
		backbar = "Back in room!",
		
		backwarn = "He's back in the room! DPS Party for %d seconds!!",
		backwarn2 = "10 seconds until he's back in the room!",
		
		cursetrigger = "afflicted by Curse of the Plaguebringer",
		cursewarn	 = "Curse! next in ~55 seconds",
		curse10secwarn = "Curse in ~10 seconds",
		
		cursebar = "Next Curse",		
	},
})

function BigWigsNoth:Initialize()
	self.disabled = true
	self:TriggerEvent("BIGWIGS_REGISTER_MODULE", self)
end

function BigWigsNoth:Enable()
	self.disabled = nil
	self.timeroom = 90
	self.timebalcony = 70
	self.cursetime = 55
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	
	self:RegisterEvent("BIGWIGS_SYNC_NOTHBLINK")
	self:TriggerEvent("BIGWIGS_SYNC_THROTTLE", "NOTHBLINK", 5)
	
	self:RegisterEvent("BIGWIGS_SYNC_NOTHCURSE")
	self:TriggerEvent("BIGWIGS_SYNC_THROTTLE", "NOTHCURSE", 5)
	
	self:RegisterEvent("BIGWIGS_MESSAGE")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "Curse")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "Curse")

	metro:Unregister("BigWigs Noth ToBalcony")
	metro:Unregister("BigWigs Noth ToRoom")

	metro:Register("BigWigs Noth ToBalcony", self.teleportToBalcony, self.timeroom, self)
	metro:Register("BigWigs Noth ToRoom", self.teleportToRoom, self.timebalcony, self)
end

function BigWigsNoth:Disable()
	self.disabled = true
	self:UnregisterAllEvents()
	
	self:TriggerEvent("BIGWIGS_DELAYEDMESSAGE_CANCEL", self.loc.teleportwarn2)
	self:TriggerEvent("BIGWIGS_DELAYEDMESSAGE_CANCEL", self.loc.backwarn2)
	self:TriggerEvent("BIGWIGS_DELAYEDMESSAGE_CANCEL", self.loc.blinkwarn2)
	self:TriggerEvent("BIGWIGS_DELAYEDMESSAGE_CANCEL", self.loc.curse10sec)
	
	self:TriggerEvent("BIGWIGS_BAR_CANCEL", self.loc.blinkbar)
	self:TriggerEvent("BIGWIGS_BAR_CANCEL", self.loc.teleportbar)
	self:TriggerEvent("BIGWIGS_BAR_CANCEL", self.loc.backbar)
	self:TriggerEvent("BIGWIGS_BAR_CANCEL", self.loc.cursebar)
	
	self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_CANCEL", self.loc.cursebar, self.cursetime-25)
	self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_CANCEL", self.loc.cursebar, self.cursetime-10)
	self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_CANCEL", self.loc.blinkbar, 15)
	self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_CANCEL", self.loc.blinkbar, 25)
	
	metro:Unregister("BigWigs Noth ToBalcony")
	metro:Unregister("BigWigs Noth ToRoom")
	
	self.prior = nil
end

function BigWigsNoth:teleportToBalcony()
	if self.timeroom == 90 then
		self.timeroom = 110
		metro:ChangeRate("BigWigs Noth ToBalcony", self.timeroom)
	elseif self.timeroom == 110 then
		self.timeroom = 180
		metro:ChangeRate("BigWigs Noth ToBalcony", self.timeroom)
	end
	
	self:TriggerEvent("BIGWIGS_DELAYEDMESSAGE_CANCEL", self.loc.blinkwarn2)
	self:TriggerEvent("BIGWIGS_BAR_CANCEL", self.loc.blinkbar)
	self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_CANCEL", self.loc.blinkbar, 15)
	self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_CANCEL", self.loc.blinkbar, 25)
	self:TriggerEvent("BIGWIGS_DELAYEDMESSAGE_CANCEL", self.loc.curse5sec)
	self:TriggerEvent("BIGWIGS_BAR_CANCEL", self.loc.cursebar)
	self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_CANCEL", self.loc.cursebar, self.cursetime-25)
	self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_CANCEL", self.loc.cursebar, self.cursetime-10)

	if not self:GetOpt("notTeleport") then self:TriggerEvent("BIGWIGS_MESSAGE", self.loc.teleportwarn, "Red") end
	if not self:GetOpt("notTeleportBar") then self:TriggerEvent("BIGWIGS_BAR_START", self.loc.backbar, self.timebalcony, 0, "Orange", "Interface\\Icons\\Spell_Magic_LesserInvisibilty") end
	if not self:GetOpt("notTeleport10Sec") then self:TriggerEvent("BIGWIGS_DELAYEDMESSAGE_START", self.loc.backwarn2, self.timebalcony - 10) end
	metro:Stop("BigWigs Noth ToBalcony")
	metro:Start("BigWigs Noth ToRoom")
end

function BigWigsNoth:teleportToRoom()
	if self.timebalcony == 70 then
		self.timebalcony = 95
		metro:ChangeRate("BigWigs Noth ToRoom", self.timebalcony)
	elseif self.timebalcony == 95 then
		self.timebalcony = 120
		metro:ChangeRate("BigWigs Noth ToRoom", self.timebalcony)
	end	
	
	if not self:GetOpt("notTeleport") then self:TriggerEvent("BIGWIGS_MESSAGE", string.format(self.loc.backwarn, self.timeroom), "Red") end
	if not self:GetOpt("notTeleportBar") then self:TriggerEvent("BIGWIGS_BAR_START", self.loc.teleportbar, self.timeroom, 0, "Yellow", "Interface\\Icons\\Spell_Magic_LesserInvisibilty") end
	if not self:GetOpt("notTeleport10Sec") then self:TriggerEvent("BIGWIGS_DELAYEDMESSAGE_START", self.loc.teleportwarn2, self.timeroom - 10) end
	metro:Stop("BigWigs Noth ToRoom")
	metro:Start("BigWigs Noth ToBalcony")
end

function BigWigsNoth:CHAT_MSG_COMBAT_HOSTILE_DEATH()
	if (arg1 == self.loc.disabletrigger) then
		if (not self:GetOpt("notBosskill")) then self:TriggerEvent("BIGWIGS_MESSAGE", self.loc.bosskill, "Green", nil, "Victory") end
		self:Disable()
	end
end

function BigWigsNoth:BIGWIGS_SYNC_NOTHCURSE()
	if not self:GetOpt("notCurseWarn") then 
		self:TriggerEvent("BIGWIGS_MESSAGE", self.loc.cursewarn, "Red", nil, "Alarm")
		self:TriggerEvent("BIGWIGS_DELAYEDMESSAGE_START", self.loc.curse10secwarn, self.cursetime-10,  "Orange")
	end
	if not self:GetOpt("notCurseBar") then
		self:TriggerEvent("BIGWIGS_BAR_START", self.loc.cursebar, self.cursetime, 1, "Green", "Interface\\Icons\\Spell_Shadow_AnimateDead") 
		self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_START", self.loc.cursebar, self.cursetime-25, "Orange")
		self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_START", self.loc.cursebar, self.cursetime-10, "Red")
	end	
	self.prior = true
end

function BigWigsNoth:Curse()
	if (string.find(arg1, self.loc.cursetrigger) and not self.prior) then
		self:TriggerEvent("BIGWIGS_SYNC_SEND", "NOTHCURSE")
	end
end

function BigWigsNoth:CHAT_MSG_MONSTER_YELL()
	if (arg1 == self.loc.starttrigger1 or arg1 == self.loc.starttrigger2 or arg1 == self.loc.starttrigger3) then
		self.timeroom = 90
		self.timebalcony = 70
		metro:ChangeRate("BigWigs Noth ToBalcony", self.timeroom )
		metro:ChangeRate("BigWigs Noth ToRoom", self.timebalcony )
		if not self:GetOpt("notStartWarn") then self:TriggerEvent("BIGWIGS_MESSAGE", self.loc.startwarn, "Red") end
		if not self:GetOpt("notTeleportBar") then self:TriggerEvent("BIGWIGS_BAR_START", self.loc.teleportbar, self.timeroom, 0, "Yellow", "Interface\\Icons\\Spell_Magic_LesserInvisibilty") end
		if not self:GetOpt("notTeleport10Sec") then self:TriggerEvent("BIGWIGS_DELAYEDMESSAGE_START", self.loc.teleportwarn2, self.timeroom - 10, "Orange") end

		metro:Start("BigWigs Noth ToBalcony")
	end
end

function BigWigsNoth:BIGWIGS_SYNC_NOTHBLINK()
	if not self:GetOpt("notBlink") then self:TriggerEvent("BIGWIGS_MESSAGE", self.loc.blinkwarn, "Red") end
	if not self:GetOpt("notBlinkBar") then 
		self:TriggerEvent("BIGWIGS_BAR_START", self.loc.blinkbar, 30, 2, "Green", "Interface\\Icons\\Spell_Arcane_Blink")
		self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_START", self.loc.blinkbar, 15, "Orange")
		self:TriggerEvent("BIGWIGS_BAR_DELAYEDSETCOLOR_START", self.loc.blinkbar, 25, "Red")
		
	end
	if not self:GetOpt("notBlink5Sec") then self:TriggerEvent("BIGWIGS_DELAYEDMESSAGE_START", self.loc.blinkwarn2, 25, "Yellow" ) end
end

function BigWigsNoth:CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS()
	if (arg1 == self.loc.blinktrigger) then
		self:TriggerEvent("BIGWIGS_SYNC_SEND", "NOTHBLINK")
	end
end

function BigWigsNoth:BIGWIGS_MESSAGE(text)
	if text == self.loc.curse10secwarn then self.prior = nil end
end
--------------------------------
--      Load this bitch!      --
--------------------------------
BigWigsNoth:RegisterForLoad()