-- SPAMFilter v1.0 by Darkspy


-- Keyword threshold to trigger the filter
threshold = 3;

-- Slash command handler
SLASH_SPAMFILTER1 = "/spamfilter"
SlashCmdList["SPAMFILTER"] = function(msg)
	if msg == "toggle" then
		filterSPAM = not filterSPAM;
		 if (filterSPAM == false) then
			 DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter:|r SPAM filter enabled")
		 else
			DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter:|r SPAM filter disabled")
		 end
	elseif msg == "verbose" then
		verbose = not verbose;
		 if (verbose == true) then
			 DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter:|r verbose SPAM filtering enabled")
		 else
			DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter:|r verbose SPAM filtering disabled")
		 end
	elseif msg == "words" then
		if userKeywords then	
			-- build a string using the words array
			result = ""
			for i = 1, #userKeywords do
				--comma delimite
				if (result.length ~= 0) then
					result = result .. ", "
				end
				result = result .. userKeywords[i]
			end
		end 
		--display the words
		DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter:|r" .. result)	
	elseif msg:find("add") then
	-- get words to add
	msg = string.gsub(msg, "add", "") -- remove the word add
	msg = string.gsub(msg, "%s$", "") -- remove any spaces from the end
	msg = string.gsub(msg, "^%s", "") -- remove any spaces from the end
	-- If there is not an array, we will have to create it.
	if userKeywords then
		table.insert(userKeywords,msg)
		DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter:|r Added " .. msg)
	else
		userKeywords = {msg}
		DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter:|r Added " .. msg)
	end 
	elseif msg:find("remove") then
		-- get words to remove
		msg = string.gsub(msg, "remove", "") -- remove the word remove
		msg = string.gsub(msg, "%s$", "") -- remove any spaces from the end
		msg = string.gsub(msg, "^%s", "") -- remove any spaces from the end
		-- If there is an array to remove an item from.
		if userKeywords then
		-- remove words
			for i = 1, #userKeywords do
				if (userKeywords[i] == msg) then
					table.remove(userKeywords,i)
				end
			end
			--inform the user
			DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter:|r Removed " .. msg)
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter:|r No custom user words found")
		end 	
	 else
		DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter:|r List of commands")
		DEFAULT_CHAT_FRAME:AddMessage("/spamfilter toggle                 Enable/Disable SPAM filtering.")
		DEFAULT_CHAT_FRAME:AddMessage("/spamfilter words                  Displays the list of words used to identify SPAM. (3 matches result in a filtered message)")
		DEFAULT_CHAT_FRAME:AddMessage("/spamfilter add WORD          Add a new word to identify SPAM")
		DEFAULT_CHAT_FRAME:AddMessage("/spamfilter remove WORD      Remove a word")
		DEFAULT_CHAT_FRAME:AddMessage("/spamfilter verbose               Toggle displaying filtered messages.")
	end
end

--Load variables, tell the user we loaded etc.
function SPAMFilter_OnLoad()
DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter Loaded:|r type /spamfilter for options. Brought to you by |cff00ff00https://legacy-wow.com|r");
--setup default values on first login
if (userkeywords == nil) then
	userKeywords = { "welcome","web","buy","sell", "selling", "USD", "cheap", "code", "coupon", "customer", "deal", "deliver", "delivery", "discount", "express", "fast", "free", "gift", "gold",
				   "iphone", "low", "lowest", "order", "promotion", "safe", "sale", "save", "site", "service", "win", "www", "%.com", "%.net", "%.org", "price", "coins",
				   "account", "goo.gl", "[gm]", "http://", "bonus account", "server anniversary", "100g", "disc o unt", "cheapest", "powerleveling", "fast" ,"1000g", "1ooog" };
	end
end


-- ChatFilter() - Used to filter chat messages
local function SpamFilter(msg, player, channelstring, target, ...)
	
	-- Gold spam filter
	 if (filterSPAM == false) then 
	 
		matchCount = 0;
		
		-- Search the message for specific userkeywords
		if userKeywords then
			for i = 1, #userKeywords do
				if string.lower(msg):find(userKeywords[i]) then
					matchCount = matchCount + 1;
				end
			end
		end
		
		if (matchCount >= threshold) then
				if (verbose == true) then
					DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SPAM Filter:|r SPAM " .. msg);
				end
			return true
		end
		
		return false
	 end

	return false
end	
		
-- Chat filter event hooks
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", SpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", SpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", SpamFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", SpamFilter)

SPAMFilter_OnLoad();
