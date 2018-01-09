-- SPAMFilter v2.0 by Darkspy - upgraded by mudzereli for Warmane

filteredMessageCount = 0
lastSpamTime = GetTime()
lastBlockedMSG = ""
minSecondsBetweenSpam = 90
filteredCountPVP = 0
filteredCountTrade = 0
filteredCountGuild = 0
filteredCountRaids = 0
filteredCountHeroics = 0
filteredCountQuests = 0
filteredCountMemes = 0
filteredCountLowLevel = 0
filteredCountNormals = 0

cGreen = "|cff2ecc71"
cRed = "|cffe74c3c"
cOrange = "|cfff39c12"

-- SAVED VARIABLES: these variables are defined in toc as SavedVariables and persist between sessions
filterSPAM = true
spamBlockPVP = false
spamBlockTrade = false
spamBlockGuild = false
spamBlockRaids = false
spamBlockHeroics = false
spamBlockQuests = false
spamBlockMemes = true
spamBlockLowLevel = false
spamBlockNormals = false
verbose = false

-- FUNCTION: SlashCmdList: defines behavior for when slash command (/sf) is typed
SLASH_SPAMFILTER1 = "/sf"
SlashCmdList["SPAMFILTER"] = function(msg)
	if msg == "toggle" or msg == "tog" or msg == "tg" then
		filterSPAM = not filterSPAM
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r SPAM filter "..EnabledBoolean(filterSPAM))
	elseif msg == "pvp" or msg == "p" then
		msg = "pvp"
		spamBlockPVP = not spamBlockPVP
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r ".. msg:upper() .." SPAM filtering "..EnabledBoolean(spamBlockPVP))
	elseif msg == "trade" or msg == "ts" or msg == "t" then
		msg = "trade"
		spamBlockTrade = not spamBlockTrade
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r ".. msg:upper() .." SPAM filtering "..EnabledBoolean(spamBlockTrade))
	elseif msg == "guild" or msg == "g" then
		msg = "guild"
		spamBlockGuild = not spamBlockGuild
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r ".. msg:upper() .." SPAM filtering "..EnabledBoolean(spamBlockGuild))
	elseif msg == "raid" or msg == "r" then
		msg = "raid"
		spamBlockRaids = not spamBlockRaids
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r ".. msg:upper() .." SPAM filtering "..EnabledBoolean(spamBlockRaids))
	elseif msg == "heroic" or msg == "hero" or msg == "hc" or msg == "h" then
		msg = "heroic"
		spamBlockHeroics = not spamBlockHeroics
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r ".. msg:upper() .." SPAM filtering "..EnabledBoolean(spamBlockHeroics))
	elseif msg == "quest" or msg == "q" then
		msg = "quest"
		spamBlockQuests = not spamBlockQuests
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r ".. msg:upper() .." SPAM filtering "..EnabledBoolean(spamBlockQuests))
	elseif msg == "meme" or msg == "m" then
		msg = "meme"
		spamBlockMemes = not spamBlockMemes
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r ".. msg:upper() .." SPAM filtering "..EnabledBoolean(spamBlockMemes))
	elseif msg == "low" or msg == "l" then
		msg = "low"
		spamBlockLowLevel = not spamBlockLowLevel
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r ".. msg:upper() .." SPAM filtering "..EnabledBoolean(spamBlockLowLevel))
	elseif msg == "normal" or msg == "norm" or msg == "nm" or msg == "n" then
		msg = "normal"
		spamBlockNormals = not spamBlockNormals
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r ".. msg:upper() .." SPAM filtering "..EnabledBoolean(spamBlockNormals))
	elseif msg == "verbose" or msg == "verb" or msg == "v" then
		msg = "verbose"
		verbose = not verbose
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r ".. msg:upper() .." SPAM filtering "..EnabledBoolean(verbose))
	elseif msg == "blocked" or msg == "block" or msg == "b" then
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r Blocked "..cRed..filteredMessageCount.."|r SPAM messages so far this session...")
	else
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r List of commands")
		DEFAULT_CHAT_FRAME:AddMessage("("..cRed..filteredMessageCount.."|r) |r"..cOrange.."/sf blocked|r:               Show total # of blocked messages|r")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(filterSPAM).."] |r"..cOrange.."/sf toggle|r:         toggle entire SPAM filtering engine ON/OFF.")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(verbose).."] |r"..cOrange.."/sf verbose|r:     toggle displaying of filtered messages.")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockMemes).."] "..cOrange.."/sf meme|r:     toggle MEME filtering. ("..cRed..filteredCountMemes.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockPVP).."] "..cOrange.."/sf pvp|r:         toggle PVP filtering. ("..cRed..filteredCountPVP.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockTrade).."] "..cOrange.."/sf trade|r:      toggle TRADE filtering. ("..cRed..filteredCountTrade.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockGuild).."] "..cOrange.."/sf guild|r:       toggle GUILD filtering. ("..cRed..filteredCountGuild.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockRaids).."] "..cOrange.."/sf raid|r:         toggle RAID filtering. ("..cRed..filteredCountRaids.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockNormals).."] "..cOrange.."/sf normal|r:    toggle NORMAL DNG filtering. ("..cRed..filteredCountNormals.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockHeroics).."] "..cOrange.."/sf heroic|r:     toggle HEROIC DNG filtering. ("..cRed..filteredCountHeroics.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockQuests).."] "..cOrange.."/sf quest|r:      toggle QUEST filtering. ("..cRed..filteredCountQuests.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockLowLevel).."] "..cOrange.."/sf low|r:          toggle LOW LEVEL filtering. ("..cRed..filteredCountLowLevel.."|r)")
	end
end

-- FUNCTION: SPAMFilter_OnLoad: called when addon is started
function SPAMFilter_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter Loaded:|r type /sf for options. Brought to you by "..cGreen.."https://legacy-wow.com|r, updated by "..cOrange.."mudzereli|r.")
end

-- FUNCTION: SpamFilter: does the work of filtering chat events
local function SpamFilter(msg, player, channelstring, target, ...)
	DEFAULT_CHAT_FRAME:AddMessage(channelstring);
	local badMSG = false
	local badMSGType = nil
	if (filterSPAM) then 
		if msg == lastBlockedMSG then
			return true
		end
		if(spamBlockPVP) then
			if(msg:match("[235][VvXx][235]") 
					or msg:match("[235][Vv][Ss][235]")
					or msg:match("[235][Oo][Nn][235]")
					or msg:match("[235] [Oo][Nn] [235]")
					or msg:match("[235] [Vv][Ss] [235]")
					or msg:match("[235] [Vv] [235]")
					or msg:match("[Aa]rena")
					or msg:match(" [235]'s")
					or msg:match(" [235]s")
					or msg:match("[Pp][Rr][Ee][Mm][Aa][Dd][Ee]")) then
				badMSG = true
				badMSGType = "PVP"
				filteredCountPVP = filteredCountPVP + 1
			end
		end
		if(spamBlockLowLevel) then
			if(msg:match("[Ss][Tt][Oo][Cc][Kk][Aa]")
				or msg:match("[Dd]eadmine")
				or msg:match(" [Zz][Ff][%s%p]")
				or msg:match("[Ff][Aa][Rr][Rr][Aa][Kk]")) then
				badMSG = true
				badMSGType = "LOW"
				filteredCountLowLevel = filteredCountLowLevel + 1
			end
		end
		if(spamBlockMemes) then
			if(msg:match("[Aa][Nn][Aa][Ll] ")
				or msg:match("И")
				or msg:match("и")
				or msg:match("Д")
				or msg:match("д")
				or msg:match("Я")
				or msg:match("я")) then
				badMSG = true
				badMSGType = "MEME"
				filteredCountMemes = filteredCountMemes + 1
			end
		end
		if(spamBlockQuests) then
			if(msg:match("Divination: Goref")
				or msg:match("Wanted: ")
				or msg:match("Breaching the Path")
				or msg:match("[Rr][Ii][Nn][Gg] [Oo][Ff] [Bb][Ll][Oo][Oo][Dd]")
				or msg:match("Cipher of Damn")
				or msg:match("Dimensius the All%-Devouring")
				or msg:match("Zuluhead the Whacked")
				or msg:match("Deathblow to the Legion")) then
				badMSG = true
				badMSGType = "QUEST"
				filteredCountQuests = filteredCountQuests + 1
			end
		end
		if(spamBlockPVP) then
			if(msg:match("[235][vx][235]") 
					or msg:match("[Aa]rena")
					or msg:match(" [235]'[Ss]")
					or msg:match(" [235][Ss]")
					or msg:match("[Pp][Rr][Ee][Mm][Aa][Dd][Ee]")) then
				badMSG = true
				badMSGType = "PVP"
				filteredCountPVP = filteredCountPVP + 1
			end
		end
		if(spamBlockRaids) then
			if(msg:match("[Kk][Aa][Rr][Aa]") 
					or msg:match("[Kk][Hh][Aa][Rr][Aa]")
					or msg:match("[Nn][Ee][Tt][Hh][Ee][Rr]")
					or msg:match("[Gg][Rr][Uu][Uu][Ll]")
					or msg:match("[Nn][Ii][Gg][Hh][Tt][Bb][Aa][Nn][Ee]")
					or msg:match("SSC")) then
				badMSG = true
				badMSGType = "RAID"
				filteredCountRaids = filteredCountRaids + 1
			end
		end
		if(spamBlockTrade) then
			if(msg:match("[Ll][Ff][Ww]") 
					or msg:match("[Ww][Tt][TtSsBb]")
					or msg:match("[Ww] [Tt] [TtSsBb]")
					or msg:match("[Mm]arket")
					or msg:match(" [Cc][Oo][Ii][Nn]")
					or msg:match("[Ll]ockbox")
					or msg:match("[Ll]eatherwork")
					or msg:match("[Ee]nchant")
					or msg:match("[Ee]chant")
					or msg:match("[Cc]hant[%s%p]")
					or msg:match("[Tt]ransmute")
					or msg:match("[Aa]lch")
					or msg:match("[Bb][Ll][Aa][Cc][Kk][Ss][Mm][Ii]")
					or msg:match("[Tt]ailor")
					or msg:match("[Ll][Ff] [Bb][Ss] ")
					or msg:match("[Ll][Ff] [Jj][Cc] ")
					or msg:match("[Ll][Ff] [Ee][Nn][Cc][Hh]")
					or msg:match("[Ll][Ff] [Ee][Nn][Gg] ")
					or msg:match("[Ll][Ff] [Ee][Nn][Gg][Ii]")
					or msg:match("[Ss]ell")) then
				badMSG = true
				badMSGType = "TRADE"
				filteredCountTrade = filteredCountTrade + 1
			end
		end
		if(spamBlockNormals) then
			if(msg:match("[Nn]orm")
				or msg:match("[Nn]oramal")
				or msg:match("%([Nn]%)")
				or msg:match("%([Nn][Mm]%)")
				or msg:match("%([Nn]ormal%)")
				or msg:match("%([Nn]orm%)")
				or msg:match(" [Nn][Mm]")
				or msg:match("[Rr][Ee][Pp] [Ff][Aa][Rr][Mm]")
				or msg:match(" [Nn][%p%s$]")
				or msg:match(" N ")) then
				badMSG = true
				badMSGType = "NORMAL"
				filteredCountNormals = filteredCountNormals + 1
			end
		end
		if(spamBlockHeroics) then
			if(msg:match("%([Hh]%)") 
					or msg:match("%([Hh][Cc]%)")
					or msg:match("%([Hh][Ee][Rr][Oo][Ii][Cc]%)")
					or msg:match(" [Hh][Cc]")
					or msg:match(" [Hh][%p%s$]")
					or msg:match(" H ")
					or msg:match(" [Hh][Ee][Rr][Oo]")
					or msg:match(" [Hh][Ee][Rr][Oo][Ii][Cc]")) then
				badMSG = true
				badMSGType = "HEROIC"
				filteredCountHeroics = filteredCountHeroics + 1
			end
		end
		if(spamBlockGuild) then
			if(msg:match("[Gg][Uu][Ii][Ll][Dd]") 
					or msg:match("[Rr][Ee][Cc][Rr][Uu][Ii][Tt]")
					or msg:match("[Rr][Ee][Cc][Ll][Uu][Tt]")) then
				badMSG = true
				badMSGType = "GUILD"
				filteredCountGuild = filteredCountGuild + 1
			end
		end
		if (badMSG) then
			filteredMessageCount = filteredMessageCount + 1
			if (verbose) then
				DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r "..cRed..badMSGType.."|r SPAM " .. msg)
			end
			if(GetTime() - lastSpamTime >= minSecondsBetweenSpam) then
				DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r Blocked "..cRed..filteredMessageCount.."|r SPAM messages so far this session...")
				lastSpamTime = GetTime()
			end
			lastBlockedMSG = msg
		end
	end
	return badMSG
end	

-- FUNCTION: EnabledBoolean: converts true/false to colored green/red Enabled/Disabled
function EnabledBoolean(flag)
	if(flag) then
		return cGreen.."Enabled|r"
	else
		return cRed.."Disabled|r"
	end
end

-- Actually Load the addon & chat hooks
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", SpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", SpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", SpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", SpamFilter)
SPAMFilter_OnLoad()