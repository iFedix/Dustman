--[[
-------------------------------------------------------------------------------
-- Dustman, by Ayantir
-------------------------------------------------------------------------------
This software is under : CreativeCommons CC BY-NC-SA 4.0
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

You are free to:

	 Share — copy and redistribute the material in any medium or format
	 Adapt — remix, transform, and build upon the material
	 The licensor cannot revoke these freedoms as long as you follow the license terms.


Under the following terms:

	 Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
	 NonCommercial — You may not use the material for commercial purposes.
	 ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
	 No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


Please read full licence at : 
http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode
]]

if not Dustman then return end

local ADDON_VERSION = "9.7.2"
local ADDON_WEBSITE = "http://www.esoui.com/downloads/info97-Dustman.html"

local function GetSettings()
	if Dustman.savedVars.useGlobalSettings then
		return Dustman.globalSavedVars
	else
		return Dustman.savedVars
	end
end
Dustman.GetSettings = GetSettings

--addon menu
function Dustman.CreateSettingsMenu(defaults)

	--local variables
	local qualityChoices = {}
	local reverseQualityChoices = {}
	for i = 0, ITEM_QUALITY_ARTIFACT do
		local color = GetItemQualityColor(i)
		local qualName = color:Colorize(GetString("SI_ITEMQUALITY", i))
		qualityChoices[i] = qualName
		reverseQualityChoices[qualName] = i
	end
	
	local function GetIdFromName(choice)
		
		local charName, server = zo_strsplit("@", choice)
		local data = Dustman_SavedVariables.Default[GetDisplayName()]
		for entryIndex, entryData in pairs(data) do
			local name = entryData["$LastCharacterName"]
			if charName == name and server == entryData.worldname then
				return entryIndex
			end
		end
	end

	local levelChoices = {}
	levelChoices[1] = GetString(SI_NO)
	levelChoices[2] = GetString(SI_ITEM_FORMAT_STR_LEVEL) .. " 16 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:4487:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelChoices[3] = GetString(SI_ITEM_FORMAT_STR_LEVEL) .. " 26 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:23107:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelChoices[4] = GetString(SI_ITEM_FORMAT_STR_LEVEL) .. " 36 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:6000:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelChoices[5] = GetString(SI_ITEM_FORMAT_STR_LEVEL) .. " 46 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:6001:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelChoices[6] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 1 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:46127:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelChoices[7] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 40 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:46128:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelChoices[8] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 70 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:46129:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelChoices[9] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 90 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:46130:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelChoices[10] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 150 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:64489:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	local reverseLevelChoices = {}
	reverseLevelChoices[GetString(SI_NO)] = 1
	reverseLevelChoices[GetString(SI_ITEM_FORMAT_STR_LEVEL) .. " 16 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:4487:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 16
	reverseLevelChoices[GetString(SI_ITEM_FORMAT_STR_LEVEL) .. " 26 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:23107:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 26
	reverseLevelChoices[GetString(SI_ITEM_FORMAT_STR_LEVEL) .. " 36 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:6000:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 36
	reverseLevelChoices[GetString(SI_ITEM_FORMAT_STR_LEVEL) .. " 46 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:6001:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 46
	reverseLevelChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 1 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:46127:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10001
	reverseLevelChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 40 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:46128:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10040
	reverseLevelChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 70 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:46129:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10070
	reverseLevelChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 90 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:46130:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10090
	reverseLevelChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 150 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:64489:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10150
	local valueLevelChoice = {}
	valueLevelChoice[1] = 1
	valueLevelChoice[16] = 2
	valueLevelChoice[26] = 3
	valueLevelChoice[36] = 4
	valueLevelChoice[46] = 5
	valueLevelChoice[10001] = 6
	valueLevelChoice[10040] = 7
	valueLevelChoice[10070] = 8
	valueLevelChoice[10090] = 9
	valueLevelChoice[10150] = 10

	local levelGlyphChoices = {}
	levelGlyphChoices[1] = GetString(SI_NO)
	levelGlyphChoices[2] = GetString(SI_ITEM_FORMAT_STR_LEVEL) .. " 40 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45811:20:45:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45825:20:45:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelGlyphChoices[3] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 1 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45812:125:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45826:125:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelGlyphChoices[4] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 30 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45813:127:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45827:127:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelGlyphChoices[5] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 50 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45814:129:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45828:129:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelGlyphChoices[6] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 70 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45815:131:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45829:131:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelGlyphChoices[7] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 100 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45816:134:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45830:134:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelGlyphChoices[8] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 150 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:64509:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:64508:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelGlyphChoices[9] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 160 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:68341:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:68340:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	local reverseLevelGlyphChoices = {}
	reverseLevelGlyphChoices[GetString(SI_NO)] = 1
	reverseLevelGlyphChoices[GetString(SI_ITEM_FORMAT_STR_LEVEL) .. " 40 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45811:20:45:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45825:20:45:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 40
	reverseLevelGlyphChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 1 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45812:125:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45826:125:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10001
	reverseLevelGlyphChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 30 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45813:127:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45827:127:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10030
	reverseLevelGlyphChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 50 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45814:129:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45828:129:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10050
	reverseLevelGlyphChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 70 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45815:131:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45829:131:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10070
	reverseLevelGlyphChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 100 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45816:134:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:45830:134:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10100
	reverseLevelGlyphChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 150 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:64509:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:64508:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10150
	reverseLevelGlyphChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 160 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:68341:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")) .. " & " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:68340:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10160
	local valueLevelGlyphChoice = {}
	valueLevelGlyphChoice[1] = 1
	valueLevelGlyphChoice[40] = 2
	valueLevelGlyphChoice[10001] = 3
	valueLevelGlyphChoice[10030] = 4
	valueLevelGlyphChoice[10050] = 5
	valueLevelGlyphChoice[10070] = 6
	valueLevelGlyphChoice[10100] = 7
	valueLevelGlyphChoice[10150] = 8
	valueLevelGlyphChoice[10160] = 9

	local levelPotionsChoices = {}
	levelPotionsChoices[1] = GetString(SI_NO)
	levelPotionsChoices[2] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 1 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:27036:111:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelPotionsChoices[3] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 50 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:27036:115:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelPotionsChoices[4] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 100 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:27036:120:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	levelPotionsChoices[5] = GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 150 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:27036:307:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))
	local reverseLevelPotionsChoices = {}
	reverseLevelPotionsChoices[GetString(SI_NO)] = 1
	reverseLevelPotionsChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 1 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:27036:111:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10001
	reverseLevelPotionsChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 50 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:27036:115:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10050
	reverseLevelPotionsChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 100 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:27036:120:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10100
	reverseLevelPotionsChoices[GetString(SI_ITEM_FORMAT_STR_CHAMPION) .. " 150 - " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H1:item:27036:307:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"))] = 10150
	local valueLevelPotionsChoice = {}
	valueLevelPotionsChoice[1] = 1
	valueLevelPotionsChoice[10001] = 2
	valueLevelPotionsChoice[10050] = 3
	valueLevelPotionsChoice[10100] = 4
	valueLevelPotionsChoice[10150] = 5
	
	local lowStolenChoices = {[1] = GetString("DUSTMAN_ACT_LOWTREASURE", 1), [2] = GetString("DUSTMAN_ACT_LOWTREASURE", 2), [3] = GetString("DUSTMAN_ACT_LOWTREASURE", 3)}
	local reverseLowStolenChoices = {[GetString("DUSTMAN_ACT_LOWTREASURE", 1)] = 1, [GetString("DUSTMAN_ACT_LOWTREASURE", 2)] = 2, [GetString("DUSTMAN_ACT_LOWTREASURE", 3)] = 3}
	
	local charactersKnown = {}
	if Dustman_SavedVariables and Dustman_SavedVariables.Default and Dustman_SavedVariables.Default[GetDisplayName()] then
		for id, data in pairs(Dustman_SavedVariables.Default[GetDisplayName()]) do
			if data.worldname then
				if not (data.worldname == GetWorldName() and data["$LastCharacterName"] == GetUnitName("player")) then
					table.insert(charactersKnown, data["$LastCharacterName"].."@"..data.worldname)
				end
			end
		end
	end

	local LAM2 = LibAddonMenu2
	local panelData = {
		type = "panel",
		name = GetString(DUSTMAN_TITLE),
		displayName = ZO_HIGHLIGHT_TEXT:Colorize(GetString(DUSTMAN_TITLE)),
		author = "Garkin, Ayantir & iFedix",
		version = ADDON_VERSION,
		slashCommand = "/dustman",
		registerForRefresh = true,
		registerForDefaults = true,
		website = ADDON_WEBSITE,
	}
	LAM2:RegisterAddonPanel("Dustman_OptionsPanel", panelData)

	local traitSubmenuControls = {}
	table.insert(traitSubmenuControls, {
		type = "checkbox",
		name = GetString(DUSTMAN_FULLSTACK), 
		tooltip = GetString(DUSTMAN_FULLSTACK_DESC),
		getFunc = function() return GetSettings().traitFullStack end,
		setFunc = function(state) GetSettings().traitFullStack = state end,
		default = defaults.traitFullStack,
	})
	
	local itemsTraitsSubmenuControls = {}
	table.insert(itemsTraitsSubmenuControls, {
		type = "checkbox",
		name = GetString(DUSTMAN_TRAITSSETS), 
		tooltip = GetString(DUSTMAN_TRAITSSETS_DESC),
		getFunc = function() return GetSettings().junkTraitSets end,
		setFunc = function(state) GetSettings().junkTraitSets = state end,
		default = defaults.junkTraitSets,
		disabled = function() return not GetSettings().equipment.enabled end,
	})
	
	for traitItemIndex = 1, GetNumSmithingTraitItems() do
		local traitType, itemName = GetSmithingTraitItemInfo(traitItemIndex)
		local itemLink = GetSmithingTraitItemLink(traitItemIndex, LINK_STYLE_DEFAULT)
		local itemType = GetItemLinkItemType(itemLink)
		if itemType ~= ITEMTYPE_NONE and not (traitType == ITEM_TRAIT_TYPE_NONE or traitType == ITEM_TRAIT_TYPE_WEAPON_NIRNHONED or traitType == ITEM_TRAIT_TYPE_ARMOR_NIRNHONED) then 
			local itemId = select(4, ZO_LinkHandler_ParseLink(itemLink))
			table.insert(traitSubmenuControls, {
				type = "checkbox",
				name = zo_strformat("<<t:1>>", itemName),
				tooltip = zo_strformat("<<1>>: <<2>>", GetString("SI_ITEMTYPE", itemType), GetString("SI_ITEMTRAITTYPE", traitType)),
				getFunc = function() return GetSettings().traitMaterial[itemId] end,
				setFunc = function(state) GetSettings().traitMaterial[itemId] = state end,
				default = defaults.traitMaterial[itemId],
			})
			table.insert(itemsTraitsSubmenuControls, {
				type = "checkbox",
				name = GetString("SI_ITEMTRAITTYPE", traitType),
				tooltip = zo_strformat("<<1>>: <<2>>", GetString("SI_ITEMTYPE", itemType), GetString("SI_ITEMTRAITTYPE", traitType)),
				getFunc = function() return GetSettings().itemTraits[traitType] end,
				setFunc = function(state) GetSettings().itemTraits[traitType] = state end,
				default = defaults.itemTraits[traitType],
				disabled = function() return not GetSettings().equipment.enabled end,
			})
		end
	end
	
	local styleSubmenuControls = {}
	for styleItemIndex = 1, GetHighestItemStyleId() do
		
		local styleItemLink = GetItemStyleMaterialLink(styleItemIndex)
		local itemName = GetItemLinkName(styleItemLink)
		local _, _, meetsUsageRequirement = GetItemLinkInfo(styleItemLink)
		
		if meetsUsageRequirement and Dustman.IsCommonStyle(styleItemIndex) then
			local itemId = select(4, ZO_LinkHandler_ParseLink(styleItemLink))
			table.insert(styleSubmenuControls, {
				type = "checkbox",
				name = zo_strformat("<<1>> (<<2>>)", GetItemStyleName(styleItemIndex), zo_strformat(SI_TOOLTIP_ITEM_NAME, itemName)),
				tooltip = zo_strformat("<<1>> (<<2>>)", GetItemStyleName(styleItemIndex), zo_strformat(SI_TOOLTIP_ITEM_NAME, itemName)),
				getFunc = function() return GetSettings().styleMaterial[itemId] end,
				setFunc = function(state) GetSettings().styleMaterial[itemId] = state end,
				default = defaults.styleMaterial[itemId],
			})
		end
	end
	table.insert(styleSubmenuControls, {
		type = "checkbox",
		name = GetString(DUSTMAN_FULLSTACK), 
		tooltip = GetString(DUSTMAN_FULLSTACK_DESC),
		getFunc = function() return GetSettings().styleFullStack end,
		setFunc = function(state) GetSettings().styleFullStack = state end,
		default = defaults.styleFullStack,
	})
	
	local optionsData = {
		{			
			type = "submenu",
			name = zo_strformat("<<1>> & <<2>>", GetString(SI_ITEMFILTERTYPE1), GetString(SI_ITEMFILTERTYPE2)), --GetString(SI_GAMEPAD_INVENTORY_EQUIPMENT_HEADER)
			controls = {
                {
					type = "checkbox",
					name = GetString(DUSTMAN_WHITE_ZERO),
					tooltip = GetString(DUSTMAN_WHITE_ZERO_DESC),
					getFunc = function() return GetSettings().equipment.whiteZeroValue end,
					setFunc = function(state) GetSettings().equipment.whiteZeroValue = state end,
					disabled = function() return GetSettings().equipment.enabled end,
					default = defaults.equipment.whiteZeroValue,
				},
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_EQUIP_NOTRAIT),
					tooltip = GetString(DUSTMAN_EQUIP_NOTRAIT_DESC),
					getFunc = function() return GetSettings().equipment.notrait end,
					setFunc = function(state) GetSettings().equipment.notrait = state; if state then GetSettings().equipment.whiteZeroValue = true end end,
					default = defaults.equipment.notrait,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().equipment.notraitQuality] end,
					setFunc = function(choice) GetSettings().equipment.notraitQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().equipment.notrait end,
					default = qualityChoices[defaults.equipment.notraitQuality],
				},
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_EQUIPMENT),
					tooltip = GetString(DUSTMAN_EQUIPMENT_DESC),
					getFunc = function() return GetSettings().equipment.enabled end,
					setFunc = function(state) GetSettings().equipment.enabled = state; if state then GetSettings().equipment.whiteZeroValue = true end end,
					default = defaults.equipment.enabled,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().equipment.equipmentQuality] end,
					setFunc = function(choice) GetSettings().equipment.equipmentQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().equipment.enabled end,
					default = qualityChoices[defaults.equipment.equipmentQuality],
				},
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_ORNATE),
					tooltip = GetString(DUSTMAN_ORNATE_DESC),
					getFunc = function() return GetSettings().equipment.ornate end,
					setFunc = function(state) GetSettings().equipment.ornate = state end,
					default = defaults.equipment.ornate,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().equipment.ornateQuality] end,
					setFunc = function(choice) GetSettings().equipment.ornateQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().equipment.ornate end,
					default = qualityChoices[defaults.equipment.ornateQuality],
				},
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_INTRICATE),
					tooltip = GetString(DUSTMAN_INTRICATE_DESC),
					getFunc = function() return GetSettings().equipment.keepIntricate end,
					setFunc = function(state) GetSettings().equipment.keepIntricate = state end,
					disabled = function() return not GetSettings().equipment.enabled end,
					default = defaults.equipment.keepIntricate,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_INTRIC_MAX),
					tooltip = GetString(DUSTMAN_INTRIC_MAX_DESC),
					getFunc = function() return GetSettings().equipment.keepIntricateIfNotMaxed end,
					setFunc = function(state) GetSettings().equipment.keepIntricateIfNotMaxed = state end,
					disabled = function() return not (GetSettings().equipment.enabled and GetSettings().equipment.keepIntricate) end,
					default = defaults.equipment.keepIntricateIfNotMaxed,
				},
                {
					type = "divider",
				},
                {
					type = "checkbox",
					name = GetString(DUSTMAN_RESEARCH),
					tooltip = GetString(DUSTMAN_RESEARCH_DESC),
					getFunc = function() return GetSettings().equipment.keepResearchable end,
					setFunc = function(state) GetSettings().equipment.keepResearchable = state end,
					disabled = function() return not GetSettings().equipment.enabled end,
					default = defaults.equipment.keepResearchable,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_NIRNHONED),
					tooltip = GetString(DUSTMAN_NIRNHONED_DESC),
					getFunc = function() return GetSettings().equipment.keepNirnhoned end,
					setFunc = function(state) GetSettings().equipment.keepNirnhoned = state end,
					disabled = function() return not GetSettings().equipment.enabled end,
					default = defaults.equipment.keepNirnhoned,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_SET),
					tooltip = GetString(DUSTMAN_SET_DESC),
					getFunc = function() return GetSettings().equipment.keepSetItems end,
					setFunc = function(state) GetSettings().equipment.keepSetItems = state end,
					disabled = function() return not GetSettings().equipment.enabled end,
					default = defaults.equipment.keepSetItems,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_RARE),
					tooltip = GetString(DUSTMAN_RARE_DESC),
					getFunc = function() return GetSettings().equipment.keepRareStyle end,
					setFunc = function(state) GetSettings().equipment.keepRareStyle = state end,
					disabled = function() return not GetSettings().equipment.enabled end,
					default = defaults.equipment.keepRareStyle,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_MAELS_MAST),
					tooltip = GetString(DUSTMAN_MAELS_MAST_DESC),
					getFunc = function() return GetSettings().equipment.keepMaelAndMast end,
					setFunc = function(state) GetSettings().equipment.keepMaelAndMast = state end,
					disabled = function() return not GetSettings().equipment.enabled end,
					default = defaults.equipment.keepMaelAndMast,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_LEVEL),
					tooltip = GetString(DUSTMAN_LEVEL_DESC),
					choices = levelChoices,
					getFunc = function() return levelChoices[valueLevelChoice[GetSettings().equipment.keepLevel]] end,
					setFunc = function(choice)
						if reverseLevelChoices[choice] then
							GetSettings().equipment.keepLevel = reverseLevelChoices[choice]
						else
							GetSettings().equipment.keepLevel = defaults.equipment.keepLevel
						end
					end,
					disabled = function() return not GetSettings().equipment.enabled end,
					default = levelChoices[defaults.equipment.keepLevel],
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_LEVEL_ORNATE),
					tooltip = GetString(DUSTMAN_LEVEL_ORNATE_DESC),
					getFunc = function() return GetSettings().equipment.keepLevelOrnate end,
					setFunc = function(state) GetSettings().equipment.keepLevelOrnate = state end,
					disabled = function() return not GetSettings().equipment.ornate or GetSettings().equipment.keepLevel == 1 end,
					default = defaults.equipment.keepLevelOrnate,
				},
			},
		},
		{
			type = "submenu",
			name = GetString(SI_GAMEPADITEMCATEGORY38), --Jewels
			controls = {
				{
					type = "checkbox",
					name = GetString(DUSTMAN_JEWELS_NOTRAIT),
					tooltip = GetString(DUSTMAN_JEWELS_NOTRAIT_DESC),
					getFunc = function() return GetSettings().equipment.notraitJewels end,
					setFunc = function(state) GetSettings().equipment.notraitJewels = state; if state then GetSettings().equipment.whiteZeroValue = true end end,
					default = defaults.equipment.notraitJewels,
				},
                {
					type = "checkbox",
					name = GetString(DUSTMAN_RESEARCH_JEWELS),
					tooltip = GetString(DUSTMAN_RESEARCH_JEWELS_DESC),
					getFunc = function() return GetSettings().equipment.keepResearchableJewels end,
					setFunc = function(state) GetSettings().equipment.keepResearchableJewels = state end,
					disabled = function() return not GetSettings().equipment.jewelsEnabled end,
					default = defaults.equipment.keepResearchableJewels,
				},
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_JEWELS),
					tooltip = GetString(DUSTMAN_JEWELS_DESC),
					getFunc = function() return GetSettings().equipment.jewelsEnabled end,
					setFunc = function(state) GetSettings().equipment.jewelsEnabled = state; if state then GetSettings().equipment.whiteZeroValue = true end end,
					default = defaults.equipment.jewelsEnabled,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().equipment.jewelsQuality] end,
					setFunc = function(choice) GetSettings().equipment.jewelsQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().equipment.jewelsEnabled end,
					default = qualityChoices[defaults.equipment.jewelsQuality],
				},
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_ORNATE_JEWELS),
					tooltip = GetString(DUSTMAN_ORNATE_JEWELS_DESC),
					getFunc = function() return GetSettings().equipment.jewelsOrnate end,
					setFunc = function(state) GetSettings().equipment.jewelsOrnate = state end,
					default = defaults.equipment.jewelsOrnate,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().equipment.jewelsOrnateQuality] end,
					setFunc = function(choice) GetSettings().equipment.jewelsOrnateQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().equipment.jewelsOrnate end,
					default = qualityChoices[defaults.equipment.jewelsOrnateQuality],
				},
                {
                    type = "divider",
                },
                {
					type = "checkbox",
					name = GetString(DUSTMAN_JEWELS_INTRICATE),
					tooltip = GetString(DUSTMAN_JEWELS_INTRICATE_DESC),
					getFunc = function() return GetSettings().equipment.keepIntricateJewels end,
					setFunc = function(state) GetSettings().equipment.keepIntricateJewels = state end,
					disabled = function() return not GetSettings().equipment.jewelsEnabled end,
					default = defaults.equipment.keepIntricateJewels,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_JEWELS_INTRIC_MAX),
					tooltip = GetString(DUSTMAN_JEWELS_INTRIC_MAX_DESC),
					getFunc = function() return GetSettings().equipment.keepIntricateJewelsIfNotMaxed end,
					setFunc = function(state) GetSettings().equipment.keepIntricateJewelsIfNotMaxed = state end,
					disabled = function() return not (GetSettings().equipment.jewelsEnabled and GetSettings().equipment.keepIntricateJewels) end,
					default = defaults.equipment.keepIntricateJewelsIfNotMaxed,
				},
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_JEWELS_SET),
					tooltip = GetString(DUSTMAN_JEWELS_SET_DESC),
					getFunc = function() return GetSettings().equipment.keepJewelsSetItems end,
					setFunc = function(state) GetSettings().equipment.keepJewelsSetItems = state end,
					default = defaults.equipment.keepJewelsSetItems,
					disabled = function() return not GetSettings().equipment.jewelsEnabled end,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY_SUPP),
					tooltip = GetString(DUSTMAN_QUALITY_SUPP_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().equipment.jewelsSetQuality] end,
					setFunc = function(choice) GetSettings().equipment.jewelsSetQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().equipment.keepJewelsSetItems end,
					default = qualityChoices[defaults.equipment.jewelsSetQuality],
				},
			},
		},
        {
			type = "submenu",
			name = zo_strformat("<<1>> & <<2>> & <<3>>(<<4>>)", GetString("SI_ITEMTYPE", ITEMTYPE_WEAPON), GetString(SI_SPECIALIZEDITEMTYPE300), GetString(SI_GAMEPADITEMCATEGORY38), GetString(SI_CRAFTING_COMPONENT_TOOLTIP_TRAITS)),
			controls = itemsTraitsSubmenuControls,
		},
		{
			type = "submenu",
			name = zo_strformat("<<1>>", GetString("SI_ITEMTYPE", ITEMTYPE_STYLE_MATERIAL)),
			controls = styleSubmenuControls,
		},
		{
			type = "submenu",
			name = GetString(DUSTMAN_ITEM_TRAITS),
			controls = traitSubmenuControls,
		},
		{
			type = "submenu",
			name = GetString(SI_GAMEPADITEMCATEGORY19), --Provisioning
			controls = {
				{
					type = "checkbox",
					name = GetString(DUSTMAN_INGR_ALL),
					tooltip = GetString(DUSTMAN_INGR_ALL_DESC),
					getFunc = function() return GetSettings().provisioning.all end,
					setFunc = function(state) GetSettings().provisioning.all = state end,
					default = defaults.provisioning.all,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_INGR_UNUS),
					tooltip = GetString(DUSTMAN_INGR_UNUS_DESC),
					getFunc = function() return GetSettings().provisioning.unusable end,
					setFunc = function(state) GetSettings().provisioning.unusable = state end,
					disabled = function() return GetSettings().provisioning.all end, 
					default = defaults.provisioning.unusable,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FULLSTACK), 
					tooltip = GetString(DUSTMAN_FULLSTACK_DESC),
					getFunc = function() return GetSettings().provisioning.fullStack end,
					setFunc = function(state) GetSettings().provisioning.fullStack = state end,
					default = defaults.provisioning.fullStack,
				},
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_INGR_DISH),
					tooltip = GetString(DUSTMAN_INGR_DISH_DESC),
					getFunc = function() return GetSettings().provisioning.dish end,
					setFunc = function(state) GetSettings().provisioning.dish = state end,
					disabled = function() return not (GetSettings().provisioning.all or GetSettings().provisioning.unusable) end, 
					default = defaults.provisioning.dish,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_INGR_DRINK),
					tooltip = GetString(DUSTMAN_INGR_DRINK_DESC),
					getFunc = function() return GetSettings().provisioning.drink end,
					setFunc = function(state) GetSettings().provisioning.drink = state end,
					disabled = function() return not (GetSettings().provisioning.all or GetSettings().provisioning.unusable) end, 
					default = defaults.provisioning.drink,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_INGR_RARE),
					tooltip = GetString(DUSTMAN_INGR_RARE_DESC),
					getFunc = function() return GetSettings().provisioning.excludeRareAdditives end,
					setFunc = function(state) GetSettings().provisioning.excludeRareAdditives = state end,
					disabled = function() return not (GetSettings().provisioning.all or GetSettings().provisioning.unusable) end, 
					default = defaults.provisioning.excludeRareAdditives,
				},
			},
		},
		{
			type = "submenu",
			name = GetString(DUSTMAN_CRAFTING_MATERIALS), --Crafting materials
			controls = {
				{
					type = "checkbox",
					name = GetString(SI_ITEMFILTERTYPE13),
					tooltip = GetString(DUSTMAN_CRAFTING_BLACKSMITHING_DESC),
					getFunc = function() return GetSettings().crafting.lowLevelBlacksmithingMaterials end,
					setFunc = function(state) GetSettings().crafting.lowLevelBlacksmithingMaterials = state end,
					width = "half",
					default = defaults.crafting.lowLevelBlacksmithingMaterials,
				},
				{
					type = "checkbox",
					name = GetString(SI_SMITHINGFILTERTYPE1),
					tooltip = GetString(DUSTMAN_CRAFTING_RAW_BLACKSMITHING_DESC),
					getFunc = function() return GetSettings().crafting.lowLevelBlacksmithingRawMaterials end,
					setFunc = function(state) GetSettings().crafting.lowLevelBlacksmithingRawMaterials = state end,
					width = "half",
					default = defaults.crafting.lowLevelBlacksmithingRawMaterials,
				},
				{
					type = "checkbox",
					name = GetString(SI_ITEMFILTERTYPE14),
					tooltip = GetString(DUSTMAN_CRAFTING_CLOTHING_DESC),
					getFunc = function() return GetSettings().crafting.lowLevelClothingMaterials end,
					setFunc = function(state) GetSettings().crafting.lowLevelClothingMaterials = state end,
					width = "half",
					default = defaults.crafting.lowLevelClothingMaterials,
				},
				{
					type = "checkbox",
					name = GetString(SI_SMITHINGFILTERTYPE1),
					tooltip = GetString(DUSTMAN_CRAFTING_RAW_CLOTHING_DESC),
					getFunc = function() return GetSettings().crafting.lowLevelClothingRawMaterials end,
					setFunc = function(state) GetSettings().crafting.lowLevelClothingRawMaterials = state end,
					width = "half",
					default = defaults.crafting.lowLevelClothingRawMaterials,
				},
				{
					type = "checkbox",
					name = GetString(SI_ITEMFILTERTYPE15),
					tooltip = GetString(DUSTMAN_CRAFTING_WOODWORKING_DESC),
					getFunc = function() return GetSettings().crafting.lowLevelWoodworkingMaterials end,
					setFunc = function(state) GetSettings().crafting.lowLevelWoodworkingMaterials = state end,
					width = "half",
					default = defaults.crafting.lowLevelWoodworkingMaterials,
				},
				{
					type = "checkbox",
					name = GetString(SI_SMITHINGFILTERTYPE1),
					tooltip = GetString(DUSTMAN_CRAFTING_RAW_WOODWORKING_DESC),
					getFunc = function() return GetSettings().crafting.lowLevelWoodworkingRawMaterials end,
					setFunc = function(state) GetSettings().crafting.lowLevelWoodworkingRawMaterials = state end,
					width = "half",
					default = defaults.crafting.lowLevelWoodworkingRawMaterials,
				},
				{
					type = "checkbox",
					name = GetString(SI_GAMEPADITEMCATEGORY38),
					tooltip = GetString(DUSTMAN_CRAFTING_JEWELRY_DESC),
					getFunc = function() return GetSettings().crafting.lowLevelJewelryMaterials end,
					setFunc = function(state) GetSettings().crafting.lowLevelJewelryMaterials = state end,
					width = "half",
					default = defaults.crafting.lowLevelJewelryMaterials,
				},
				{
					type = "checkbox",
					name = GetString(SI_SMITHINGFILTERTYPE1),
					tooltip = GetString(DUSTMAN_CRAFTING_RAW_JEWELRY_DESC),
					getFunc = function() return GetSettings().crafting.lowLevelJewelryRawMaterials end,
					setFunc = function(state) GetSettings().crafting.lowLevelJewelryRawMaterials = state end,
					width = "half",
					default = defaults.crafting.lowLevelJewelryRawMaterials,
				},
			},
		},
		{
			type = "submenu",
			name = zo_strformat("<<1>> & <<2>>", GetString(SI_GAMEPADITEMCATEGORY13), GetString("SI_ITEMTYPE", ITEMTYPE_ENCHANTING_RUNE_ASPECT)), --Glyphs
			controls = {
				{
					type = "checkbox",
					name = GetString(DUSTMAN_GLYPHS),
					tooltip = GetString(DUSTMAN_GLYPHS_DESC),
					getFunc = function() return GetSettings().glyphs end,
					setFunc = function(state) GetSettings().glyphs = state end,
					default = defaults.glyphs,
				},
                
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().glyphsQuality] end,
					setFunc = function(choice) GetSettings().glyphsQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().glyphs end,
					default = qualityChoices[defaults.glyphsQuality],
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_LEVELGLYPH),
					tooltip = GetString(DUSTMAN_LEVELGLYPH_DESC),
					choices = levelGlyphChoices,
					getFunc = function() return levelGlyphChoices[valueLevelGlyphChoice[GetSettings().keepLevelGlyphs]] end,
					setFunc = function(choice)
						if reverseLevelGlyphChoices[choice] then
							GetSettings().keepLevelGlyphs = reverseLevelGlyphChoices[choice]
						else
							GetSettings().keepLevelGlyphs = defaults.keepLevelGlyphs
						end
					end,
					disabled = function() return not GetSettings().glyphs end,
					default = levelGlyphChoices[defaults.keepLevelGlyphs],
				},
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_ASPECT_RUNES),
					tooltip = GetString(DUSTMAN_ASPECT_RUNES_DESC),
					getFunc = function() return GetSettings().enchanting.enchantingAspect end,
					setFunc = function(state) GetSettings().enchanting.enchantingAspect = state end,
					default = defaults.enchanting.enchantingAspect,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().enchanting.aspectQuality] end,
					setFunc = function(choice) GetSettings().enchanting.aspectQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().enchanting.enchantingAspect end,
					default = qualityChoices[defaults.enchanting.aspectQuality],
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FULLSTACK), 
					tooltip = GetString(DUSTMAN_FULLSTACK_DESC),
					getFunc = function() return GetSettings().enchanting.aspectFullStack end,
					setFunc = function(state) GetSettings().enchanting.aspectFullStack = state end,
					disabled = function() return not GetSettings().enchanting.enchantingAspect end,
					default = defaults.enchanting.aspectFullStack,
				},
			},
		},
		{
			type = "submenu",
			name = GetString(SI_ITEMFILTERTYPE3), --Consumable
			controls = {
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FOOD_ALL),
					tooltip = GetString(DUSTMAN_FOOD_ALL_DESC),
					getFunc = function() return GetSettings().foodAll end,
					setFunc = function(state) GetSettings().foodAll = state end,
					default = defaults.foodAll,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().foodQuality] end,
					setFunc = function(choice) GetSettings().foodQuality = reverseQualityChoices[choice] end,
					disabled = function()
							if GetSettings().foodAll then
								return false
							end
							return true
						end,
					default = qualityChoices[defaults.foodQuality],
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_POTIONS),
					tooltip = GetString(DUSTMAN_POTIONS_DESC),
					getFunc = function() return GetSettings().potions end,
					setFunc = function(state) GetSettings().potions = state end,
					default = defaults.potions,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FULLSTACK_BAG),
					tooltip = GetString(DUSTMAN_FULLSTACK_BAG_DESC),
					getFunc = function() return GetSettings().fullStackBagPotions end,
					setFunc = function(state) GetSettings().fullStackBagPotions = state end,
					default = defaults.fullStackBagPotions,
					disabled = function() return not GetSettings().potions end,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FULLSTACK),
					tooltip = GetString(DUSTMAN_FULLSTACK_DESC),
					getFunc = function() return GetSettings().fullStackBankPotions end,
					setFunc = function(state) GetSettings().fullStackBankPotions = state end,
					default = defaults.fullStackBankPotions,
					disabled = function() return not GetSettings().potions end,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_LEVELPOTIONS),
					tooltip = GetString(DUSTMAN_LEVELPOTIONS_DESC),
					choices = levelPotionsChoices,
					getFunc = function() return levelPotionsChoices[valueLevelPotionsChoice[GetSettings().keepPotionsLevel]] end,
					setFunc = function(choice)
						if reverseLevelPotionsChoices[choice] then
							GetSettings().keepPotionsLevel = reverseLevelPotionsChoices[choice]
						else
							GetSettings().keepPotionsLevel = defaults.keepPotionsLevel
						end
					end,
					disabled = function() return not GetSettings().potions end,
					default = levelPotionsChoices[defaults.keepPotionsLevel],
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_POISONS),
					tooltip = GetString(DUSTMAN_POISONS_DESC),
					getFunc = function() return GetSettings().poisons end,
					setFunc = function(state) GetSettings().poisons = state end,
					default = defaults.poisons,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FULLSTACK_BAG),
					tooltip = GetString(DUSTMAN_FULLSTACK_BAG_DESC),
					getFunc = function() return GetSettings().fullStackBagPoisons end,
					setFunc = function(state) GetSettings().fullStackBagPoisons = state end,
					default = defaults.fullStackBagPoisons,
					disabled = function() return not GetSettings().poisons end,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FULLSTACK),
					tooltip = GetString(DUSTMAN_FULLSTACK_DESC),
					getFunc = function() return GetSettings().fullStackBankPoisons end,
					setFunc = function(state) GetSettings().fullStackBankPoisons = state end,
					default = defaults.fullStackBankPoisons,
					disabled = function() return not GetSettings().poisons end,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_LEVELPOISONS),
					tooltip = GetString(DUSTMAN_LEVELPOISONS_DESC),
					choices = levelPotionsChoices,
					getFunc = function() return levelPotionsChoices[valueLevelPotionsChoice[GetSettings().keepPoisonsLevel]] end,
					setFunc = function(choice)
						if reverseLevelPotionsChoices[choice] then
							GetSettings().keepPoisonsLevel = reverseLevelPotionsChoices[choice]
						else
							GetSettings().keepPoisonsLevel = defaults.keepPoisonsLevel
						end
					end,
					disabled = function() return not GetSettings().poisons end,
					default = levelPotionsChoices[defaults.keepPoisonsLevel],
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_POISONS_SOLVANTS),
					tooltip = GetString(DUSTMAN_POISONS_SOLVANTS_DESC),
					getFunc = function() return GetSettings().poisonsSolvants end,
					setFunc = function(state) GetSettings().poisonsSolvants = state end,
					default = defaults.poisonsSolvants,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FULLSTACK_BAG),
					tooltip = GetString(DUSTMAN_FULLSTACK_BAG_DESC),
					getFunc = function() return GetSettings().fullStackBagPoisonsSolvants end,
					setFunc = function(state) GetSettings().fullStackBagPoisonsSolvants = state end,
					default = defaults.fullStackBagPoisonsSolvants,
					disabled = function() return not GetSettings().poisonsSolvants end,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FULLSTACK),
					tooltip = GetString(DUSTMAN_FULLSTACK_DESC),
					getFunc = function() return GetSettings().fullStackBankPoisonsSolvants end,
					setFunc = function(state) GetSettings().fullStackBankPoisonsSolvants = state end,
					default = defaults.fullStackBankPoisonsSolvants,
					disabled = function() return not GetSettings().poisonsSolvants end,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_EMPTYGEMS),
					tooltip = GetString(DUSTMAN_EMPTYGEMS_DESC),
					getFunc = function() return GetSettings().emptyGems end,
					setFunc = function(state) GetSettings().emptyGems = state end,
					default = defaults.emptyGems,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_TREASURE_MAPS),
					tooltip = GetString(DUSTMAN_TREASURE_MAPS_DESC),
					getFunc = function() return GetSettings().treasureMaps end,
					setFunc = function(state) GetSettings().treasureMaps = state end,
					width = "half",
					default = defaults.treasureMaps,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_TREASURE_MAPS_DESTROY),
					tooltip = GetString(DUSTMAN_TREASURE_MAPS_DESTROY_DESC),
					getFunc = function() return GetSettings().treasureMapsDestroy end,
					setFunc = function(state) GetSettings().treasureMapsDestroy = state end,
					width = "half",
					disabled = function() return not GetSettings().treasureMaps end,
					default = defaults.treasureMapsDestroy,
				},
                {
                    type = "divider",
                },
                {
					type = "checkbox",
					name = GetString(DUSTMAN_RECIPE),
					tooltip = GetString(DUSTMAN_RECIPE_DESC),
					getFunc = function() return GetSettings().provisioning.recipe end,
					setFunc = function(state) GetSettings().provisioning.recipe = state end,
					default = defaults.provisioning.recipe,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().provisioning.recipeQuality] end,
					setFunc = function(choice) GetSettings().provisioning.recipeQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().provisioning.recipe end,
					default = qualityChoices[defaults.provisioning.recipeQuality],
				},
                {
                    type = "divider",
                },
                {
					type = "checkbox",
					name = GetString(DUSTMAN_HOUSING_RECIPES),
					tooltip = GetString(DUSTMAN_HOUSING_RECIPES_DESC),
					getFunc = function() return GetSettings().housingRecipes end,
					setFunc = function(state) GetSettings().housingRecipes = state end,
					default = defaults.housingRecipes,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().housingRecipesQuality] end,
					setFunc = function(choice) GetSettings().housingRecipesQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().housingRecipes end,
					default = qualityChoices[defaults.housingRecipesQuality],
				},
			},
		},
		{
			type = "submenu",
			name = GetString(SI_GAMECAMERAACTIONTYPE16), --Fish
			controls = {
                {
					 type = "checkbox",
					 name = GetString(DUSTMAN_TROPHY),
					 tooltip = GetString(DUSTMAN_TROPHY_DESC),
					 getFunc = function() return GetSettings().trophy end,
					 setFunc = function(state) GetSettings().trophy = state end,
					 default = defaults.trophy,
				 },
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_LURE),
					tooltip = GetString(DUSTMAN_LURE_DESC),
					getFunc = function() return GetSettings().lure end,
					setFunc = function(state) GetSettings().lure = state end,
					default = defaults.lure,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FULLSTACK_BAG),
					tooltip = GetString(DUSTMAN_FULLSTACK_BAG_DESC),
					getFunc = function() return GetSettings().lureFullStack end,
					setFunc = function(state) GetSettings().lureFullStack = state end,
					default = defaults.lureFullStack,
					disabled = function() return not GetSettings().lure end,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FULLSTACK),
					tooltip = GetString(DUSTMAN_FULLSTACK_DESC),
					getFunc = function() return GetSettings().lureFullStackBank end,
					setFunc = function(state) GetSettings().lureFullStackBank = state end,
					default = defaults.lureFullStackBank,
					disabled = function() return not GetSettings().lure end,
				},
			},
		},
        {
			type = "submenu",
			name =  GetString(DUSTMAN_DAILY_LOGINS), --Stuff from daily logins
			controls = {
				{
					type = "checkbox",
					name = GetString(DUSTMAN_DL_FOOD),
					tooltip = GetString(DUSTMAN_DL_FOOD_DESC),
					getFunc = function() return GetSettings().dailyLoginFood end,
					setFunc = function(state) GetSettings().dailyLoginFood = state end,
					default = defaults.dailyLoginFood,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_DL_DRINKS),
					tooltip = GetString(DUSTMAN_DL_DRINKS_DESC),
					getFunc = function() return GetSettings().dailyLoginDrinks end,
					setFunc = function(state) GetSettings().dailyLoginDrinks = state end,
					default = defaults.dailyLoginDrinks,
				},
                {
					type = "checkbox",
					name = GetString(DUSTMAN_DL_POTIONS),
					tooltip = GetString(DUSTMAN_DL_POTIONS_DESC),
					getFunc = function() return GetSettings().dailyLoginPotions end,
					setFunc = function(state) GetSettings().dailyLoginPotions = state end,
					default = defaults.dailyLoginPotions,
				},
                {
					type = "checkbox",
					name = GetString(DUSTMAN_DL_POISONS),
					tooltip = GetString(DUSTMAN_DL_POISONS_DESC),
					getFunc = function() return GetSettings().dailyLoginPoisons end,
					setFunc = function(state) GetSettings().dailyLoginPoisons = state end,
					default = defaults.dailyLoginPoisons,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_DL_REP_KITS),
					tooltip = GetString(DUSTMAN_DL_REP_KITS_DESC),
					getFunc = function() return GetSettings().dailyLoginRepairKits end,
					setFunc = function(state) GetSettings().dailyLoginRepairKits = state end,
					default = defaults.dailyLoginRepairKits,
				},
                {
					type = "checkbox",
					name = GetString(DUSTMAN_DL_SOUL_GEMS),
					tooltip = GetString(DUSTMAN_DL_SOUL_GEMS_DESC),
					getFunc = function() return GetSettings().dailyLoginSoulGems end,
					setFunc = function(state) GetSettings().dailyLoginSoulGems = state end,
					default = defaults.dailyLoginSoulGems,
				},
			},
		},
        {
			type = "submenu",
			name =  GetString(DUSTMAN_TREASURES), --Treasures and trophies
			controls = {
				{
					type = "checkbox",
					name = GetString(DUSTMAN_TREASURE),
					tooltip = GetString(DUSTMAN_TREASURE_DESC),
					getFunc = function() return GetSettings().treasures end,
					setFunc = function(state) GetSettings().treasures = state end,
					default = defaults.treasures,
				},
                {
					type = "checkbox",
					name = GetString(DUSTMAN_TROPHIES),
					tooltip = GetString(DUSTMAN_TROPHIES_DESC),
					getFunc = function() return GetSettings().trophies end,
					setFunc = function(state) GetSettings().trophies = state end,
					default = defaults.trophies,
				},
			},
		},
		{
			type = "submenu", -- Stolen
			name = GetString(SI_GAMEPAD_ITEM_STOLEN_LABEL),
			controls = {
				{
					type = "checkbox",
					name = GetString(DUSTMAN_STOLEN),
					tooltip = GetString(DUSTMAN_STOLEN_DESC),
					getFunc = function() return GetSettings().stolen end,
					setFunc = function(state) GetSettings().stolen = state end,
					default = defaults.stolen,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY_SUPP),
					tooltip = GetString(DUSTMAN_QUALITY_SUPP_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().stolenQuality] end,
					setFunc = function(choice) GetSettings().stolenQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().stolen end,
					default = qualityChoices[defaults.stolenQuality],
				},
                {
                    type = "divider",
                },
				{
					type = "dropdown",
					name = GetString(DUSTMAN_ACT_LOWTREASURES),
					tooltip = GetString(DUSTMAN_ACT_LOWTREASURES_DESC),
					choices = lowStolenChoices,
					getFunc = function() return lowStolenChoices[GetSettings().lowStolen] end,
					setFunc = function(choice)
						GetSettings().lowStolen = reverseLowStolenChoices[choice]
						GetSettings().excludeLaunder[ITEMTYPE_TREASURE] = (choice == lowStolenChoices[2])
					end,
					disabled = function()
							if	GetSettings().stolen and GetSettings().stolenQuality > defaults.stolenQuality then return false end
							return true
						end,
					default = lowStolenChoices[defaults.lowStolen],
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_STOLEN_LAUNDER),
					tooltip = GetString(DUSTMAN_STOLEN_LAUNDER_DESC),
					getFunc = function() return GetSettings().launder end,
					setFunc = function(state) GetSettings().launder = state end,
					default = defaults.launder,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_STOLEN_CLOTHES),
					tooltip = GetString(DUSTMAN_STOLEN_CLOTHES_DESC),
					getFunc = function() return GetSettings().excludeStolenClothes end,
					setFunc = function(state) GetSettings().excludeStolenClothes = state end,
					default = defaults.excludeStolenClothes,
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM)),
				  tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_SOUL_GEM] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_SOUL_GEM] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_SOUL_GEM],
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_LOCKPICK)), -- Better to understand
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_LOCKPICK)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_TOOL] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_TOOL] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_TOOL],
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_POTION_BASE)),
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_POTION_BASE)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_POTION_BASE] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_POTION_BASE] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_POTION_BASE],
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_POISON_BASE)),
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_POISON_BASE)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_POISON_BASE] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_POISON_BASE] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_POISON_BASE],
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_POTION)),
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_POTION)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_POTION] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_POTION] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_POTION],
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_POISON)),
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_POISON)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_POISON] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_POISON] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_POISON],
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_INGREDIENT)),
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_INGREDIENT)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_INGREDIENT] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_INGREDIENT] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_INGREDIENT],
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_FURNISHING_MATERIAL)),
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_FURNISHING_MATERIAL)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_FURNISHING_MATERIAL] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_FURNISHING_MATERIAL] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_FURNISHING_MATERIAL],
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_FOOD)),
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_FOOD)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_FOOD] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_FOOD] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_FOOD],
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_DRINK)),
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_DRINK)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_DRINK] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_DRINK] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_DRINK],
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_STYLE_MATERIAL)),
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_STYLE_MATERIAL)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_STYLE_MATERIAL] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_STYLE_MATERIAL] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_STYLE_MATERIAL],
				},
				{
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)),
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_TRASH] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_TRASH] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_TRASH],
				},
                {
                    type = "divider",
                },
                {
					type = "checkbox",
					name = zo_strformat(GetString(DUSTMAN_NOLAUNDER), GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE)),
					tooltip = zo_strformat(GetString(DUSTMAN_NOLAUNDER_DESC), GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE)),
					getFunc = function() return GetSettings().excludeLaunder[ITEMTYPE_RECIPE] end,
					setFunc = function(state) GetSettings().excludeLaunder[ITEMTYPE_RECIPE] = state end,
					default = defaults.excludeLaunder[ITEMTYPE_RECIPE],
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().stolenRecipeQuality] end,
					setFunc = function(choice) GetSettings().stolenRecipeQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().excludeLaunder[ITEMTYPE_RECIPE] end,
					default = qualityChoices[defaults.stolenRecipeQuality],
				},
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_NON_LAUNDERED),
					tooltip = GetString(DUSTMAN_NON_LAUNDERED_DESC),
					getFunc = function() return GetSettings().destroyNonLaundered end,
					setFunc = function(state) GetSettings().destroyNonLaundered = state end,
					default = defaults.destroyNonLaundered,
				},
			},
		},
		{
			type = "submenu", -- Destroy
			name = GetString(SI_ITEM_ACTION_DESTROY),
			controls = {
				{
					type = "checkbox",
					name = GetString(DUSTMAN_DESTROY),
					tooltip = GetString(DUSTMAN_DESTROY_DESC),
					getFunc = function() return GetSettings().destroy end,
					setFunc = function(state) GetSettings().destroy = state end,
					default = defaults.destroy,
				},
				{
					type = "slider",
					name = GetString(DUSTMAN_DESTROY_VAL),
					tooltip = GetString(DUSTMAN_DESTROY_VAL_DESC),
					min = 0,
					max = 200,
					getFunc = function() return GetSettings().destroyValue end,
					setFunc = function(value) GetSettings().destroyValue = value end,
					disabled = function() return not GetSettings().destroy end,
					default = defaults.destroyValue,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().destroyQuality] end,
					setFunc = function(choice) GetSettings().destroyQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().destroy end,
					default = qualityChoices[defaults.destroyQuality]
				},
				{
					type = "slider",
					name = GetString(DUSTMAN_DESTROY_STOLEN),
					tooltip = GetString(DUSTMAN_DESTROY_STOLEN_DESC),
					min = 0,
					max = 500,
					getFunc = function() return GetSettings().destroyStolenValue end,
					setFunc = function(value) GetSettings().destroyStolenValue = value end,
					disabled = function() return not GetSettings().destroy end,
					default = defaults.destroyStolenValue,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_QUALITY),
					tooltip = GetString(DUSTMAN_QUALITY_DESC),
					choices = qualityChoices,
					getFunc = function() return qualityChoices[GetSettings().destroyStolenQuality] end,
					setFunc = function(choice) GetSettings().destroyStolenQuality = reverseQualityChoices[choice] end,
					disabled = function() return not GetSettings().destroy end,
					default = qualityChoices[defaults.destroyStolenQuality]
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_DESTROY_STACK),
					tooltip = GetString(DUSTMAN_DESTROY_STACK_DESC),
					getFunc = function() return GetSettings().destroyExcludeStackable end,
					setFunc = function(state) GetSettings().destroyExcludeStackable = state end,
					default = defaults.destroyExcludeStackable,
				},
			},
		},
		{
			type = "submenu",
			name = GetString(SI_MAIN_MENU_NOTIFICATIONS),
			controls = {
				{
					type = "checkbox",
					name = GetString(DUSTMAN_VERBOSE),
					tooltip = GetString(DUSTMAN_VERBOSE_DESC),
					getFunc = function() return GetSettings().notifications.verbose end,
					setFunc = function(state) GetSettings().notifications.verbose = state end,
					default = defaults.notifications.verbose
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_FOUND),
					tooltip = GetString(DUSTMAN_FOUND_DESC),
					getFunc = function() return GetSettings().notifications.found end,
					setFunc = function(state) GetSettings().notifications.found = state end,
					default = defaults.notifications.found
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_ALLITEMS),
					tooltip = GetString(DUSTMAN_ALLITEMS_DESC),
					getFunc = function() return GetSettings().notifications.allItems end,
					setFunc = function(state) GetSettings().notifications.allItems = state end,
					default = defaults.notifications.allItems
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_TOTAL),
					tooltip = GetString(DUSTMAN_TOTAL_DESC),
					getFunc = function() return GetSettings().notifications.total end,
					setFunc = function(state) GetSettings().notifications.total = state end,
					default = defaults.notifications.total
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_CONFIRM),
					tooltip = GetString(DUSTMAN_CONFIRM_DESC),
					getFunc = function() return GetSettings().notifications.sellDialog end,
					setFunc = function(state) GetSettings().notifications.sellDialog = state end,
					default = defaults.notifications.sellDialog,
				},
			},
		},
		{
			type = "submenu",
			name = GetString(SI_PLAYER_MENU_MISC),
			controls = {
				{
					type = "checkbox",
					name = GetString(DUSTMAN_JUNKKEYBIND),
					tooltip = GetString(DUSTMAN_JUNKKEYBIND_DESC),
					getFunc = function() return GetSettings().junkKeybind end,
					setFunc = function(state) GetSettings().junkKeybind = state end,
					default = defaults.junkKeybind,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_DESTROYKEYBIND),
					tooltip = GetString(DUSTMAN_DESTROYKEYBIND_DESC),
					getFunc = function() return GetSettings().destroyKeybind end,
					setFunc = function(state) GetSettings().destroyKeybind = state end,
					default = defaults.destroyKeybind,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_DONTSELL),
					tooltip = GetString(DUSTMAN_DONTSELL_DESC),
					getFunc = function() return GetSettings().notifications.sell end,
					setFunc = function(state) GetSettings().notifications.sell = state end,
					default = defaults.notifications.sell,
				},
                {
                    type = "divider",
                },
				{
					type = "checkbox",
					name = GetString(DUSTMAN_REMEMBER),
					tooltip = GetString(DUSTMAN_REMEMBER_DESC),
					getFunc = function() return GetSettings().memory end,
					setFunc = function(state) GetSettings().memory = state end,
					default = defaults.memory,
				},
				{
					type = "checkbox",
					name = GetString(DUSTMAN_MEMORYFIRST),
					tooltip = GetString(DUSTMAN_MEMORYFIRST_DESC),
					getFunc = function() return GetSettings().useMemoryFirst end,
					setFunc = function(state) GetSettings().useMemoryFirst = state end,
					disabled = function() return not GetSettings().memory end,
					default = defaults.useMemoryFirst,
				},
                {
					type = "button",
					name = GetString(DUSTMAN_CLEAR_MARKED),
					tooltip = GetString(DUSTMAN_CLEAR_MARKED_DESC),
					func = function() Dustman.ClearMarkedAsJunk() end,
					width = "half",
				},
                {
                    type = "divider",
                },
				{ 
					type    = "checkbox",
					tooltip = GetString(DUSTMAN_GLOBAL_DESC),
					name    = GetString(DUSTMAN_GLOBAL),
					warning = "ReloadUI",
					getFunc = function() return Dustman.savedVars.useGlobalSettings end,
					setFunc = function(state) 
						Dustman.savedVars.useGlobalSettings = state 
						SCENE_MANAGER:ShowBaseScene()
						zo_callLater(function() ReloadUI() end, 2000)
					end,
					default = defaults.useGlobalSettings,
				},
				{
					type = "dropdown",
					name = GetString(DUSTMAN_IMPORT),
					tooltip = GetString(DUSTMAN_IMPORT_DESC),
					choices = charactersKnown,
					width = "full",
					getFunc = function() return GetUnitName('player') end,
					warning = "ReloadUI",
					disabled = function() return GetSettings().useGlobalSettings end,
					setFunc = function(choice)
					
						local playerId = GetCurrentCharacterId()
						local referenceId = GetIdFromName(choice)
						
						if referenceId then
							
							for entryIndex, entryData in pairs(Dustman_SavedVariables.Default[GetDisplayName()][referenceId]) do
								if entryIndex ~= "$LastCharacterName" then
									Dustman_SavedVariables[entryIndex] = entryData
									Dustman_SavedVariables.Default[GetDisplayName()][playerId][entryIndex] = entryData
								end
							end
							
							for entryIndex, entryData in pairs(Dustman_Junk_SavedVariables.Default[GetDisplayName()][referenceId]) do
								if entryIndex ~= "$LastCharacterName" then
									Dustman_Junk_SavedVariables.Default[GetDisplayName()][playerId][entryIndex] = entryData
								end
							end
							
							SCENE_MANAGER:ShowBaseScene()
							CHAT_SYSTEM:AddMessage(zo_strformat(DUSTMAN_IMPORTED, choice))
							
							zo_callLater(function() ReloadUI() end, 2000)
							
						end
					end,
				},
                {
                    type = "divider",
                },
				{
					type = "button",
					name = GetString(DUSTMAN_SWEEP),
					tooltip = GetString(DUSTMAN_SWEEP_DESC),
					func = function() Dustman.Sweep() end,
                    width = "half",
				},
			},
		},
	}
	LAM2:RegisterOptionControls("Dustman_OptionsPanel", optionsData)
end