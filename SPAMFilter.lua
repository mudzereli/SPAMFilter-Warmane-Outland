-- SPAMFilter v2.0 by Darkspy - upgraded by mudzereli for Warmane

lastSpamTime = GetTime()
lastBlockedMSG = ""
lastUnblockedMSG = ""
minSecondsBetweenSpam = 90
filteredMessageCount = 0
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
spamBlockPVP = true
spamBlockTrade = false
spamBlockGuild = true
spamBlockRaids = false
spamBlockHeroics = false
spamBlockQuests = true
spamBlockLanguage = true
spamBlockLowLevel = true
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
	elseif msg == "lang" or msg == "lng" or msg == "lg" then
		msg = "lang"
		spamBlockLanguage = not spamBlockLanguage
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r ".. msg:upper() .." SPAM filtering "..EnabledBoolean(spamBlockLanguage))
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
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r Blocked "..cRed..filteredMessageCount.."|r SPAM messages so far this session.")
	elseif msg == "clear" or msg == "clr" or msg == "c" then
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r Cleared "..cRed..filteredMessageCount.."|r blocked SPAM messages.")
		filteredMessageCount = 0
		filteredCountPVP = 0
		filteredCountTrade = 0
		filteredCountGuild = 0
		filteredCountRaids = 0
		filteredCountHeroics = 0
		filteredCountQuests = 0
		filteredCountMemes = 0
		filteredCountLowLevel = 0
		filteredCountNormals = 0
	else
		DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r List of commands")
		DEFAULT_CHAT_FRAME:AddMessage("("..cRed..filteredMessageCount.."|r) |r"..cOrange.."/sf blocked|r:               Show total # of blocked messages|r")
		DEFAULT_CHAT_FRAME:AddMessage("("..cRed..filteredMessageCount.."|r) |r"..cOrange.."/sf clear|r:                    Clear blocked message count.")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(filterSPAM).."] |r"..cOrange.."/sf toggle|r:         Toggle entire SPAM filtering engine ON/OFF.")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(verbose).."] |r"..cOrange.."/sf verbose|r:     Toggle displaying of filtered messages.")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockLanguage).."] "..cOrange.."/sf lang|r:       Toggle LANGUAGE filtering. ("..cRed..filteredCountMemes.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockPVP).."] "..cOrange.."/sf pvp|r:         Toggle PVP filtering. ("..cRed..filteredCountPVP.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockTrade).."] "..cOrange.."/sf trade|r:      Toggle TRADE filtering. ("..cRed..filteredCountTrade.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockGuild).."] "..cOrange.."/sf guild|r:       Toggle GUILD filtering. ("..cRed..filteredCountGuild.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockRaids).."] "..cOrange.."/sf raid|r:         Toggle RAID filtering. ("..cRed..filteredCountRaids.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockNormals).."] "..cOrange.."/sf normal|r:    Toggle NORMAL DNG filtering. ("..cRed..filteredCountNormals.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockHeroics).."] "..cOrange.."/sf heroic|r:     Toggle HEROIC DNG filtering. ("..cRed..filteredCountHeroics.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockQuests).."] "..cOrange.."/sf quest|r:      Toggle QUEST filtering. ("..cRed..filteredCountQuests.."|r)")
		DEFAULT_CHAT_FRAME:AddMessage("["..EnabledBoolean(spamBlockLowLevel).."] "..cOrange.."/sf low|r:          Toggle LOW LEVEL filtering. ("..cRed..filteredCountLowLevel.."|r)")
	end
end

-- FUNCTION: SPAMFilter_OnLoad: called when addon is started
function SPAMFilter_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter Loaded:|r type /sf for options. Brought to you by "..cGreen.."https://legacy-wow.com|r, updated by "..cOrange.."mudzereli|r.")
end

-- FUNCTION: SpamFilter: does the work of filtering chat events
local function SpamFilter(msg, player, channelstring, target, ...)
	local badMSG = false
	local badMSGType = nil
	if (filterSPAM) then 
		if msg == lastBlockedMSG then
			return true
		end
		if(spamBlockPVP) then
			if(msg:match("^[235]%s*[VvNnOoXxSsNnCc]+%s*[235]%W+")
					or msg:match("%W+[235]%s*[VvNnOoXxSsNnCc]+%s*[235]%W+")
					or msg:match("%W+[235]%s*[VvNnOoXxSsNnCc]+%s*[235]$")
					or msg:match("^[235][']*[Ss]%W+")
					or msg:match("%W+[235][']*[Ss]%W+")
					or msg:match("%W+[235][']*[Ss]$")
					or msg:match("^[Pp]%s*[Vv]%s*[Pp]%W+")
					or msg:match("%W+[Pp]%s*[Vv]%s*[Pp]%W+")
					or msg:match("%W+[Pp]%s*[Vv]%s*[Pp]$")
					or msg:match("^[Pp][Rr][Ee][Mm][Aa][Dd][Ee][Ss]?%W+")
					or msg:match("%W+[Pp][Rr][Ee][Mm][Aa][Dd][Ee][Ss]?%W+")
					or msg:match("%W+[Pp][Rr][Ee][Mm][Aa][Dd][Ee][Ss]?$")
					or msg:match("^[Aa][Rr][Ee][Nn][Aa][Ss]?%W+")
					or msg:match("%W+[Aa][Rr][Ee][Nn][Aa][Ss]?%W+")
					or msg:match("%W+[Aa][Rr][Ee][Nn][Aa][Ss]?$")
					or msg:match("^[Tt][Ee][Aa][Mm]%W+")
					or msg:match("%W+[Tt][Ee][Aa][Mm]%W+")
					or msg:match("%W+[Tt][Ee][Aa][Mm]$")
					or msg:match("10%s*[Gg][Aa][Mm][Ee][Ss]*%W+")
					or msg:match("10%s*[Gg][Aa][Mm][Ee][Ss]*$")) then
				badMSG = true
				badMSGType = "PVP"
				filteredCountPVP = filteredCountPVP + 1
			end
		end
		if(spamBlockLowLevel) then
			if(msg:match("^[Ss][Tt][Oo][Cc][Kk]")
				or msg:match("%W+[Ss][Tt][Oo][Cc][Kk]")
				or msg:match("^[Dd][Ee][Aa][Dd][Mm][Ii][Nn]")
				or msg:match("%W+[Dd][Ee][Aa][Dd][Mm][Ii][Nn]")
				or msg:match("^[Gg][Nn][Oo][Mm][Ee][Rr]")
				or msg:match("%W+[Gg][Nn][Oo][Mm][Ee][Rr]")
				or msg:match("^[Uu][Ll][Dd][AaUu][Mm][OoAa][Nn]")
				or msg:match("%W+[Uu][Ll][Dd][AaUu][Mm][OoAa][Nn]")
				or msg:match("^[Ss][Mm]%W+")
				or msg:match("%W+[Ss][Mm]%W+")
				or msg:match("%W+[Ss][Mm]$")
				or msg:match("^[Zz][Ff]%W+")
				or msg:match("%W+[Zz][Ff]%W+")
				or msg:match("%W+[Zz][Ff]$")
				or msg:match("^[Ss][Tt]%W+")
				or msg:match("%W+[Ss][Tt]%W+")
				or msg:match("%W+[Ss][Tt]$")
				or msg:match("[Ff][Aa][Rr][Rr]*[Aa][Kk]")) then
				badMSG = true
				badMSGType = "LOW"
				filteredCountLowLevel = filteredCountLowLevel + 1
			end
		end
		if(spamBlockLanguage) then
			if(msg:match("[Aa][Nn][Aa][Ll]%s+")
				or msg:match("[ИиДдЯяωѡѠƜШᥕϢᘺաɰպɯЩաшᶭщ౻ᵚயധÄäÖöÜüß]")) then
				badMSG = true
				badMSGType = "LANGUAGE"
				filteredCountMemes = filteredCountMemes + 1
			end
		end
		if(spamBlockQuests) then
			if(msg:match("Divination: Goref")
				or msg:match("[Ww][Aa][Nn][Tt][Ee][Dd]%W+")
				or msg:match("Breaching the Path")
				or msg:match("[Rr][Ii][Nn][Gg]%s+[Oo][Ff]%s+[Bb][Ll][Oo][Oo][Dd]")
				or msg:match("Cipher of Damn")
				or msg:match("Dimensius the All%-Devouring")
				or msg:match("Battle of the Crimson Watch")
				or msg:match("Gurok the Usurper")
				or msg:match("[Tt][Rr][Ii][Aa][Ll]%s+[Oo][Ff][Tt]?[Hh]?[Ee]?%s*[Nn][Aa][Aa][Rr][Uu]")
				or msg:match("Zuluhed the Whacked")
				or msg:match("Breaking Down Netherrock")
				or msg:match("%[Overlord%]")
				or msg:match("[Dd]urn%s?[Tt]he%s?[Hh]ungerer")
				or msg:match("Deathblow to the Legion")) then
				badMSG = true
				badMSGType = "QUEST"
				filteredCountQuests = filteredCountQuests + 1
			end
		end
		if(spamBlockRaids) then
			if(msg:match("^[Kk][Hh]*[Aa][Rr][Aa][Zz]?[AaHh]*[Nn]?%W+")
				or msg:match("%W+[Kk][Hh]*[Aa][Rr][Aa][Zz]?[AaHh]*[Nn]?%W+")
				or msg:match("%W+[Kk][Hh]*[Aa][Rr][Aa][Zz]?[AaHh]*[Nn]?$")
				or msg:match("^[Kk][Zz]%W+")
				or msg:match("%W+[Kk][Zz]*%W+")
				or msg:match("%W+[Kk][Zz]*$")
				or msg:match("^[Ss][Ss][Cc]%W+")
				or msg:match("%W+[Ss][Ss][Cc]*%W+")
				or msg:match("%W+[Ss][Ss][Cc]*$")
				or msg:match("[Mm][Aa][Gg][ThGg][EeYy]")
				or msg:match("[Nn][Ee][Tt][Hh][Ee][Rr][Ss][Pp]")
				or msg:match("[Gg][Rr][Uu]+[Ll]")
				or msg:match("[Nn][Ii][Gg][Hh][Tt][Bb][Aa][Nn][Ee]")) then
				badMSG = true
				badMSGType = "RAID"
				filteredCountRaids = filteredCountRaids + 1
			end
		end
		if(spamBlockTrade) then
			if(msg:match("[Ll][Ff][Ww]") 
					-- Jewelcrafting
					or msg:match("^[Jj][Ee]?[Ww]?[Ee]?[Ll]?[Cc][Rr]?[Aa]?[Ff]?[Tt]?[EeIi]?[RrNn]?[Gg]?%W+")
					or msg:match("%W+[Jj][Ee]?[Ww]?[Ee]?[Ll]?[Cc][Rr]?[Aa]?[Ff]?[Tt]?[EeIi]?[RrNn]?[Gg]?*%W+")
					or msg:match("%W+[Jj][Ee]?[Ww]?[Ee]?[Ll]?[Cc][Rr]?[Aa]?[Ff]?[Tt]?[EeIi]?[RrNn]?[Gg]?*$")
					-- Leatherworking
					or msg:match("^[Ll][Ee]?[Aa]?[Tt]?[Hh]?[Ee]?[Rr]?[Ww][Oo]?[Rr]?[Kk]?[EeIi]?[RrNn]?[Gg]?%W+")
					or msg:match("%W+[Ll][Ee]?[Aa]?[Tt]?[Hh]?[Ee]?[Rr]?[Ww][Oo]?[Rr]?[Kk]?[EeIi]?[RrNn]?[Gg]?*%W+")
					or msg:match("%W+[Ll][Ee]?[Aa]?[Tt]?[Hh]?[Ee]?[Rr]?[Ww][Oo]?[Rr]?[Kk]?[EeIi]?[RrNn]?[Gg]?*$")
					-- Engineering
					or msg:match("^[EeIi][Nn][Gg][EeIi]?[Nn]?[Ee]?[Ee]?[Rr]?[Ii]?[Nn]?[Gg]?%W+")
					or msg:match("%W+[EeIi][Nn][Gg][EeIi]?[Nn]?[Ee]?[Ee]?[Rr]?[Ii]?[Nn]?[Gg]?*%W+")
					or msg:match("%W+[EeIi][Nn][Gg][EeIi]?[Nn]?[Ee]?[Ee]?[Rr]?[Ii]?[Nn]?[Gg]?*$")
					or msg:match("[Ww]%s*[Tt]%s*[TtSsBb]")
					or msg:match("[Mm]arket")
					or msg:match("%A+[Cc][Oo][Ii][Nn]")
					or msg:match("[Ll]ockbox")
					or msg:match("[Ee][Nn]?[Cc][Hh][AaEe][Nn][Tt]")
					or msg:match("^[Cc][Rr][Aa][Ff][Tt]")
					or msg:match("%W+[Cc][Rr][Aa][Ff][Tt]")
					or msg:match("[%W]+[Bb]uy[%W]*")
					or msg:match("[Bb]uying")
					or msg:match("[Cc]hant[%s%p]")
					or msg:match("[Tt]ransmute")
					or msg:match("[Aa]lch")
					or msg:match("[Bb][Ll][Aa][Cc][Kk][Ss][Mm][Ii]")
					or msg:match("[Tt][Aa][Ii][Ll][Oo][Rr]")
					or msg:match("[Ll][Ff]%s*[Bb][Ss][%W]+")
					or msg:match("%W+your mats%W+")
					or msg:match("[Ss]ell")) then
				badMSG = true
				badMSGType = "TRADE"
				filteredCountTrade = filteredCountTrade + 1
			end
		end
		if(spamBlockNormals) then
			if(msg:match("^[Nn][Oo]?[Rr]?[Mm]?[Aa]?[Ll]?[Ss]?%s+")
				or msg:match("[%s%(]+[Nn][Oo]?[Rr]?[Mm]?[Aa]?[Ll]?[Ss]?[%s%)%-,!]+")
				or msg:match("%s+[Nn][Oo]?[Rr]?[Mm]?[Aa]?[Ll]?[Ss]?$")
				or msg:match("%W+dps for SHHn$")
				or msg:match("%W+[Ss][Ss]?[Hh]%W+")
				or msg:match("%W+[Oo][Hh][Ff]%W+")
				or msg:match("%W+[Aa][Rr][Cc][Aa]?[Tt]?[Rr]?[Aa]?[Zz]?%W+")
				or msg:match("%W+[Rr][Ee][Pp]%s*[FfRr][AaUu][RrNn]")) then
				badMSG = true
				badMSGType = "NORMAL"
				filteredCountNormals = filteredCountNormals + 1
			end
		end
		if(spamBlockHeroics) then
			if(msg:match("^[Hh][Ee]?[Rr]?[Oo]?[Ii]?[Cc]?%s+")
				or msg:match("[%s%(%-]+[Hh][Ee]?[Rr]?[Oo]?[Ii]?[Cc]?[%s%)%-,!]+")
				or msg:match("%s+[Hh][Ee]?[Rr]?[Oo]?[Ii]?[Cc]?$")) then
				badMSG = true
				badMSGType = "HEROIC"
				filteredCountHeroics = filteredCountHeroics + 1
			end
		end
		if(spamBlockGuild) then
			if(msg:match("[Gg][Uu]*[Ii][Ll][Dd]") 
					or msg:match("[Rr][Ee][Cc][RrLl][Uu][IiTt][Tt]*")) then
				badMSG = true
				badMSGType = "GUILD"
				filteredCountGuild = filteredCountGuild + 1
			end
		end
		if (badMSG) then
			filteredMessageCount = filteredMessageCount + 1
			if (verbose) then
				DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r "..cRed..badMSGType.."|r ".. msg)
			end
			if(GetTime() - lastSpamTime >= minSecondsBetweenSpam) then
				DEFAULT_CHAT_FRAME:AddMessage(cGreen.."SPAM Filter:|r Blocked "..cRed..filteredMessageCount.."|r SPAM messages so far this session...")
				lastSpamTime = GetTime()
			end
			lastBlockedMSG = msg
		end
		if (msg == lastUnblockedMSG) then
			return true
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