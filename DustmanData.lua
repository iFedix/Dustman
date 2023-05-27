--[[
-------------------------------------------------------------------------------
-- Dustman, by Ayantir & iFedix
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

local ignoreList = {
   ["33235"] = true, --Wabbajack
   ["29956"] = true, --Hunting Bow
   ["54982"] = true, --Sentinel's Lash
   ["54983"] = true, --Cadwell's Lost Robe
   ["54984"] = true, --Er-Jaseen's Worn Jack
   ["54985"] = true, --Unfinished Torment Cuirass
   ["43757"] = true, --Wet Gunny Sack
}

local ingredients = {
   --meat (health)
   ["28609"] = { 1, 1 }, --Game
   ["33752"] = { 1, 1 }, --Red Meat
   ["33753"] = { 1, 1 }, --Fish
   ["33754"] = { 1, 1 }, --White Meat
   ["33756"] = { 1, 1 }, --Small Game
   ["34321"] = { 1, 1 }, --Poultry
   --fruits (magicka)
   ["28603"] = { 1, 2 }, --Tomato
   ["28610"] = { 1, 2 }, --Jazbay Grapes
   ["33755"] = { 1, 2 }, --Bananas
   ["34308"] = { 1, 2 }, --Melon
   ["34311"] = { 1, 2 }, --Apples
   ["34305"] = { 1, 2 }, --Pumpkin
   --vegetables (stamina)
   ["28604"] = { 1, 3 }, --Greens
   ["33758"] = { 1, 3 }, --Potato
   ["34307"] = { 1, 3 }, --Radish
   ["34309"] = { 1, 3 }, --Beets
   ["34323"] = { 1, 3 }, --Corn
   ["34324"] = { 1, 3 }, --Carrots
   --dish additives
   ["26954"] = { 1, 4 }, --Garlic
   ["27057"] = { 1, 4 }, --Cheese
   ["27058"] = { 1, 4 }, --Seasoning
   ["27063"] = { 1, 4 }, --Saltrice
   ["27064"] = { 1, 4 }, --Millet
   ["27100"] = { 1, 4 }, --Flour
   --rare dish additive
   ["26802"] = { 1, 5 }, --Frost Mirriam
   --alcoholic (health)
   ["28639"] = { 2, 1 }, --Rye
   ["29030"] = { 2, 1 }, --Rice
   ["33774"] = { 2, 1 }, --Yeast
   ["34329"] = { 2, 1 }, --Barley
   ["34345"] = { 2, 1 }, --Surilie Grapes
   ["34348"] = { 2, 1 }, --Wheat
   --tea (magicka)
   ["28636"] = { 2, 2 }, --Rose
   ["33768"] = { 2, 2 }, --Comberry
   ["33771"] = { 2, 2 }, --Jasmine
   ["33773"] = { 2, 2 }, --Mint
   ["34330"] = { 2, 2 }, --Lotus
   ["34334"] = { 2, 2 }, --Bittergreen
   --tonic (stamina)
   ["33772"] = { 2, 3 }, --Coffee
   ["34333"] = { 2, 3 }, --Guarana
   ["34335"] = { 2, 3 }, --Yerba Mate
   ["34346"] = { 2, 3 }, --Gingko
   ["34347"] = { 2, 3 }, --Ginseng
   ["34349"] = { 2, 3 }, --Acai Berry
   --drink additives
   ["27035"] = { 2, 4 }, --Isinglass
   ["27043"] = { 2, 4 }, --Honey
   ["27048"] = { 2, 4 }, --Metheglin
   ["27049"] = { 2, 4 }, --Lemon
   ["27052"] = { 2, 4 }, --Ginger
   ["28666"] = { 2, 4 }, --Seaweed
   --rare drink additive
   ["27059"] = { 2, 5 }, --Bervez Juice
   --Caviar
   ["64222"] = { 3, 5 }, --Caviar
}

local itemStyles = {
	[ITEMSTYLE_RACIAL_BRETON] = true,
	[ITEMSTYLE_RACIAL_REDGUARD] = true,
	[ITEMSTYLE_RACIAL_ORC] = true,
	[ITEMSTYLE_RACIAL_DARK_ELF] = true,
	[ITEMSTYLE_RACIAL_NORD] = true,
	[ITEMSTYLE_RACIAL_ARGONIAN] = true,
	[ITEMSTYLE_RACIAL_HIGH_ELF] = true,
	[ITEMSTYLE_RACIAL_WOOD_ELF] = true,
	[ITEMSTYLE_RACIAL_KHAJIIT] = true,
	[ITEMSTYLE_AREA_ANCIENT_ELF] = true,
	[ITEMSTYLE_AREA_REACH] = true,
	[ITEMSTYLE_ENEMY_PRIMITIVE] = true,
	[ITEMSTYLE_ENEMY_DAEDRIC] = true,
	[ITEMSTYLE_RACIAL_IMPERIAL] = true,
}

local whitelistedPotion = {
    ["71073"] = true, -- AvA Stam
    ["71071"] = true, -- AvA Health
    ["71072"] = true, -- AvA Magicka
	["74728"] = true, -- TG Stam/Stealth
	["74728"] = true, -- TG Stam/Speed
}

local essenceRunes = {
	[1] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45839:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Dekeipa
	[2] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45833:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Deni
	[3] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45836:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Denima
	[4] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45842:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Deteri
	[5] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:68342:20:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Hakeijo
	[6] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45841:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Haoko
	[7] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:166045:20:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Indeko
	[8] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45849:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Kaderi
	[9] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45837:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Kuoko
	[10] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45848:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Makderi
	[11] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45832:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Makko
	[12] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45835:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Makkoma
	[13] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45840:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Meip
	[14] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45831:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Oko
	[15] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45834:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Okoma
	[16] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45843:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Okori
	[17] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45846:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Oru
	[18] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45838:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Rakeipa
	[19] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45847:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Taderi
}

local potencyRunes = {
	[1] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45812:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Denara
	[2] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45814:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Derado
	[3] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45822:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Edode
	[4] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45809:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Edora
	[5] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45825:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Hade
	[6] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45826:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Idode
	[7] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:68340:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Itade
	[8] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45810:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Jaera
	[9] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45821:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Jayde
	[10] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:64508:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Jehade
	[11] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45806:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Jejora
	[12] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45857:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Jera
	[13] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45855:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Jora
	[14] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45828:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Kedeko
	[15] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45830:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Kude
	[16] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45816:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Kura
	[17] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45818:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Notade
	[18] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45819:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Ode
	[19] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45807:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Odra
	[20] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45827:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Pode
	[21] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45823:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Pojode
	[22] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45808:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Pojora
	[23] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45811:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Pora
	[24] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45856:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Porade
	[25] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45829:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Rede
	[26] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:64509:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Rejera
	[27] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45824:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Rekude
	[28] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45815:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Rekura
	[29] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:68341:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Repora
	[30] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45813:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Rera
	[31] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName("|H0:item:45820:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")), --Tade
}

function Dustman.IsWhitelistedPotion(itemId)
   return whitelistedPotion[itemId] or false
end

function Dustman.IsOnIgnoreList(itemId)
   if type(itemId) == "number" then itemId = tostring(itemId) end
   return ignoreList[itemId] or false
end

function Dustman.GetEssenceRuneName(id)
	return essenceRunes[id]
end

function Dustman.GetPotencyRuneName(id)
	return potencyRunes[id]
end

function Dustman.IsCommonStyle(itemStyle)
	return itemStyles[itemStyle]
end

function Dustman.IsFish(itemId)
   if type(itemId) == "number" then itemId = tostring(itemId) end
   return isFish[itemId] or false
end

--Returns:
--recipeType, ingredientType 
-- recipeType:
--    1 = dish (stat increase)
--    2 = drink (stat regen)
-- ingredientType:
--    1 = health (meat / alcohol)
--    2 = magicka (fruit / tea)
--    3 = stamina (vegetable / tonic)
--    4 = additive
--    5 = rare additive
function Dustman.GetIngredientInfo(itemId)
   if type(itemId) == "number" then itemId = tostring(itemId) end

   local data = ingredients[itemId]
   if data then
      return unpack(data)
   end 
end
