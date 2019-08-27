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

-- Leaked for menu & data
Dustman = {}
Dustman.savedVars = {}
Dustman.globalSavedVars = {}

local ADDON_NAME = "Dustman"

-- Libraries ------------------------------------------------------------------
local LR = LibResearch

-- Local variables ------------------------------------------------------------
local usableIngredients = {}
local hoveredBagId
local hoveredSlotId
local dustmanKeybinds
local hoveredItemCanBeJunked
local hoveredItemCanBeDestroyed
local isItemJunk
local descriptorName = GetString(SI_ITEM_ACTION_MARK_AS_JUNK)
local markedAsJunk = {}
local globalMarkedAsJunk = {}

local TUTORIAL_ACHIEVEMENT = 993
local inventorySingleSlotUpdate

local defaults = {
	worldname = GetWorldName(),
	useGlobalSettings = true,
	--equipable items
	equipment = {
		notrait = false,
		notraitQuality = ITEM_QUALITY_NORMAL,
		enabled = false,
		equipmentQuality = ITEM_QUALITY_NORMAL,
		ornate = true,
		ornateQuality = ITEM_QUALITY_MAGIC,
		whiteZeroValue = false,
		keepIntricate = true,
		keepIntricateIfNotMaxed = false,
		keepResearchable = true,
		keepNirnhoned = true,
		keepSetItems = true,
		keepRareStyle = false,
		keepMaelAndMast = true,
		keepLevel = 1,
		keepLevelOrnate = false,
		--jewels
		notraitJewels = false,
		jewelsEnabled = false,
		jewelsQuality = ITEM_QUALITY_NORMAL,
		jewelsOrnate = true,
		jewelsOrnateQuality = ITEM_QUALITY_MAGIC,
        keepIntricateJewels = true,
		keepIntricateJewelsIfNotMaxed = false,
        keepResearchableJewels = true,
		keepJewelsSetItems = true,
		jewelsSetQuality = ITEM_QUALITY_MAGIC,
	},
	--crafting materials
	crafting = {
		lowLevelBlacksmithingMaterials = false,
		lowLevelBlacksmithingRawMaterials = false,
		lowLevelClothingMaterials = false,
		lowLevelClothingRawMaterials = false,
		lowLevelWoodworkingMaterials = false,
		lowLevelWoodworkingRawMaterials = false,
		lowLevelJewelryMaterials = false,
		lowLevelJewelryRawMaterials = false,
	},
	--provisioning
	provisioning = {
		recipe = false,
		recipeQuality = ITEM_QUALITY_MAGIC,
		unusable = false,
		all = false,
		dish = true,
		drink = true,
		excludeRareAdditives = true,
		fullStack = false,
	},
	--glyphs
	glyphs = false,
	glyphsQuality = ITEM_QUALITY_NORMAL,
	keepLevelGlyphs = 1,
	--food/drink
	foodAll = false,
	foodQuality = ITEM_QUALITY_NORMAL,
	--fishing
	lure = false,
	lureFullStack = false,
	lureFullStackBank = false,
	trophy = false,
	trophies = false,
    --daily login items
    dailyLoginFood = false,
    dailyLoginDrink =false,
    dailyLoginPoisons = false,
    dailyLoginPotions = false,
    dailyLoginRepairKits = false,
    dailyLoginSoulGems = false,
	-- Enchanting
	enchanting = {
		enchantingAspect = false,
		aspectQuality = ITEM_QUALITY_NORMAL,
		aspectFullStack = false,
	},
	--potions
	potions = false,
	fullStackBagPotions = false,
	fullStackBankPotions = false,
	keepPotionsLevel = 1,
	--poisons
	poisons = false,
	fullStackBagPoisons = false,
	fullStackBankPoisons = false,
	poisonsSolvants = false,
	fullStackBagPoisonsSolvants = false,
	fullStackBankPoisonsSolvants = false,
	keepPoisonsLevel = 1,
	-- soul gems
	emptyGems = false,
	-- treasures
	treasures = false,
	-- treasure maps
	treasureMaps = false,
	treasureMapsDestroy = false,
	--style
	styleMaterial = {
		["33252"] = false, --Adamantite (Altmer)
		["46150"] = false, --Argentum (Primal)
		["33194"] = false, --Bone (Bosmer)
		["46149"] = false, --Copper (Barbaric)
		["33256"] = false, --Corundum (Nord)
		["46151"] = false, --Daedra Heart (Daedric)
		["33150"] = false, --Flint (Argonian)
		["33257"] = false, --Manganese (Orc)
		["33251"] = false, --Molybdenum (Breton)
		["33255"] = false, --Moonstone (Khajiit)
		["33254"] = false, --Nickel (Imperial)
		["33253"] = false, --Obsidian (Dunmer)
		["46152"] = false, --Palladium (Ancient Elf)
		["33258"] = false, --Starmetal (Redguard)
	},
	--traits
	traitMaterial = {
		--armor traits
		["23221"] = false, --Almandine (Well-Fitted) 
		["30219"] = false, --Bloodstone (Infused) 
		["23219"] = false, --Diamond (Impenetrable)
		["4442"]  = false, --Emerald (Training) 
		["23171"] = false, --Garnet (Exploration)
		["4456"]  = false, --Quartz (Sturdy) 
		["23173"] = false, --Sapphire (Divines) 
		["30221"] = false, --Sardonyx (Reinforced)
		--weapon traits
		["23204"] = false, --Amethyst (Charged) 
		["23165"] = false, --Carnelian (Training) 
		["23203"] = false, --Chysolite (Powered)
		["16291"] = false, --Citrine (Weighted)
		["23149"] = false, --Fire Opal (Sharpened)
		["810"]	= false, --Jade (Infused)
		["4486"]  = false, --Ruby (Precise)
		["813"]	= false, --Turquoise (Defending)
		--jewelry traits
		["135156"] = false, --Antimony (Healthy)
		["135155"] = false, --Cobalt (Arcane)
		["135157"] = false, --Zinc (Robust)
		["139412"] = false, --Gilding Wax (Swift)
		["139413"] = false, --Dibellium (Harmony)
		["139409"] = false, --Dawn-Prism (Triune)
		["139414"] = false, --Slaughterstone (Bloodthirsty)
		["139410"] = false, --Titanium (Protective)
		["139411"] = false, --Aurbic Amber (Infused)		
	},
	itemTraits = {
		[ITEM_TRAIT_TYPE_ARMOR_DIVINES] = false,
		[ITEM_TRAIT_TYPE_ARMOR_EXPLORATION] = false,
		[ITEM_TRAIT_TYPE_ARMOR_IMPENETRABLE] = false,
		[ITEM_TRAIT_TYPE_ARMOR_INFUSED] = false,
		[ITEM_TRAIT_TYPE_ARMOR_PROSPEROUS] = false,
		[ITEM_TRAIT_TYPE_ARMOR_REINFORCED] = false,
		[ITEM_TRAIT_TYPE_ARMOR_STURDY] = false,
		[ITEM_TRAIT_TYPE_ARMOR_TRAINING] = false,
		[ITEM_TRAIT_TYPE_ARMOR_WELL_FITTED] = false,
		[ITEM_TRAIT_TYPE_WEAPON_CHARGED] = false,
		[ITEM_TRAIT_TYPE_WEAPON_DECISIVE] = false,
		[ITEM_TRAIT_TYPE_WEAPON_DEFENDING] = false,
		[ITEM_TRAIT_TYPE_WEAPON_INFUSED] = false,
		[ITEM_TRAIT_TYPE_WEAPON_POWERED] = false,
		[ITEM_TRAIT_TYPE_WEAPON_PRECISE] = false,
		[ITEM_TRAIT_TYPE_WEAPON_SHARPENED] = false,
		[ITEM_TRAIT_TYPE_WEAPON_TRAINING] = false,
		[ITEM_TRAIT_TYPE_WEAPON_WEIGHTED] = false,
		[ITEM_TRAIT_TYPE_JEWELRY_ARCANE] = false,
		[ITEM_TRAIT_TYPE_JEWELRY_BLOODTHIRSTY] = false,
		[ITEM_TRAIT_TYPE_JEWELRY_ROBUST] = false,
		[ITEM_TRAIT_TYPE_JEWELRY_HEALTHY] = false,
		[ITEM_TRAIT_TYPE_JEWELRY_HARMONY] = false,
		[ITEM_TRAIT_TYPE_JEWELRY_INFUSED] = false,
		[ITEM_TRAIT_TYPE_JEWELRY_PROTECTIVE] = false,
		[ITEM_TRAIT_TYPE_JEWELRY_TRIUNE] = false,
		[ITEM_TRAIT_TYPE_JEWELRY_SWIFT] = false,
	},
	junkTraitSets = false,
	styleFullStack = false,
	traitFullStack = false,
	--destroy items
	destroy = false,
	destroyExcludeStackable = false,
	destroyValue = 0,
	destroyQuality = ITEM_QUALITY_NORMAL,
	destroyStolenValue = 0,
	destroyStolenQuality = ITEM_QUALITY_NORMAL,
	--notifications
	notifications = {
		verbose = false,
		found = false,
		allItems = true,
		total = true,
		sellDialog = true,
		sell = true,
	},
	--stolen items
	stolen = false,
	lowStolen = 1,
	excludeStolenClothes = true,
	launder = false,
	stolenQuality = ITEM_QUALITY_NORMAL,
	stolenRecipeQuality = ITEM_QUALITY_NORMAL,
	excludeLaunder = {
		[ITEMTYPE_SOUL_GEM] = false,
		[ITEMTYPE_TOOL] = false,
		[ITEMTYPE_POTION_BASE] = false,
		[ITEMTYPE_POISON_BASE] = false,
		[ITEMTYPE_INGREDIENT] = false,
		[ITEMTYPE_STYLE_MATERIAL] = false,
		[ITEMTYPE_FOOD] = false,
		[ITEMTYPE_DRINK] = false,
		[ITEMTYPE_TRASH] = false,
		[ITEMTYPE_TREASURE] = false,
		[ITEMTYPE_FURNISHING_MATERIAL] = false,
		[ITEMTYPE_RECIPE] = false,
		[ITEMTYPE_POISON] = false,
		[ITEMTYPE_POTION] = false,
	},
	destroyNonLaundered = false,
	--remember user marked junk
	memory = false,
	useMemoryFirst = false,
	housingRecipes = false,
	housingRecipesQuality = ITEM_QUALITY_NORMAL,
	junkKeybind = false,
	destroyKeybind = false,
}

-- Local functions ------------------------------------------------------------
local function MyPrint(message)
	CHAT_SYSTEM:AddMessage(message)
end

local function CanGemifyItem(bagId, slotIndex)
   if IsItemFromCrownCrate(bagId, slotIndex) and not IsItemPlayerLocked(bagId, slotIndex) then
      local itemsRequired, gemsAwarded = GetNumCrownGemsFromItemManualGemification(bagId, slotIndex)
      return gemsAwarded > 0 and itemsRequired > 0
   end
   return false
end

local function BuildUsableIngredientsList()
	local RECIPE_LIST_INDEX_MAX_PROVISIONNER = 16
	for recipeListIndex = 1, RECIPE_LIST_INDEX_MAX_PROVISIONNER do -- 16 provisionning, after it's housing
		local _, numRecipes = GetRecipeListInfo(recipeListIndex)
		for recipeIndex = 1, numRecipes do
			local known, _, numIngredients, _, _, _  = GetRecipeInfo(recipeListIndex, recipeIndex)
			for ingredientIndex = 1, numIngredients do
				local link = GetRecipeIngredientItemLink(recipeListIndex, recipeIndex, ingredientIndex, LINK_STYLE_DEFAULT)
				if link ~= "" then
					local itemId = select(4, ZO_LinkHandler_ParseLink(link))
					if itemId then
						usableIngredients[itemId] = known
					end
				end
			end
		end
	end
end

local function IsFullStackInBag(BackPackSlotId, bagId, itemLink)
	local stackCountBackpack, stackCountBank, stackCountCraftBag = GetItemLinkStacks(itemLink)
	local _, maxStack = GetSlotStackSize(BAG_BACKPACK, BackPackSlotId)
	if bagId == BAG_BACKPACK then
		return stackCountBackpack >= maxStack
	elseif bagId == BAG_BANK then
		return stackCountBank + stackCountCraftBag >= maxStack
	end
end

local function IsItemProtected(bagId, slotId)

	-- ESOUI
	if IsItemPlayerLocked(bagId, slotId) then
		return true
	end

	--Item Saver support
	if ItemSaver_IsItemSaved and ItemSaver_IsItemSaved(bagId, slotId) then
		return true
	end

	--FCO ItemSaver support
	if FCOIS then
		--FCOIS version <1.0.0
		if FCOIsMarked then
			local FCOiconsToCheck = {}
			--Build icons to check table, and don't add the "coin" icon, because these items should be sold
			for i=1, FCOIS.numVars.gFCONumFilterIcons, 1 do
				if i ~= FCOIS_CON_ICON_SELL then
					FCOiconsToCheck[i] = i
				end
			end
			return FCOIsMarked(GetItemInstanceId(bagId, slotId), FCOiconsToCheck)
		else
			--FCOIS version 1.0.0 and higher
			--Check all marker icons but exclude the icon #5 (Coins symbol = item marked to sell) and check dynamic icons if sell is allowed
			if FCOIS.IsJunkLocked then
				return FCOIS.IsJunkLocked(bagId, slotId)
			end
		end
	end

	--FilterIt support
	if FilterIt and FilterIt.AccountSavedVariables and FilterIt.AccountSavedVariables.FilteredItems then
		local sUniqueId = Id64ToString(GetItemUniqueId(bagId, slotId))
		if FilterIt.AccountSavedVariables.FilteredItems[sUniqueId] then
			return FilterIt.AccountSavedVariables.FilteredItems[sUniqueId] ~= FILTERIT_VENDOR
		end
	end

	return false
	
end

local function IsItemNeededForResearch(itemLink)

	--CraftStore 3.30 support
	if CS and CS.GetTrait and CS.account and CS.account.crafting then
		local craft, row, trait = CS.GetTrait(itemLink)
		-- Loop all chars known by CS
		for char, data in pairs(CS.account.crafting.studies) do
			--if a char study this item
			if data[craft] and data[craft][row] and (data[craft][row]) then
				-- If this char didn't yet researched this item
				if CS.account.crafting.research[char][craft] and CS.account.crafting.research[char][craft][row] and CS.account.crafting.research[char][craft][row][trait] == false then
					return true
				end
			end
		end
		return false
	end

	--libResearch
	local _, isResearchable = LR:GetItemTraitResearchabilityInfo(itemLink)
	return isResearchable
end

local function pairsByQuality(bagCache)

	local arraySorted = {}
	for key, data in pairs(bagCache) do table.insert(arraySorted, data) end
	
	local function sortByPosition(a, b)
		return a.quality > b.quality
	end
	
	table.sort(arraySorted, sortByPosition)
	
	return arraySorted
	
end

local function SellJunkItems(isFence)
	
	if GetInteractionType() == INTERACTION_VENDOR then
		
		local total = 0
		local count = 0
		local transactions = 0
		local transactionsMessage = true
		local hagglingBonus, hasHagglingBonus
		
		local bagCache = SHARED_INVENTORY:GenerateFullSlotData(nil, BAG_BACKPACK)
		
		if isFence then
			hagglingBonus = GetNonCombatBonus(NON_COMBAT_BONUS_HAGGLING)
			hasHagglingBonus = hagglingBonus > 0
			bagCache = pairsByQuality(bagCache)
		end
		
		for slotId, data in pairs(bagCache) do
			if transactions < 50 then
				if data.isJunk then
					if data.stolen == isFence then
						if isFence then
							local totalSells, sellsUsed = GetFenceSellTransactionInfo()
							if sellsUsed == totalSells then
								ZO_Alert(UI_ALERT_CATEGORY_ALERT, SOUNDS.NEGATIVE_CLICK, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT))
								if total > 0 and Dustman.GetSettings().notifications.total then
									MyPrint(zo_strformat(DUSTMAN_FORMAT_TOTAL, count, total))
								end
								return
							end
						end
						local name = GetItemLink(BAG_BACKPACK, data.slotIndex)
						
						if IsItemProtected(BAG_BACKPACK, data.slotIndex) then
							SetItemIsJunk(BAG_BACKPACK, data.slotIndex, false)
							MyPrint(zo_strformat(DUSTMAN_FORMAT_NOTSOLD, name))
						else
							SellInventoryItem(BAG_BACKPACK, data.slotIndex, data.stackCount)

							local sellPrice = data.sellPrice
							if isFence and hasHagglingBonus then
								sellPrice = zo_round(sellPrice * (1 + hagglingBonus / 100))
							end
							
							if Dustman.GetSettings().notifications.allItems then
								local RECEIPT_FORMAT
								if sellPrice == 0 then
									RECEIPT_FORMAT = GetString(DUSTMAN_FORMAT_ZERO)
								else
									RECEIPT_FORMAT = GetString(DUSTMAN_FORMAT_GOLD)
								end
								
								MyPrint(zo_strformat(RECEIPT_FORMAT, name, data.stackCount, sellPrice * data.stackCount))
							end
							count = count + data.stackCount
							transactions = transactions + 1
							total = total + sellPrice * data.stackCount
						end
					end
				end
			elseif transactionsMessage then
				transactionsMessage = false
				MyPrint(GetString(DUSTMAN_ZOS_RESTRICTIONS))
			end
		end
		
		if total > 0 and Dustman.GetSettings().notifications.total then
			MyPrint(zo_strformat(DUSTMAN_FORMAT_TOTAL, count, total))
		end
		
	end
	
end

local function LaunderingItem(bagCache)
	local total = 0
	local count = 0
	local transactions = 0
	local transactionsMessage = true
	
	bagCache = pairsByQuality(bagCache)
	
	for slotId, data in pairs(bagCache) do
		if transactions < 50 then
			if data.toLaunder then
				local totalSells, sellsUsed = GetFenceLaunderTransactionInfo()
				if sellsUsed == totalSells then
					ZO_Alert(UI_ALERT_CATEGORY_ALERT, SOUNDS.NEGATIVE_CLICK, GetString("SI_ITEMLAUNDERRESULT", ITEM_LAUNDER_RESULT_AT_LIMIT))
					if total > 0 and Dustman.GetSettings().notifications.total then
						MyPrint(zo_strformat(DUSTMAN_FORMATL_TOTAL, count, total))
					end
					return
				end
				local name = GetItemLink(BAG_BACKPACK, data.slotIndex)
				if IsItemProtected(BAG_BACKPACK, data.slotIndex) then
					MyPrint(zo_strformat(DUSTMAN_FORMATL_NOTSOLD, name))
				else
				
					local numFreeSlots = GetNumBagFreeSlots(BAG_BACKPACK)
					local qtyToLaunder = math.min(data.stackCount, (totalSells - sellsUsed))
					
					if numFreeSlots > 0 or data.stackCount <= (totalSells - sellsUsed) then
						LaunderItem(BAG_BACKPACK, data.slotIndex, qtyToLaunder)
						if Dustman.GetSettings().notifications.allItems then
							local RECEIPT_FORMAT
							if data.launderPrice == 0 then
								RECEIPT_FORMAT = GetString(DUSTMAN_FORMATL_ZERO)
							else
								RECEIPT_FORMAT = GetString(DUSTMAN_FORMATL_GOLD)
							end
							MyPrint(zo_strformat(RECEIPT_FORMAT, name, qtyToLaunder, data.launderPrice * qtyToLaunder))
						end
						transactions = transactions + 1
						count = count + qtyToLaunder
						total = total + data.launderPrice * qtyToLaunder
					end
				end
			end
		elseif transactionsMessage then
			transactionsMessage = false
			MyPrint(GetString(DUSTMAN_ZOS_RESTRICTIONS))
		end
	end

	if total > 0 and Dustman.GetSettings().notifications.total then
		MyPrint(zo_strformat(DUSTMAN_FORMATL_TOTAL, count, total))
	end
	
end

local function HandleJunk(bagId, slotId, itemLink, sellPrice, forceDestroy, ruleName, itemCode)

	if Dustman.GetSettings().destroy or forceDestroy then
		local destroy = false
		if forceDestroy then
			destroy = true
		else
			local quality = GetItemLinkQuality(itemLink)
			local isStolen = IsItemLinkStolen(itemLink)

			local _, maxStack = GetSlotStackSize(bagId, slotId)
			if isStolen then
				destroy = quality <= Dustman.GetSettings().destroyStolenQuality and (sellPrice <= Dustman.GetSettings().destroyStolenValue and ((not Dustman.GetSettings().destroyExcludeStackable) or (Dustman.GetSettings().destroyExcludeStackable and maxStack <= 1)))
			else
				destroy = quality <= Dustman.GetSettings().destroyQuality and (sellPrice == 0 or (sellPrice <= Dustman.GetSettings().destroyValue and ((not Dustman.GetSettings().destroyExcludeStackable) or (Dustman.GetSettings().destroyExcludeStackable and maxStack <= 1))))
			end
		end

		if destroy then
			DestroyItem(bagId, slotId)
			if Dustman.GetSettings().notifications.verbose then
				MyPrint(zo_strformat(DUSTMAN_NOTE_DESTROY, itemLink, ruleName))
			end
			return
		end
	end
	if not IsItemJunk(bagId, slotId) then
		local memory = Dustman.GetSettings().memory-- should be deleted, same line next and last
		Dustman.GetSettings().memory = false	
		local junked={}
		if Dustman.savedVars.useGlobalSettings then
			junked = globalMarkedAsJunk
		else
			junked = markedAsJunk
		end
		if not itemCode or (itemCode and junked[itemCode]) then
			SetItemIsJunk(bagId, slotId, true) -- We do mark as junk all basic items and those who have been manually set as junk. if they have been moved out from junk by users, no need to re-re-mark them as non junk.
			if Dustman.GetSettings().notifications.verbose then
				MyPrint(zo_strformat(DUSTMAN_NOTE_JUNK, itemLink, ruleName))
			end
		end
		Dustman.GetSettings().memory = memory
	end
	
end

-- Event handlers -------------------------------------------------------------
local function OnInventorySingleSlotUpdate(_, bagId, slotId, isNewItem)

	local junked={}
	if Dustman.savedVars.useGlobalSettings then
		junked = globalMarkedAsJunk
	else
		junked = markedAsJunk
	end

	if IsUnderArrest() then return end -- Avoid check when a guard destroy stolen items
	if IsItemJunk(bagId, slotId) then return end --we do not need to check junk again
	if Roomba and Roomba.WorkInProgress and Roomba.WorkInProgress() then return end --support for Roomba
	if BankManagerRevived_inProgress and BankManagerRevived_inProgress() then return end --support for BankManagerRevived
	
	local _, stackCount, sellPrice, _, _, equipType, itemStyle, quality = GetItemInfo(bagId, slotId)
	
	if stackCount < 1 then return end -- empty slot	
	local itemLink = GetItemLink(bagId, slotId)
	local itemType, specializedItemType = GetItemLinkItemType(itemLink)
	local itemId = select(4, ZO_LinkHandler_ParseLink(itemLink))
	local level = GetItemLevel(bagId, slotId)


	
	local dontLaunder
	-- Stolen item to do not launder, not in the main block because it must be re-evaluated.
	if IsItemLinkStolen(itemLink) then
		if itemType ~= ITEMTYPE_TREASURE then
			if (Dustman.GetSettings().excludeLaunder[itemType] and quality <= ITEM_QUALITY_NORMAL and (itemType ~= ITEMTYPE_STYLE_MATERIAL or (itemType == ITEMTYPE_STYLE_MATERIAL and Dustman.GetSettings().styleMaterial[itemId] ~= nil))) or (itemType == ITEMTYPE_RECIPE and quality <= Dustman.GetSettings().stolenRecipeQuality) then
				if Dustman.GetSettings().destroyNonLaundered then
					HandleJunk(bagId, slotId, itemLink, sellPrice, true, "FENCE-TO-DESTROY") -- Will destroy the item directly
					return
				else
					dontLaunder = true
				end
			end
		else
			if Dustman.GetSettings().lowStolen == 2 and quality < Dustman.GetSettings().stolenQuality then
				HandleJunk(bagId, slotId, itemLink, sellPrice, true, "FENCE-TO-DESTROY") -- Will destroy the item directly
				return
			elseif Dustman.GetSettings().lowStolen ~= 3 then
				dontLaunder = true
			end
		end
	end
		
	--ignored items
	if Dustman.IsOnIgnoreList(itemId) then
		return
	--support for Item Saver and FCO ItemSaver
	elseif IsItemProtected(bagId, slotId) then
		return
	--items marked by user (if it is set as a high priority filter)
	elseif Dustman.GetSettings().useMemoryFirst and Dustman.GetSettings().memory then
		local itemCode = zo_strjoin("_", itemId, quality, level)
		if junked[itemCode] ~= nil then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "USER-BEFORE", itemCode)
			return
		end
	end
    
    --daily login items
    if not IsItemFromCrownCrate(bagId, slotId) then
        if Dustman.GetSettings().dailyLoginFood and itemType==ITEMTYPE_FOOD and string.find(string.upper(GetItemLinkName(itemLink)), GetString(DUSTMAN_CROWN)) then
            HandleJunk(bagId, slotId, itemLink, sellPrice, true, "DL FOOD")
            return
        end
        --drinks
        if Dustman.GetSettings().dailyLoginDrinks and itemType==ITEMTYPE_DRINK and string.find(string.upper(GetItemLinkName(itemLink)), GetString(DUSTMAN_CROWN)) then
            HandleJunk(bagId, slotId, itemLink, sellPrice, true, "DL DRINK")
            return
        end
        --potions
        if Dustman.GetSettings().dailyLoginPotions and itemType==ITEMTYPE_POTION and quality>ITEM_QUALITY_NORMAL then
            HandleJunk(bagId, slotId, itemLink, sellPrice, true, "DL POTION")
            return
        end
        --potions
        if Dustman.GetSettings().dailyLoginPoisons and itemType==ITEMTYPE_POISON and quality>ITEM_QUALITY_NORMAL then
            HandleJunk(bagId, slotId, itemLink, sellPrice, true, "DL POISON")
            return
        end
        --crown repair kits
        if Dustman.GetSettings().dailyLoginRepairKits and itemType==ITEMTYPE_CROWN_REPAIR then
            HandleJunk(bagId, slotId, itemLink, sellPrice, true, "DL REPAIR KIT")
            return
        end
        --soul gems
        if Dustman.GetSettings().dailyLoginSoulGems and itemType==ITEMTYPE_SOUL_GEM and quality>ITEM_QUALITY_MAGIC then
            HandleJunk(bagId, slotId, itemLink, sellPrice, true, "DL SOUL GEM")
            return
        end
	end
    
    if quality == ITEM_QUALITY_LEGENDARY then return end
    
	-- stolen clothes
	if Dustman.GetSettings().excludeStolenClothes and itemType == ITEMTYPE_ARMOR and GetItemLinkArmorType(itemLink) == ARMORTYPE_NONE and
	equipType ~= EQUIP_TYPE_NECK and equipType ~= EQUIP_TYPE_RING and equipType ~= EQUIP_TYPE_COSTUME and equipType ~= EQUIP_TYPE_INVALID then
		return
	--stolen items with no other use then selling to fence
	elseif Dustman.GetSettings().stolen and itemType == ITEMTYPE_TREASURE and ((IsItemLinkStolen(itemLink) and quality >= Dustman.GetSettings().stolenQuality) or not IsItemLinkStolen(itemLink)) then
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "FENCE")
		return
	--trash items
	elseif itemType == ITEMTYPE_TRASH then
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "TRASH")
		return
	--crafting low level materials (blacksmithing)
	elseif Dustman.GetSettings().crafting.lowLevelBlacksmithingMaterials and itemType == ITEMTYPE_BLACKSMITHING_MATERIAL and itemId ~= "64489" then
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "BLACKSMITHING LOW LEVEL MATERIAL")
		return
	elseif Dustman.GetSettings().crafting.lowLevelBlacksmithingRawMaterials and itemType == ITEMTYPE_BLACKSMITHING_RAW_MATERIAL and itemId ~= "71198" then
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "BLACKSMITHING LOW LEVEL RAW MATERIAL")
		return
	--crafting low level materials (clothing)
	elseif Dustman.GetSettings().crafting.lowLevelClothingMaterials and itemType == ITEMTYPE_CLOTHIER_MATERIAL and itemId ~= "64504" and itemId ~= "64506" then
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "CLOTHING LOW LEVEL MATERIAL")
		return
	elseif Dustman.GetSettings().crafting.lowLevelClothingRawMaterials and itemType == ITEMTYPE_CLOTHIER_RAW_MATERIAL and itemId ~= "71200" and itemId ~= "71239" then
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "CLOTHING LOW LEVEL RAW MATERIAL")
		return
	--crafting low level materials (woodworking)
	elseif Dustman.GetSettings().crafting.lowLevelWoodworkingMaterials and itemType == ITEMTYPE_WOODWORKING_MATERIAL and itemId ~= "64502" then
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "WOODWORKING LOW LEVEL MATERIAL")
		return
	elseif Dustman.GetSettings().crafting.lowLevelWoodworkingRawMaterials and itemType == ITEMTYPE_WOODWORKING_RAW_MATERIAL and itemId ~= "71199" then
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "WOODWORKING LOW LEVEL RAW MATERIAL")
		return
	--crafting low level materials (jewelry)
	elseif Dustman.GetSettings().crafting.lowLevelJewelryMaterials and itemType == ITEMTYPE_JEWELRYCRAFTING_MATERIAL and itemId ~= "135146" then
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "JEWELRY LOW LEVEL MATERIAL")
		return
	elseif Dustman.GetSettings().crafting.lowLevelJewelryRawMaterials and itemType == ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL and itemId ~= "135145" then
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "JEWELRY LOW LEVEL RAW MATERIAL")
		return
	--style material
	elseif itemType == ITEMTYPE_STYLE_MATERIAL then
		if Dustman.GetSettings().styleMaterial[itemId] and ((not Dustman.GetSettings().styleFullStack) or (Dustman.GetSettings().styleFullStack and IsFullStackInBag(slotId, BAG_BANK, itemLink))) then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "STYLE")
			return
		end
	--armor/weapon/jewelry traits
	elseif itemType == ITEMTYPE_ARMOR_TRAIT or itemType == ITEMTYPE_WEAPON_TRAIT or itemType==ITEMTYPE_JEWELRY_TRAIT then
		if isNewItem and Dustman.GetSettings().notifications.found and (itemId == "56862" or itemId == "56863") and not Dustman.GetSettings().traitMaterial[itemId] then
			MyPrint(zo_strformat(DUSTMAN_NOTE_INTERESTING, itemLink))
		end
		if Dustman.GetSettings().traitMaterial[itemId] and not (itemId == "56862" or itemId == "56863") and ((not Dustman.GetSettings().traitFullStack) or (Dustman.GetSettings().traitFullStack and IsFullStackInBag(slotId, BAG_BANK, itemLink))) then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "TRAIT")
			return
		end
	--potions, IsItemBound is here for crown store potions. 24th item flag is ~= 0 when a potion is crafted
	elseif itemType == ITEMTYPE_POTION and IsItemBound(bagId, slotId) == false then
		if Dustman.GetSettings().potions and select(24, ZO_LinkHandler_ParseLink(itemLink)) == "0" and (not Dustman.IsWhitelistedPotion(itemId)) then
			if (not (Dustman.GetSettings().fullStackBagPotions and (not IsFullStackInBag(slotId, BAG_BACKPACK, itemLink)))) and (not (Dustman.GetSettings().fullStackBankPotions and (not IsFullStackInBag(slotId, BAG_BANK, itemLink)))) then
				local requiredChampionPoints = GetItemLinkRequiredChampionPoints(itemLink)
				if Dustman.GetSettings().keepPotionsLevel == 1 or (Dustman.GetSettings().keepPotionsLevel > 1 and requiredChampionPoints and requiredChampionPoints + 10000 < Dustman.GetSettings().keepPotionsLevel) then
					HandleJunk(bagId, slotId, itemLink, sellPrice, false, "POTION")
					return
				end
			end
		end
	--poisons, IsItemBound is here for crown store poisons. 24th item flag is ~= 0 when a poison is crafted
	elseif itemType == ITEMTYPE_POISON and IsItemBound(bagId, slotId) == false then
		if Dustman.GetSettings().poisons and select(24, ZO_LinkHandler_ParseLink(itemLink)) == "0" and (not Dustman.IsWhitelistedPotion(itemId)) then
			if (not (Dustman.GetSettings().fullStackBagPoisons and (not IsFullStackInBag(slotId, BAG_BACKPACK, itemLink)))) and (not (Dustman.GetSettings().fullStackBankPoisons and (not IsFullStackInBag(slotId, BAG_BANK, itemLink)))) then
				local requiredChampionPoints = GetItemLinkRequiredChampionPoints(itemLink)
				if Dustman.GetSettings().keepPoisonsLevel == 1 or (Dustman.GetSettings().keepPoisonsLevel > 1 and requiredChampionPoints and requiredChampionPoints + 10000 < Dustman.GetSettings().keepPoisonsLevel) then
					HandleJunk(bagId, slotId, itemLink, sellPrice, false, "POISON")
					return
				end
			end
		end
	--poisons
	elseif itemType == ITEMTYPE_POISON_BASE and Dustman.GetSettings().poisonsSolvants then
		if (not (Dustman.GetSettings().fullStackBagPoisonsSolvants and (not IsFullStackInBag(slotId, BAG_BACKPACK, itemLink)))) and (not (Dustman.GetSettings().fullStackBankPoisonsSolvants and (not IsFullStackInBag(slotId, BAG_BANK, itemLink)))) then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "POISON-BASE")
			return
		end
    --treasures
    elseif itemType == ITEMTYPE_TREASURE and Dustman.GetSettings().treasures and not IsItemLinkStolen(itemLink) then
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "TREASURE")
		return
	--treasure maps
	elseif Dustman.GetSettings().treasureMaps and itemType == ITEMTYPE_TROPHY and specializedItemType == SPECIALIZED_ITEMTYPE_TROPHY_TREASURE_MAP then
		if Dustman.GetSettings().treasureMapsDestroy then
			HandleJunk(bagId, slotId, itemLink, sellPrice, true, "TREASURE MAP")
			return
		else
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "TREASURE MAP")
			return
		end
	--equipable items
	elseif itemType == ITEMTYPE_ARMOR or itemType == ITEMTYPE_WEAPON then
		
		--exclude crafted items
		if IsItemLinkCrafted(itemLink) then return end

		local trait = GetItemTrait(bagId, slotId)
		local isResearchable = IsItemNeededForResearch(itemLink)
		local craftingType = LR:GetItemCraftingSkill(itemLink)
		local isRareStyle = (craftingType ~= -1) and not Dustman.IsCommonStyle(itemStyle)
		local isSet, setName = GetItemLinkSetInfo(itemLink, false)
		local isNirnhoned = trait == ITEM_TRAIT_TYPE_ARMOR_NIRNHONED or trait == ITEM_TRAIT_TYPE_WEAPON_NIRNHONED
		local requiredLevel = GetItemLinkRequiredLevel(itemLink)
		local requiredChampionPoints = GetItemLinkRequiredChampionPoints(itemLink)
		
		if isNewItem and Dustman.GetSettings().notifications.found then
			if isResearchable and Dustman.GetSettings().equipment.keepResearchable and not (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) then
				MyPrint(zo_strformat(DUSTMAN_NOTE_RESEARCH, itemLink, GetString("SI_ITEMTRAITTYPE", trait)))
			elseif isNirnhoned and Dustman.GetSettings().equipment.keepNirnhoned then
				MyPrint(zo_strformat(DUSTMAN_NOTE_NIRNHONED, GetString("SI_ITEMTRAITTYPE", trait), itemLink))
			end
            if isResearchable and Dustman.GetSettings().equipment.keepResearchableJewels and (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) then
				MyPrint(zo_strformat(DUSTMAN_NOTE_RESEARCH, itemLink, GetString("SI_ITEMTRAITTYPE", trait)))
            end
			if isRareStyle and Dustman.GetSettings().equipment.keepRareStyle then
				MyPrint(zo_strformat(DUSTMAN_NOTE_RARESTYLE, itemLink, GetItemStyleName(itemStyle)))
			end
			if isSet and Dustman.GetSettings().equipment.keepSetItems and not (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) then
				MyPrint(zo_strformat(DUSTMAN_NOTE_SETITEM, itemLink, setName))
			end
			if isSet and Dustman.GetSettings().equipment.keepJewelsSetItems and (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) then
				MyPrint(zo_strformat(DUSTMAN_NOTE_SETITEM, itemLink, setName))
			end
		end
        
        -- Maelstrom's and Master's Weapons
		if Dustman.GetSettings().equipment.keepMaelAndMast then
			if string.find(string.upper(GetItemLinkName(itemLink)), GetString(DUSTMAN_MASTER)) or string.find(string.upper(GetItemLinkName(itemLink)), GetString(DUSTMAN_MAELSTROM)) then
				return
			end
		end

        --exclude researchable armors & weapons
		if isResearchable and Dustman.GetSettings().equipment.keepResearchable and not (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) then return end
       
        --exclude researchable jewels
		if isResearchable and Dustman.GetSettings().equipment.keepResearchableJewels and (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) then return end
        
		--exclude rare style items
		if isRareStyle and Dustman.GetSettings().equipment.keepRareStyle then return end
		
		-- Exclude items with a specific trait
		if Dustman.GetSettings().equipment.enabled and quality <= Dustman.GetSettings().equipment.equipmentQuality and (not isSet or Dustman.GetSettings().junkTraitSets) then
			if not ((Dustman.GetSettings().equipment.keepLevel > 1 and requiredLevel >= Dustman.GetSettings().equipment.keepLevel) or (Dustman.GetSettings().equipment.keepLevel > 1 and requiredChampionPoints and requiredChampionPoints + 10000 >= Dustman.GetSettings().equipment.keepLevel)) then
				if Dustman.GetSettings().itemTraits[trait] then
					HandleJunk(bagId, slotId, itemLink, sellPrice, false, "ITEM-TRAIT")
					return
				end
			end
		end
		
		--exclude set armors & weapons
		if isSet and Dustman.GetSettings().equipment.keepSetItems and not (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) then return end
		
		--exclude set jewels
		if isSet and Dustman.GetSettings().equipment.keepJewelsSetItems and (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) and quality >= Dustman.GetSettings().equipment.jewelsSetQuality then return end
		
		--exclude items with Nirnhoned trait
		if isNirnhoned and Dustman.GetSettings().equipment.keepNirnhoned then return end
		
		--exclude intricate armors & weapons
		if trait == ITEM_TRAIT_TYPE_ARMOR_INTRICATE or trait == ITEM_TRAIT_TYPE_WEAPON_INTRICATE then
			if Dustman.GetSettings().equipment.keepIntricate then
				--only if crafting skill in not maxed
				if Dustman.GetSettings().equipment.keepIntricateIfNotMaxed then
					local _, rank = GetSkillLineInfo(GetCraftingSkillLineIndices(craftingType))
					if rank < 50 then return end
				else
					return
				end
			end
		end
        
        --exclude intricate jewelry items
		if trait == ITEM_TRAIT_TYPE_JEWELRY_INTRICATE then
			if Dustman.GetSettings().equipment.keepIntricateJewels then
				--only if crafting skill in not maxed
				if Dustman.GetSettings().equipment.keepIntricateJewelsIfNotMaxed then
					local _, rank = GetSkillLineInfo(GetCraftingSkillLineIndices(craftingType))
					if rank < 50 then return end
				else
					return
				end
			end
		end
		
		--zero value items
		if Dustman.GetSettings().equipment.whiteZeroValue and quality == ITEM_QUALITY_NORMAL and sellPrice == 0 then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "0 GOLD")
			return
		end
		
		if ( not (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) ) then
			--exclude items based on level/vetrank. 10000 is added to cprank
			if ((Dustman.GetSettings().equipment.keepLevel > 1 and requiredLevel >= Dustman.GetSettings().equipment.keepLevel)
			or (Dustman.GetSettings().equipment.keepLevel > 1 and requiredChampionPoints and requiredChampionPoints + 10000 >= Dustman.GetSettings().equipment.keepLevel))
			and (not Dustman.GetSettings().equipment.keepLevelOrnate or Dustman.GetSettings().equipment.keepLevelOrnate and (trait ~= ITEM_TRAIT_TYPE_ARMOR_ORNATE and trait ~= ITEM_TRAIT_TYPE_WEAPON_ORNATE)) then
				return
			end
		end
		
		-- notrait
		if Dustman.GetSettings().equipment.notrait and quality <= Dustman.GetSettings().equipment.notraitQuality then
			if trait == ITEM_TRAIT_TYPE_NONE and (GetItemLinkArmorType(itemLink) ~= ARMORTYPE_NONE or GetItemLinkWeaponType(itemLink) ~= WEAPONTYPE_NONE) then
				HandleJunk(bagId, slotId, itemLink, sellPrice, false, "TRAITLESS ITEM")
				return
			end
		end
		-- notrait jewels
		if Dustman.GetSettings().equipment.notraitJewels then
			if trait == ITEM_TRAIT_TYPE_NONE and GetItemLinkArmorType(itemLink) == ARMORTYPE_NONE and (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) then
				HandleJunk(bagId, slotId, itemLink, sellPrice, false, "TRAITLESS JEWEL")
				return
			end
		end
		--ornate weapons & armor
		if Dustman.GetSettings().equipment.ornate and quality <= Dustman.GetSettings().equipment.ornateQuality then
			if trait == ITEM_TRAIT_TYPE_ARMOR_ORNATE or trait == ITEM_TRAIT_TYPE_WEAPON_ORNATE then
				HandleJunk(bagId, slotId, itemLink, sellPrice, false, "ORNATE ITEM")
				return
			end
		end
		--ornate jewels
		if Dustman.GetSettings().equipment.jewelsOrnate and quality <= Dustman.GetSettings().equipment.jewelsOrnateQuality then
			if trait == ITEM_TRAIT_TYPE_JEWELRY_ORNATE then
				HandleJunk(bagId, slotId, itemLink, sellPrice, false, "ORNATE JEWEL")
				return
			end
		end
		--mark weapons & armor with the selected item quality
		if Dustman.GetSettings().equipment.enabled and quality <= Dustman.GetSettings().equipment.equipmentQuality and not (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "STD ITEM")
			return
		end		
		--mark jewels with the selected item quality
		if Dustman.GetSettings().equipment.jewelsEnabled and quality <= Dustman.GetSettings().equipment.jewelsQuality and (equipType == EQUIP_TYPE_NECK or equipType == EQUIP_TYPE_RING) then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "STD JEWEL")
			return
		end
	--fishing lure
	elseif itemType == ITEMTYPE_LURE then
		if itemId == "42878" then --always mark used bait
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "LURE-USED")
			return
		elseif Dustman.GetSettings().lure and ((not (Dustman.GetSettings().lureFullStack and (not IsFullStackInBag(slotId, BAG_BACKPACK, itemLink)))) and (not (Dustman.GetSettings().lureFullStackBank and (not IsFullStackInBag(slotId, BAG_BANK, itemLink))))) then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "LURE")
			return
		end
	--glyphs
	elseif (itemType == ITEMTYPE_GLYPH_ARMOR or itemType == ITEMTYPE_GLYPH_JEWELRY or itemType == ITEMTYPE_GLYPH_WEAPON) and IsItemLinkCrafted(itemLink) == false and Dustman.GetSettings().glyphs and quality <= Dustman.GetSettings().glyphsQuality then
		local minLevel, minChampionPoints = GetItemLinkGlyphMinLevels(itemLink)
		if Dustman.GetSettings().keepLevelGlyphs == 1 or (Dustman.GetSettings().keepLevelGlyphs > 1 and ((minLevel and minLevel < Dustman.GetSettings().keepLevelGlyphs) or (minChampionPoints and (minChampionPoints + 10000) < Dustman.GetSettings().keepLevelGlyphs))) then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "GLYPH")
			return
		end
	--provisioning recipes
	elseif itemType == ITEMTYPE_RECIPE and IsItemLinkRecipeKnown(itemLink) then
		if Dustman.GetSettings().provisioning.recipe and (specializedItemType == SPECIALIZED_ITEMTYPE_RECIPE_PROVISIONING_STANDARD_FOOD or specializedItemType == SPECIALIZED_ITEMTYPE_RECIPE_PROVISIONING_STANDARD_DRINK) and quality <= Dustman.GetSettings().provisioning.recipeQuality then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "RECIPE")
			return
		elseif Dustman.GetSettings().housingRecipes and (not (specializedItemType == SPECIALIZED_ITEMTYPE_RECIPE_PROVISIONING_STANDARD_FOOD or specializedItemType == SPECIALIZED_ITEMTYPE_RECIPE_PROVISIONING_STANDARD_DRINK)) and quality <= Dustman.GetSettings().housingRecipesQuality then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "HOUSING RECIPE")
			return
		end
	--collected fish & collected trophies
	elseif itemType == ITEMTYPE_COLLECTIBLE then
		
		if specializedItemType == SPECIALIZED_ITEMTYPE_COLLECTIBLE_MONSTER_TROPHY and Dustman.GetSettings().trophies then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "TROPHY")
			return
		 end
		 
		if specializedItemType == SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH and Dustman.GetSettings().trophy then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "FISH TROPHY")
			return
		 end
		 
	--provisioning ingredients
	elseif itemType == ITEMTYPE_INGREDIENT then
		local recipeType, ingredientType = Dustman.GetIngredientInfo(itemId)
		if Dustman.GetSettings().provisioning.all then
			if Dustman.GetSettings().provisioning.dish and recipeType == 1 then
				if not (ingredientType == 5 and Dustman.GetSettings().provisioning.excludeRareAdditives) and (not Dustman.GetSettings().provisioning.fullStack or (Dustman.GetSettings().provisioning.fullStack and IsFullStackInBag(slotId, BAG_BANK, itemLink))) then
					HandleJunk(bagId, slotId, itemLink, sellPrice, false, "FOOD INGR.")
					return
				end
			elseif Dustman.GetSettings().provisioning.drink and recipeType == 2 then
				if not (ingredientType == 5 and Dustman.GetSettings().provisioning.excludeRareAdditives) and (not Dustman.GetSettings().provisioning.fullStack or (Dustman.GetSettings().provisioning.fullStack and IsFullStackInBag(slotId, BAG_BANK, itemLink))) then
					HandleJunk(bagId, slotId, itemLink, sellPrice, false, "DRINK INGR.")
					return
				end
			end
		elseif Dustman.GetSettings().provisioning.unusable and (not usableIngredients[itemId]) then
			if Dustman.GetSettings().provisioning.dish and recipeType == 1 then
				if not (ingredientType == 5 and Dustman.GetSettings().provisioning.excludeRareAdditives) and (not Dustman.GetSettings().provisioning.fullStack or (Dustman.GetSettings().provisioning.fullStack and IsFullStackInBag(slotId, BAG_BANK, itemLink))) then
					HandleJunk(bagId, slotId, itemLink, sellPrice, false, "UN. FOOD INGR.")
					return
				end
			elseif Dustman.GetSettings().provisioning.drink and recipeType == 2 then
				if not (ingredientType == 5 and Dustman.GetSettings().provisioning.excludeRareAdditives) and (not Dustman.GetSettings().provisioning.fullStack or (Dustman.GetSettings().provisioning.fullStack and IsFullStackInBag(slotId, BAG_BANK, itemLink))) then
					HandleJunk(bagId, slotId, itemLink, sellPrice, false, "UN. DRINK INGR.")
					return
				end
			end
		end		
	--consumables
	elseif itemType == ITEMTYPE_FOOD and quality <= Dustman.GetSettings().foodQuality then
		if Dustman.GetSettings().foodAll then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "FOOD")
			return
        end
	elseif itemType == ITEMTYPE_DRINK and quality <= Dustman.GetSettings().foodQuality then
		if Dustman.GetSettings().foodAll then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "DRINK")
			return
        end
	elseif itemType == ITEMTYPE_ENCHANTING_RUNE_ASPECT and quality <= Dustman.GetSettings().enchanting.aspectQuality then 
		if Dustman.GetSettings().enchanting.enchantingAspect and (not Dustman.GetSettings().enchanting.aspectFullStack or (Dustman.GetSettings().enchanting.aspectFullStack and IsFullStackInBag(slotId, BAG_BANK, itemLink))) then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "ASPECT RUNE")
			return
		end
	elseif itemType == ITEMTYPE_SOUL_GEM and quality == ITEM_QUALITY_NORMAL and Dustman.GetSettings().emptyGems then 
		HandleJunk(bagId, slotId, itemLink, sellPrice, false, "SOULGEM")
		return
	end
	
	--items marked by user
	if Dustman.GetSettings().memory then
		local itemCode = zo_strjoin("_", itemId, quality, level)
		if junked[itemCode] ~= nil then
			HandleJunk(bagId, slotId, itemLink, sellPrice, false, "USER-AFTER", itemCode)
			return
		end
	end
	
	-- Stolen item to do not launder. If they need to be destroyed, the task is done at the beginning of the function. They can also be sold, done before aswell.
	if dontLaunder then
		return
	end
	
	-- item can be laundered
	return true
	
end

local function OnRecipeLearned(eventCode, recipeListIndex, recipeIndex)
	local numIngredients = select(3, GetRecipeInfo(recipeListIndex, recipeIndex))
	for ingredientIndex = 1, numIngredients do
		local link = GetRecipeIngredientItemLink(recipeListIndex, recipeIndex, ingredientIndex, LINK_STYLE_DEFAULT)
		local itemId = select(4, ZO_LinkHandler_ParseLink(link))
		usableIngredients[itemId] = true
	end
end

local function OnOpenStore()
	
	if Dustman.GetSettings().notifications.sell then
		if HasAnyJunk(BAG_BACKPACK, true) then
			if Dustman.GetSettings().notifications.sellDialog then
				ZO_Dialogs_ShowPlatformDialog("DUSTMAN_CONFIRM_SELL_JUNK")
			else
				SellJunkItems(false)
			end
		end
	end
end

local function InteractWithLaunder()

	local bagCache = SHARED_INVENTORY:GenerateFullSlotData(nil, BAG_BACKPACK)
	
	local hasAnyToLaunder = false
	for slotId, data in pairs(bagCache) do
		if data.stolen then
			local toLaunder = OnInventorySingleSlotUpdate(nil, BAG_BACKPACK, data.slotIndex, false)
			if toLaunder then
				hasAnyToLaunder = true
				data.toLaunder = true
			end
		end
	end

	if hasAnyToLaunder then
		LaunderingItem(bagCache)
	end

end

local function OnOpenFence()
	if AreAnyItemsStolen(BAG_BACKPACK) then
		
		if Dustman.GetSettings().notifications.sell then
			if HasAnyJunk(BAG_BACKPACK) then
				if Dustman.GetSettings().notifications.sellDialog then
					ZO_Dialogs_ShowPlatformDialog("DUSTMAN_CONFIRM_SELL_JUNK", {isFence = true})
				else
					SellJunkItems(true)
				end
			end
		end
		
		if Dustman.GetSettings().launder then
			InteractWithLaunder()
		end
		
	end
end

local function NameToID()
		
		local charName = GetUnitName("player")
		local data = Dustman_Junk_SavedVariables.Default[GetDisplayName()] 
		for entryIndex, entryData in pairs(data) do
			local name = entryData["$LastCharacterName"]
			if charName == name then
				return entryIndex
			end
		end
end

local function GetJunkSettings()
		if Dustman.savedVars.useGlobalSettings then
			return globalMarkedAsJunk
		else
			return markedAsJunk
		end
end

function Dustman.Sweep()
	local bagSize = GetBagSize(BAG_BACKPACK)
	for slotIndex = 0, bagSize - 1 do
		OnInventorySingleSlotUpdate(nil, BAG_BACKPACK, slotIndex, false)
	end
end

function Dustman.ClearMarkedAsJunk()
	if Dustman.savedVars.useGlobalSettings then
		Dustman_Junk_GlobalSavedVariables = {}
	else
		Dustman_Junk_SavedVariables.Default[GetDisplayName()][NameToID()] = {}
	end
end

local function RegisterInventorySingleSlotUpdate()
	EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, OnInventorySingleSlotUpdate)
	EVENT_MANAGER:AddFilterForEvent(ADDON_NAME, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_BACKPACK)
	EVENT_MANAGER:AddFilterForEvent(ADDON_NAME, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)
	inventorySingleSlotUpdate = true
end

local function UnregisterRegisterInventorySingleSlotUpdate()
	EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
	inventorySingleSlotUpdate = false
end

local function IsTutorialDone()
	local _, _, _, _, completed = GetAchievementInfo(TUTORIAL_ACHIEVEMENT)
	return completed
end

local function OnPlayerActivated()
	if inventorySingleSlotUpdate then
		if IsInTutorialZone() then
			UnregisterRegisterInventorySingleSlotUpdate()
		end
	else
		if IsTutorialDone() then
			RegisterInventorySingleSlotUpdate()
			EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, EVENT_PLAYER_ACTIVATED)
		elseif not IsInTutorialZone() then
			RegisterInventorySingleSlotUpdate()
		end
	end
end

local function OnSlotMouseEnter(inventorySlot)

	local junkableBags = {
		[BAG_BACKPACK] = true,
	}
	
	if inventorySlot and inventorySlot.dataEntry then
		hoveredBagId = inventorySlot.dataEntry.data.bagId
		hoveredSlotId = inventorySlot.dataEntry.data.slotIndex
		if hoveredBagId and hoveredSlotId and junkableBags[hoveredBagId] and not IsItemProtected(hoveredBagId, hoveredSlotId) then
			hoveredItemCanBeDestroyed = true
			if CanItemBeMarkedAsJunk(hoveredBagId, hoveredSlotId) then
				hoveredItemCanBeJunked = true
				isItemJunk = IsItemJunk(hoveredBagId, hoveredSlotId)
			end
			KEYBIND_STRIP:UpdateKeybindButtonGroup(dustmanKeybinds)
		end
	end

end

local function OnSlotMouseExit()
	
	hoveredBagId = nil
	hoveredSlotId = nil
	hoveredItemCanBeJunked = false
	hoveredItemCanBeDestroyed = false
	isItemJunk = false
	
	KEYBIND_STRIP:UpdateKeybindButtonGroup(dustmanKeybinds)
	
end

local function CanHoveredItemBeJunked()
	return Dustman.GetSettings().junkKeybind and hoveredItemCanBeJunked
end

local function CanHoveredItemBeDestroyed()
	return Dustman.GetSettings().destroyKeybind and hoveredItemCanBeDestroyed
end

local function JunkHoveredItem()
	if CanHoveredItemBeJunked() then
		SetItemIsJunk(hoveredBagId, hoveredSlotId, not isItemJunk)
	end
end

local function DestroyHoveredItem()
	if CanHoveredItemBeDestroyed() then
		DestroyItem(hoveredBagId, hoveredSlotId)
	end
end

local function UpdateAndDisplayJunkKeybind()
	
	if isItemJunk then
		descriptorName = GetString(SI_ITEM_ACTION_UNMARK_AS_JUNK)
	else
		descriptorName = GetString(SI_ITEM_ACTION_MARK_AS_JUNK)
	end
	
	return CanHoveredItemBeJunked()

end

local function UpdateAndDisplayDestroyKeybind()	
	return CanHoveredItemBeDestroyed()
end

local function InitializeInventoryKeybind()

	ZO_PreHook("ZO_InventorySlot_OnMouseEnter", OnSlotMouseEnter)
	ZO_PreHook("ZO_InventorySlot_OnMouseExit", OnSlotMouseExit)

	ZO_CreateStringId("SI_BINDING_NAME_DUSTMAN_JUNK", descriptorName)
	ZO_CreateStringId("SI_BINDING_NAME_DUSTMAN_DESTROY", GetString(SI_ITEM_ACTION_DESTROY))
	ZO_CreateStringId("SI_BINDING_NAME_DUSTMAN_SET", GetString(DUSTMAN_SET))
	ZO_CreateStringId("SI_BINDING_NAME_DUSTMAN_RESCAN", GetString(DUSTMAN_SWEEP))
	
	dustmanKeybinds =
	{
		alignment = KEYBIND_STRIP_ALIGN_CENTER,
		{
			name = GetString(SI_ITEM_ACTION_DESTROY),
			keybind = "DUSTMAN_DESTROY",
			callback = DestroyHoveredItem,
			visible = UpdateAndDisplayDestroyKeybind,
		},
		{
			name = function() return descriptorName end,
			keybind = "DUSTMAN_JUNK", -- UI_SHORTCUT_NEGATIVE cannot be used
			callback = JunkHoveredItem,
			visible = UpdateAndDisplayJunkKeybind,
		}
	}
	
	local function OnStateChanged(oldState, newState)
		if newState == SCENE_SHOWING then
			KEYBIND_STRIP:AddKeybindButtonGroup(dustmanKeybinds)
		elseif newState == SCENE_HIDDEN then
			KEYBIND_STRIP:RemoveKeybindButtonGroup(dustmanKeybinds)
		end
	end
	
	INVENTORY_FRAGMENT:RegisterCallback("StateChange", OnStateChanged)

end

function Dustman_JunkHoveredItem()
	JunkHoveredItem()
end

function Dustman_RescanInventory()	
	Dustman.Sweep()
	d(GetString(DUSTMAN_RESCAN_MSG))
end


function Dustman_DestroyHoveredItem()
	DestroyHoveredItem()
end

function Dustman_ExcludeSetItems()
	Dustman.GetSettings().equipment.keepSetItems = not Dustman.GetSettings().equipment.keepSetItems
	local to_show
	if Dustman.GetSettings().equipment.keepSetItems then
		d(GetString(DUSTMAN_SET_DISABLED))
	else
		d(GetString(DUSTMAN_SET_ENABLED))
	end
	Dustman.Sweep()
end

local function OnLoad(eventCode, name)

	if name == ADDON_NAME then
	
		--initialize saved variables
		Dustman.savedVars = 		ZO_SavedVars:NewCharacterIdSettings(	"Dustman_SavedVariables", 2, nil, defaults)
		Dustman.globalSavedVars  = 	ZO_SavedVars:NewAccountWide(			"Dustman_GlobalSavedVariables",  2, nil,  defaults)
		markedAsJunk = ZO_SavedVars:NewCharacterIdSettings(								"Dustman_Junk_SavedVariables", 2)
		globalMarkedAsJunk = ZO_SavedVars:NewAccountWide(										"Dustman_Junk_GlobalSavedVariables", 2)
		
		if not Dustman.savedVars.useGlobalSettings then
			local displayName = GetDisplayName()
			local id = NameToID()
			markedAsJunk = Dustman_Junk_SavedVariables.Default[displayName][id]
		end
		
		--hook SetItemIsJunk to watch item marked as junk
		local original_SetItemIsJunk = SetItemIsJunk
		SetItemIsJunk = function(bagId, slotId, junk, ...)
			if junk and IsItemProtected(bagId, slotId) then
				junk = false
			end
			if Dustman.GetSettings().memory then
				local itemLink = GetItemLink(bagId, slotId)
				local itemId = select(4, ZO_LinkHandler_ParseLink(itemLink))
				local quality = GetItemLinkQuality(itemLink)
				local level = GetItemLevel(bagId, slotId)
				GetJunkSettings()[zo_strjoin("_", itemId, quality, level)] = junk
			end
			original_SetItemIsJunk(bagId, slotId, junk, ...)
		end

		--add confirmation dialog
		local confirmSellDialog = {
			gamepadInfo = { dialogType = GAMEPAD_DIALOGS.BASIC, allowShowOnNextScene = true },
			title = { text = SI_PROMPT_TITLE_SELL_ITEMS },
			mainText = { text = SI_SELL_ALL_JUNK },
			buttons = {
				{
					text = SI_SELL_ALL_JUNK_CONFIRM,
					callback = function(dialog)
						local isFence = false
						if dialog.data then isFence = dialog.data.isFence end
						SellJunkItems(isFence)
					end
				},
				{ text = SI_DIALOG_CANCEL }
			}
		}
		
		
		-- Dustman handle sells when user disable auto sell and use Keybind to sell its items.
		-- Prehook is not enought because function is hardcoded in dialog, so we need to redo dialog after this action
		-- false must be sent in order to handle non stolen items, there is no SellJunkItems calls when at fence, only at "regular" merchant.
		ZO_PreHook("SellAllJunk", function() SellJunkItems(false) end)
		
		InitializeInventoryKeybind()
		
		ESO_Dialogs["SELL_ALL_JUNK"] =
		{
			title =
			{
				text = SI_PROMPT_TITLE_SELL_ITEMS,
			},
			mainText = 
			{
				text = SI_SELL_ALL_JUNK,
			},
			buttons =
			{
				[1] =
				{
					text = SI_SELL_ALL_JUNK_CONFIRM,
					callback = SellAllJunk,
				},
				[2] =
				{
					text = SI_DIALOG_DECLINE,
				},
			},
		}
		
		ZO_Dialogs_RegisterCustomDialog("DUSTMAN_CONFIRM_SELL_JUNK", confirmSellDialog)
		
		BuildUsableIngredientsList()
		Dustman.CreateSettingsMenu(defaults)
		
		EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_OPEN_STORE, OnOpenStore)
		EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_OPEN_FENCE, OnOpenFence)
		EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_RECIPE_LEARNED, OnRecipeLearned)
		
		EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_PLAYER_ACTIVATED, OnPlayerActivated)
		
		EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED)
				
	end
	
end

EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, OnLoad)