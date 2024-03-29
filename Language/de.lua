----------------------------------------------------
-- German localization for Dustman, by Schleicher --
----------------------------------------------------

local strings = {
    --style materials submenu
    DUSTMAN_STYLE_MATERIALS = "Stil Materialien", 
    --item traits submenu
    DUSTMAN_ITEM_TRAITS = "Material für Gegenstandseigenschaften", 
    --weapons & armors & jewelry submenu
    DUSTMAN_WEAP_ARM_JEWL = "Waffen & Rüstung & Schmuck", 
    --weapons & armors submenu and jewelry submenu
    DUSTMAN_WEAP_ARM = "Waffen & Rüstung", 
    DUSTMAN_EQUIP_NOTRAIT = "Markiere Gegenstände ohne Eigenschaft", 
    DUSTMAN_EQUIP_NOTRAIT_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstung, welche keine Eigenschaft besitzen, als Trödel markiert.", 
    DUSTMAN_EQUIP_NOTRAIT_DESC_J = "Wenn aktiviert, Wird Schmuck, welcher keine Eigenschaft besitzt, als Trödel markiert.", 
    DUSTMAN_EQUIPMENT = "Markiere tragbare Gegenstände", 
    DUSTMAN_EQUIPMENT_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen als Trödel markiert.", 
    DUSTMAN_EQUIPMENT_DESC_J = "Wenn aktiviert, wird Schmuck als Trödel markiert.", 
    DUSTMAN_ORNATE = "Markiere verzierte Gegenstände", 
    DUSTMAN_ORNATE_DESC_WA = "Wenn aktiviert, werden verzierte Waffen und Rüstungen als Trödel markiert.", 
    DUSTMAN_ORNATE_DESC_J = "Wenn aktiviert, wird verzierter Schmuck als Trödel markiert.", 
    DUSTMAN_WHITE_ZERO = "Markiere wertlose Gegenstände", 
    DUSTMAN_WHITE_ZERO_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen von normaler Qualität und einem Wert von 0 als Trödel markiert.", 
    DUSTMAN_WHITE_ZERO_DESC_J = "Wenn aktiviert, wird Schmuck von normaler Qualität und einem Wert von 0 als Trödel markiert.", 
    DUSTMAN_INTRICATE = "Inspirierende Gegenstände ausschließen", 
    DUSTMAN_INTRICATE_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen die beim Verwerten Inspiration für Handwerksberufe gewähren, nie als Trödel markiert.", 
    DUSTMAN_INTRICATE_DESC_J = "Wenn aktiviert, wird Schmuck der beim Verwerten Inspiration für Handwerksberufe gewähren, nie als Trödel markiert.", 
    DUSTMAN_INTRIC_MAX = "Nur wenn für Handwerksberuf benötigt", 
    DUSTMAN_INTRIC_MAX_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen nur dann markiert, wenn diese nicht zum Leveln des Handwerksberuf benötigt werden.", 
    DUSTMAN_INTRIC_MAX_DESC_J = "Wenn aktiviert, wird Schmuck nur dann markiert, wenn diese nicht zum Leveln des Handwerksberuf benötigt werden.", 
    DUSTMAN_RESEARCH = "Analysierbare Gegenstände ausschließen", 
    DUSTMAN_RESEARCH_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen nur dann markiert, wenn diese nicht zur Analyse im Handwerksberuf benötigt werden.", 
    DUSTMAN_RESEARCH_DESC_J = "Wenn aktiviert, wird Schmuck nur dann markiert, wenn dieser nicht zur Analyse im Handwerksberuf benötigt werden.", 
    DUSTMAN_NIRNHONED = "Nirngeschliffene Gegenstände ausschließen", 
    DUSTMAN_NIRNHONED_DESC = "Wenn aktiviert, werden nirngeschliffene Gegenstände nie als Trödel markiert.", 
    DUSTMAN_SET = "Alle Sets ausschließen", 
    DUSTMAN_SET_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen mit Set Bonus nicht als Trödel markiert.", 
    DUSTMAN_SET_DESC_J = "Wenn aktiviert, wird Schmuck mit Set Bonus nicht als Trödel markiert", 
    DUSTMAN_LEVEL = "Gegenstände ausschließen mit Level >=", 
    DUSTMAN_LEVEL_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstung nicht als Trödel markiert, deren Wert größer 0 ist und deren Level (oder Veteranen Rang) höher oder gleich Ihrer Angabe ist.", 
    DUSTMAN_LEVEL_DESC_J = "Wenn aktiviert, wird Schmuck nicht als Trödel markiert, deren Wert größer 0 ist und deren Level (oder Veteranen Rang) höher oder gleich Ihrer Angabe ist.", 
    DUSTMAN_LEVEL_ORNATE = "Verzierte Gegenstände trotzdem markieren", 
    DUSTMAN_LEVEL_ORNATE_DESC_WA = "Wenn aktiviert, werden verzierte Waffen und Rüstungen trotzdem als Trödel markiert, deren Wert größer 0 ist und deren Level (oder Veteranen Rang) höher oder gleich Ihrer Angabe ist.", 
    DUSTMAN_LEVEL_ORNATE_DESC_J = "Wenn aktiviert, wird verzierter Schmuck trotzdem als Trödel markiert, deren Wert größer 0 ist und deren Level (oder Veteranen Rang) höher oder gleich Ihrer Angabe ist.", 
    DUSTMAN_TRAITSSETS = "Markiere trotzdem Sets mit folgenden Eigenschaften", 
    DUSTMAN_TRAITSSETS_DESC = "Wenn aktiviert, werden Set Gegenstände auch mit höherem Level und mit folgenden Eigenschaften als Trödel markiert.", 
    DUSTMAN_SET_ARENA = "Schliesse Arena Waffen aus", 
    DUSTMAN_SET_ARENA_DESC = "Wenn aktiviert, werden Arena Waffen (Drachenstern Arena, Mahlstrom Arena, Schwarzrosengefängniss) nicht als Trödel markiert.", 
    DUSTMAN_SET_BG = "Schliesse Sets aus Schlachtfeldern aus", 
    DUSTMAN_SET_BG_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen aus Schlachtfeldern nicht als Trödel markiert.", 
    DUSTMAN_SET_BG_DESC_J = "Wenn aktiviert, wird Schmuck aus Schlachtfeldern nicht als Trödel markiert.", 
    DUSTMAN_SET_CRAFTED = "Schliesse hergestellte Sets aus", 
    DUSTMAN_SET_CRAFTED_DESC_WA = "Wenn aktiviert, werden hergestellte Waffen und Rüstungen (e.g Magnus' Gabe, Aschengriff, etc..) nicht als Trödel markiert.", 
    DUSTMAN_SET_CRAFTED_DESC_J = "Wenn aktiviert, wird hergestellter Schmuck (e.g Magnus' Gabe, Aschengriff, etc..) nicht als Trödel markiert.", 
    DUSTMAN_SET_CYRO_A = "Exclude Cyrodiil armor sets",  --TO TRANSLATE
    DUSTMAN_SET_CYRO_W = "Exclude Cyrodiil weapon sets",  --TO TRANSLATE
    DUSTMAN_SET_CYRO_DESC_A = "If enabled, addon will never mark Cyrodill armors (e.g Deadly Strike, Warrior's Fury, etc..) as junk.",  --TO TRANSLATE
    DUSTMAN_SET_CYRO_DESC_W = "If enabled, addon will never mark Cyrodill weapons (e.g Deadly Strike, Warrior's Fury, etc..) as junk.",  --TO TRANSLATE
    DUSTMAN_SET_CYRO_J = "Exclude Cyrodiil sets",  --TO TRANSLATE
    DUSTMAN_SET_CYRO_DESC_J = "If enabled, addon will never mark Cyrodiil jewelry (e.g Deadly Strike, Warrior's Fury, etc..) as junk.",  --TO TRANSLATE
    DUSTMAN_SET_RANDIC = "Schliesse Sets aus Zufallsverliesen und Imperial City aus", 
    DUSTMAN_SET_RANDIC_DESC = "Wenn aktiviert, wird Schmuck aus täglichen Zufallsverliesen und Imperial City (Beständigkeit, Willenskraft, Agilität) nicht als Trödel markiert.", 
    DUSTMAN_SET_DUNG = "Schliesse Sets aus Zufallsverliesen aus", 
    DUSTMAN_SET_DUNG_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen aus täglichen Zufallsverliesen (e.g Jorvulds Führung, Blutmond, etc..) nicht als Trödel markiert.", 
    DUSTMAN_SET_DUNG_DESC_J = "Wenn aktiviert, wird Schmuck aus täglichen Zufallsverliesen (e.g Jorvulds Führung, Blutmond, etc..) nicht als Trödel markiert.", 
    DUSTMAN_SET_IC = "Schliesse Sets aus Imperial City aus", 
    DUSTMAN_SET_IC_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen aus Imperial City (e.g Phönix, Kaiserliche Physis, etc..) nicht als Trödel markiert.", 
    DUSTMAN_SET_IC_DESC_J = "Wenn aktiviert, wird Schmuck aus Imperial City (e.g Phönix, Kaiserliche Physis, etc..) nicht als Trödel markiert.", 
    DUSTMAN_SET_MS = "Schliesse Monster Sets aus", 
    DUSTMAN_SET_MS_DESC = "Wenn aktiviert, werden Monster Sets (e.g Ilambris, Eisherz, etc..) nicht als Trödel markiert.", 
    DUSTMAN_SET_OVERLAND = "Schliesse Gebietssets aus", 
    DUSTMAN_SET_OVERLAND_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen aus Gebietssets (e.g Nekropotenz, Dornenherz, etc..) nicht als Trödel markiert.", 
    DUSTMAN_SET_OVERLAND_DESC_J = "Wenn aktiviert, wird Schmuck aus Gebietssets (e.g Nekropotenz, Dornenherz, etc..) nicht als Trödel markiert.", 
    DUSTMAN_SET_SPEC = "Schliesse spezielle Sets aus", 
    DUSTMAN_SET_SPEC_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen aus Stufenaufstieg (Prophet, Zerbrochene Seele) nicht als Trödel markiert.", 
    DUSTMAN_SET_SPEC_DESC_J = "Wenn aktiviert, wird Schmuck aus Stufenaufstieg (Zerbrochene Seele) nicht als Trödel markiert.", 
    DUSTMAN_SET_TRIAL = "Schliesse Sets aus Prüfungen aus", 
    DUSTMAN_SET_TRIAL_DESC_WA = "Wenn aktiviert, werden Waffen und Rüstungen aus Prüfungen (e.g Mondtänzer, Tobender Krieger etc..) nicht als Trödel markiert.", 
    DUSTMAN_SET_TRIAL_DESC_J = "Wenn aktiviert, wird Schmuck aus Prüfungen (e.g Mondtänzer, Tobender Krieger, etc..) nicht als Trödel markiert.", 
    DUSTMAN_DISGUISES = "Markiere Verkleidungen", 
    DUSTMAN_DISGUISES_DESC = "Wenn aktiviert, werden Verkleidungen als Trödel markiert.", 
    DUSTMAN_DISGUISES_DESTROY = "...und zerstöre Sie!", 
    DUSTMAN_DISGUISES_DESTROY_DESC = "Zerstöre Verkleidungen automatisch.", 
     --provisioning submenu
    DUSTMAN_INGR_ALL = "Markiere alle Versorgerzutaten", 
    DUSTMAN_INGR_ALL_DESC = "Wenn aktiviert, werden Versorgerzutaten (Kochen / Brauen) als Trödel markiert.", 
    DUSTMAN_INGR_UNUS = "Markiere nicht nutzbare", 
    DUSTMAN_INGR_UNUS_DESC = "Wenn aktiviert, werden nicht nutzbare Versorgerzutaten (Kochen / Brauen) als Trödel markiert.", 
    DUSTMAN_INGR_DISH = "Aktiviert für Speise Zutaten", 
    DUSTMAN_INGR_DISH_DESC = "Wenn aktiviert, werden Zutaten mit Speisen mit Attributs Bonus als Trödel aktiviert.", 
    DUSTMAN_INGR_DRINK = "Aktiviert für Getränke Zutaten", 
    DUSTMAN_INGR_DRINK_DESC = "Wenn aktiviert, werden Zutaten mit Getränken mit Attributs Regeneration als Trödel aktiviert", 
    DUSTMAN_INGR_RARE = "Schließe seltene Zutaten aus", 
    DUSTMAN_INGR_RARE_DESC = "Schließt folgende Gegenstände aus |H1:item:26802:28:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h, |H1:item:27059:28:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h und |H1:item:64222:29:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h.", 
    DUSTMAN_RECIPE = "Markiere bekannte Rezepte", 
    DUSTMAN_RECIPE_DESC = "Wenn aktiviert, werden bekannte Rezepten als Trödel markiert.", 
    --crafting materials submenu
    DUSTMAN_CRAFTING_MATERIALS = "Herstellungsmaterialien", 
    DUSTMAN_CRAFTING_BLACKSMITHING_DESC = "Wenn aktiviert, werden niedrige Schmiedekunst Materialien als Trödel markiert. (Nur |H0:item:64489:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h wird nicht Markiert)",
    DUSTMAN_CRAFTING_RAW_BLACKSMITHING_DESC = "Wenn aktiviert, werden niedrige Schmiedekunst Rohmaterialien als Trödel markiert. (Nur |H0:item:71198:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h wird nicht Markiert)", 
    DUSTMAN_CRAFTING_CLOTHING_DESC = "Wenn aktiviert, werden niedrige Schneider Materialien als Trödel markiert. (Nur |H0:item:64504:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h und |H0:item:64506:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h werden nicht Markiert)", 
    DUSTMAN_CRAFTING_RAW_CLOTHING_DESC = "Wenn aktiviert, werden niedrige Schneider Rohmaterialien als Trödel markiert. (Nur |H0:item:71200:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h und |H0:item:71239:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h werden nicht Markiert)", 
    DUSTMAN_CRAFTING_WOODWORKING_DESC = "Wenn aktiviert, werden niedrige Schreiner Materialien als Trödel markiert. (Nur |H0:item:64502:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h wird nicht Markiert)", 
    DUSTMAN_CRAFTING_RAW_WOODWORKING_DESC = "Wenn aktiviert, werden niedrige Schreiner Rohmaterialien als Trödel markiert. (Nur |H0:item:71199:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h wird nicht Markiert)", 
    DUSTMAN_CRAFTING_JEWELRY_DESC = "Wenn aktiviert, werden niedrige Schmuckhandwerks Materialien als Trödel markiert. (Nur |H0:item:135146:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h wird nicht Markiert)", 
    DUSTMAN_CRAFTING_RAW_JEWELRY_DESC = "Wenn aktiviert, werden niedrige Schmuckhandwerks Rohmaterialien als Trödel markiert. (Nur |H0:item:135145:30:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h wird nicht Markiert)", 
    --furnishing submenu
    DUSTMAN_FURNISHING_MATERIALS = "Einrichtungsmaterialien", 
    DUSTMAN_ALCHRESIN = "Alchemistisches Harz", 
    DUSTMAN_BAST = "Bast", 
    DUSTMAN_CLEANPELT = "Sauberes Fell ", 
    DUSTMAN_DECWAX = "Dekorwachs", 
    DUSTMAN_HEARTWOOD = "Kernholz", 
    DUSTMAN_MUNDRUNE = "Weltliche Rune", 
    DUSTMAN_OCHRE = "Ocker", 
    DUSTMAN_REGULUS = "Regulus", 
    --enchanting submenu
    DUSTMAN_GLYPHS = "Markiere nicht hergestellte Glyphen", 
    DUSTMAN_GLYPHS_DESC = "Wenn aktiviert, werden nicht hergestellte Glyphen als Trödel markiert.", 
    DUSTMAN_LEVELGLYPH = "Glyphen ausschließen mit Level >=", 
    DUSTMAN_LEVELGLYPH_DESC = "Wenn aktiviert, werden Glyphen, deren Level (oder Veteranen Rang) höher oder gleich Ihrer Angabe ist, nicht Markiert.", 
    DUSTMAN_ASPECT_RUNES = "Markiere Aspektrunen", 
    DUSTMAN_ASPECT_RUNES_DESC = "Wenn aktiviert, werden Aspektrunen als Trödel markiert.", 
    DUSTMAN_ESSENCE_RUNES = "Mark essence runes", 
    DUSTMAN_ESSENCE_RUNES_DESC = "Enable/disable marking of essence runes as junk.", 
    DUSTMAN_POTENCY_RUNES = "Mark potency runes", 
    DUSTMAN_POTENCY_RUNES_DESC = "Enable/disable marking of potency runes as junk.", 
     --consumables submenu
    DUSTMAN_FOOD_ALL = "Markiere Speisen und Getränke", 
    DUSTMAN_FOOD_ALL_DESC = "Wenn aktiviert, werden Speisen und Getränken als Trödel markiert.", 
    DUSTMAN_POTIONS = "Markiere nicht-hergestellte Tränke", 
    DUSTMAN_POTIONS_DESC = "Wenn aktiviert, werden nicht hergestellten Tränken als Trödel.", 
    DUSTMAN_LEVELPOTIONS = "Tränke ausschließen mit Level >=", 
    DUSTMAN_LEVELPOTIONS_DESC = "Wenn aktiviert, werden Tränke, deren Level (oder Veteranen Rang) höher oder gleich Ihrer Angabe ist, nicht Markiert.", 
    DUSTMAN_POISONS = "Markiere nicht hergestellte Gifte", 
    DUSTMAN_POISONS_DESC = "Wenn aktiviert, werden nicht hergestellte Giften als Trödel markiert.", 
    DUSTMAN_POISONS_SOLVANTS = "Markiere Giftlösungsmittel", 
    DUSTMAN_POISONS_SOLVANTS_DESC = "Wenn aktiviert, werden Giftlösungsmitteln als Trödel markiert.", 
    DUSTMAN_LEVELPOISONS = "Gifte ausschließen mit Level >=", 
    DUSTMAN_LEVELPOISONS_DESC = "Wenn aktiviert, werden Gifte, deren Level (oder Veteranen Rang) höher oder gleich Ihrer Angabe ist, nicht Markiert.", 
    DUSTMAN_EMPTYGEMS = "Markiere leere Seelensteine", 
    DUSTMAN_EMPTYGEMS_DESC = "Wenn aktiviert, werden leeren Seelensteinen als Trödel markiert.", 
    DUSTMAN_TREASURE_MAPS = "Markiere Schatzkarten",
    DUSTMAN_TREASURE_MAPS_DESC = "Wenn aktiviert, werden Schatzkarten als Trödel markiert.", 
    DUSTMAN_TREASURE_MAPS_DESTROY = "...und zerstöre Sie!", 
    DUSTMAN_TREASURE_MAPS_DESTROY_DESC = "Zerstöre automatisch alle Schatzkarten.", 
    DUSTMAN_JEWELRY_MASTER_WRITS = "Destroy Jewelry Master Writs", --TO TRANSLATE
    DUSTMAN_JEWELRY_MASTER_WRITS_DESC = "Automatically destroy Jewelry Master Writs", --TO TRANSLATE
    --treasures and trophies submenu
    DUSTMAN_TREASURES = "Schätze und Trophäen", 
    DUSTMAN_TREASURE = "Markiere Schätze", 
    DUSTMAN_TREASURE_DESC = "Wenn aktiviert, werden Schätze als Trödel markiert.", 
    DUSTMAN_TROPHIES = "Markiere bekannte Trophäen", 
    DUSTMAN_TROPHIES_DESC = "Wenn aktiviert, werden bereits bekannte Trophäen als Trödel markiert.", 
    DUSTMAN_MUSEUM_PIECES = "Markiere Museumsstücke", 
    DUSTMAN_MUSEUM_PIECES_DESC = "Wenn aktiviert, werden Museumsstücke als Trödel markiert.", 
    DUSTMAN_MUSEUM_PIECES_DESTROY = "...uns zerstöre Sie!", 
    DUSTMAN_MUSEUM_PIECES_DESTROY_DESC = "Zerstöre automatisch alle Museumsstücke", 
    --daily logins stuff
    DUSTMAN_CROWN = "KRONEN", 
    DUSTMAN_DAILY_LOGINS = "Gegenstände vom täglichen Anmelden", 
    DUSTMAN_DL_FOOD = "Nahrung", 
    DUSTMAN_DL_FOOD_DESC = "Zerstöre Nahrung erhalten durch das tägliche Anmelden.", 
    DUSTMAN_DL_DRINKS = "Getränke", 
    DUSTMAN_DL_DRINKS_DESC = "Zerstöre Getränke erhalten durch das tägliche Anmelden.", 
    DUSTMAN_DL_POTIONS = "Tränke", 
    DUSTMAN_DL_POTIONS_DESC = "Zerstöre Tränke erhalten durch das tägliche Anmelden.", 
    DUSTMAN_DL_POISONS = "Gifte", 
    DUSTMAN_DL_POISONS_DESC = "Zerstöre Gifte erhalten durch das tägliche Anmelden.", 
    DUSTMAN_DL_REP_KITS = "Reparaturkisten", 
    DUSTMAN_DL_REP_KITS_DESC = "Zerstöre Reparaturkisten erhalten durch das tägliche Anmelden.", 
    DUSTMAN_DL_SOUL_GEMS = "Seelensteine", 
    DUSTMAN_DL_SOUL_GEMS_DESC = "Zerstöre Seelensteine erhalten durch das tägliche Anmelden.", 
     --shared
    DUSTMAN_QUALITY = "Nur bei Qualitätsstufe kleiner gleich:", 
    DUSTMAN_QUALITY_DESC = "Wendet die vorherigen Einstellungen nur bei Gegenständen kleiner oder gleich der gewählten Qualitätsstufe an.", 
    DUSTMAN_QUALITY_SUPP = "Nur bei Qualitätsstufe grösser gleich:", 
    DUSTMAN_QUALITY_SUPP_DESC = "Wendet die vorherigen Einstellungen nur bei Gegenständen grösser oder gleich der gewählten Qualitätsstufe an.", 
    DUSTMAN_FULLSTACK = "Nur mit vollem Stapel in der Bank", 
    DUSTMAN_FULLSTACK_DESC = "Wendet die Auswahl nur an, wenn sich bereits ein voller Stapel der Gegenstände in der Bank befindet.", 
    DUSTMAN_FULLSTACK_BAG = "Nur mit vollen Stapel im Rucksack", 
    DUSTMAN_FULLSTACK_BAG_DESC = "Wendet die Auswahl nur an, wenn sich bereits ein voller Stapel der Gegenstände im Rucksack befindet.", 
     --fishing
    DUSTMAN_FISHES = "Fischen", 
    DUSTMAN_LURE = "Markiere Köder", 
    DUSTMAN_LURE_DESC = "Wenn aktiviert, werden Köder als Trödel markiert.", 
    DUSTMAN_TROPHY = "Markiere Angeltrophäen", 
    DUSTMAN_TROPHY_DESC = "Wenn aktiviert, werden Angeltrophäen als Trödel markiert. Fische als Einrichtungsgegenstände werden nicht als Trödel markiert. Geangelte Zutaten werden anhand der Einstellungen für Versorgerzutaten markiert.", 
    -- housing
    DUSTMAN_HOUSING_RECIPES = "Markiere bekannte Einrichtungsblaupausen", 
    DUSTMAN_HOUSING_RECIPES_DESC = "Wenn aktiviert, werden bereits bekannte Einrichtungsblaupausen als Trödel markiert.", 
     --remember junk
    DUSTMAN_REMEMBER = "Speichere Trödelmarkierungen", 
    DUSTMAN_REMEMBER_DESC = "Wenn aktiviert, werden manuell als Trödel markierter Gegenstände gespeichert. Dustman wird dann diese Gegenstände solange erneut als Trödel markieren bis diese Markierung im Inventar aufgehoben, oder die Option deaktiviert wird.", 
    DUSTMAN_MEMORYFIRST = "Benutze gemerkte Gegenstände zuerst", 
    DUSTMAN_MEMORYFIRST_DESC = "Wenn aktiviert, werden immer zuerst die bereits gemerkten Gegenstände als Trödel markiert. Dies bedeutet, dass diese Einstellung andere Trödel Filter überschreiben kann!", 
     --destroy junk submenu
    DUSTMAN_DESTROY = "Zerstöre Müll", 
    DUSTMAN_DESTROY_DESC = "Aktiviert / Deaktivert die automatische Zerstörung von ungewollten Gegenständen ohne/mit geringem Wert.", 
    DUSTMAN_DESTROY_VAL = "Verkaufspreis Schwellenwert", 
    DUSTMAN_DESTROY_VAL_DESC = "Alle ungewollten Gegenstände mit einem geringerem Wert, als hier eingestellt wird, werden zerstört.", 
    DUSTMAN_DESTROY_STOLEN = "Gestohlene Gegenstände Schwellenwert", 
    DUSTMAN_DESTROY_STOLEN_DESC = "Alle gestohlenen Gegenstände, die als Trödel markiert wurden und einen geringeren Wert, als hier eingestellt wird, besitzen, werden zerstört.", 
    DUSTMAN_DESTROY_STACK = "Stapelbare Gegenstände ausschließen", 
    DUSTMAN_DESTROY_STACK_DESC = "Stapelbare Gegenstände mit einem Verkaufswert größer als 0, und geringer als der eingestellte Schwellenwert, werden nicht zerstört.", 
     --notifications submenu
    DUSTMAN_VERBOSE = "Meldungen für Trödel", 
    DUSTMAN_VERBOSE_DESC = "Wenn aktiviert, wird gemeldet, dass ein Gegenstand als Trödel markiert, oder zerstört wurde.", 
    DUSTMAN_FOUND = "Melde interessante Gegenstände", 
    DUSTMAN_FOUND_DESC = "Wenn aktiviert, wird gemeldet, dass ein verwertbarer Gegenstand mit analysierbarer Eigenschaft, seltenem Handwerksstil oder Set Bonus gefunden wurde.", 
    DUSTMAN_ALLITEMS = "Melde verkaufte Gegenstände", 
    DUSTMAN_ALLITEMS_DESC = "Wenn aktiviert, wird gemeldet welche Gegenstände verkauft wurden.", 
    DUSTMAN_TOTAL = "Zusammenfassung für Verkäufe", 
    DUSTMAN_TOTAL_DESC = "Wenn aktiviert, werden aufsummierten Erlöse durch Gegenstandsverkäufe gemeldet.", 
    DUSTMAN_CONFIRM = "Zeige Bestätigungsdialog", 
    DUSTMAN_CONFIRM_DESC = "Wenn aktiviert, wird ein Bestätigungsdialog für den Verkauf von Trödel gezeigt.", 
    DUSTMAN_DONTSELL = "Automatischer Verkauf", 
    DUSTMAN_DONTSELL_DESC = "Wenn aktiviert, werden automatisch die Trödel Gegenstände verkauft, wenn du mit einem Händler sprichst. Ist die Einstellung deaktiviert, musst du die Gegenstände mit dem \"Verkaufe allen Trödel\" Knopf manuell verkaufen", 
    DUSTMAN_AUTOMATIC_SCAN = "Automatically scan inventory",  --TO TRANSLATE
    DUSTMAN_AUTOMATIC_SCAN_DESC = "If this option is enabled your Dustman rules will be automatically applied when a new item is found in your inventory. Note that if you disable this option you will need to manually force an inventory scan using the option below or the rescan keybind",  --TO TRANSLATE
     --stolen items
    DUSTMAN_STOLEN = "Markiere gestohlene Wertsachen", 
    DUSTMAN_STOLEN_DESC = "Markiert gestohlene Wertsachen (Gegenstände, die keine Verwendung haben) als Trödel.", 
    DUSTMAN_STOLEN_LAUNDER = "Gestohlene Gegenstände zur Geldwäsche bringen", 
    DUSTMAN_STOLEN_LAUNDER_DESC = "Gestohlene Gegenstände, die keinem Trödel Filter entsprechen, zur Geldwäsche bringen.", 
    DUSTMAN_STOLEN_CLOTHES = "Gestohlene Kleidung ausschließen", 
    DUSTMAN_STOLEN_CLOTHES_DESC = "Gestohlene Kleidung nicht zur Geldwäsche bringen oder als Trödel markieren.", 
    DUSTMAN_NOLAUNDER = "<<1>> nicht schieben", 
    DUSTMAN_NOLAUNDER_DESC = "<<1>> wird nicht geschoben (gereinigt)", 
    DUSTMAN_NON_LAUNDERED = "Zerstöre oberhalb markierte Gegenstände", 
    DUSTMAN_NON_LAUNDERED_DESC = "Zerstöre die oberhalb markierten Gegenstände. Wenn keine Gegenstände ausgewählt sind, bleiben sie in deinem Inventar.", 
    DUSTMAN_ACT_LOWTREASURES = "Schätze geringer Qualität", 
    DUSTMAN_ACT_LOWTREASURES_DESC = "Wähle die Aktion für Schätze geringer Qualität", 
    DUSTMAN_ACT_LOWTREASURE1 = "keine Aktion", 
    DUSTMAN_ACT_LOWTREASURE2 = "zerstöre Gegenstand", 
    DUSTMAN_ACT_LOWTREASURE3 = "schiebe Gegenstand (reinigen)", 
    --Keybinds
    DUSTMAN_JUNKKEYBIND = "Aktiviere \"Als Trödel (de-) markieren\" Tastenbindung", 
    DUSTMAN_JUNKKEYBIND_DESC = "Aktiviert Hotkey, um Gegenstände im Inventar schnell als Junk zu markieren oder zu demarkieren", 
    DUSTMAN_DESTROYKEYBIND = "Aktiviere \"Zerstören\" Tastenbindung", 
    DUSTMAN_DESTROYKEYBIND_DESC = "Aktiviert Hotkey, um Gegenstände im Inventar zu zerstören", 
    --rescan button
    DUSTMAN_SWEEP = "Erneut scannen", 
    DUSTMAN_SWEEP_DESC = "Erneut alle Gegenstände im Inventar mit den eingestellten Filtern überprüfen.", 
    --clear Marked as Junk
    DUSTMAN_CLEAR_MARKED = "Lösche manuelle Einträge", 
    DUSTMAN_CLEAR_MARKED_DESC = "Lösche alle Einträge welche manuell als Trödel definiert wurden.", 
    --global settings
    DUSTMAN_GLOBAL = "Benutze globale Konfiguration", 
    DUSTMAN_GLOBAL_DESC = "Benutze die gleiche Konfiguration für alle Charakter.", 
    --import
    DUSTMAN_IMPORT = "Importiere Dustman Konfiguration von", 
    DUSTMAN_IMPORT_DESC = "Wähle aus, von welchem deiner Charaktere die Dustman Einstellungen übernommen werden sollen.", 
    DUSTMAN_IMPORTED = "Dustman Einstellungen wurden von Charakter <<1>> importiert!", 
    --chat notification
    DUSTMAN_SET_ENABLED = "Dustman wird jetzt Set Gegenstände als Trödel markieren",
    DUSTMAN_SET_DISABLED = "Dustman wird jetzt nicht mehr Set Gegenstände als Trödel markieren", 
    DUSTMAN_RESCAN_MSG = "Dustman hat erfolgreich dein Inventar geprüft!", 
    DUSTMAN_NOTE_JUNK = "Dustman hat <<t:1>> als Trödel markiert (<<2>>).", 
    DUSTMAN_NOTE_DESTROY = "Dustman hat <<t:1>> zerstört (<<2>>).", 
    DUSTMAN_NOTE_RESEARCH = "Gegenstand mit analysierbarer Eigenschaft: <<t:1>> (<<2>>).", 
    DUSTMAN_NOTE_NIRNHONED = "Gegenstand mit |cFFFFFF<<1>>|r Eigenschaft: <<t:2>>.", 
    DUSTMAN_NOTE_SETITEM = "Gegenstand mit Set Bonus: <<t:1>> (<<2>>).", 
    DUSTMAN_NOTE_INTERSTING = "Interessanter Gegenstand: <<t:1>>.", 
    --report formats
    DUSTMAN_FORMAT_ZERO = "Dustman verkaufte <<2>>x <<t:1>>.", 
    DUSTMAN_FORMAT_GOLD = "Dustman verkaufte <<2>>x <<t:1>> im Wert von <<3>>|t16:16:EsoUI/Art/currency/currency_gold.dds|t.", 
    DUSTMAN_FORMAT_NOTSOLD = "Dustman konnte <<t:1>> nicht verkaufen.", 
    DUSTMAN_FORMAT_TOTAL = "Dustman verkaufte <<1>> <<1[item/items]>> (<<3>> <<3[stack/stacks]>>) im Wert von <<2>>|t16:16:EsoUI/Art/currency/currency_gold.dds|t.", 
    DUSTMAN_FORMATL_ZERO = "Dustman wusch Geld für <<2>>x <<t:1>>.", 
    DUSTMAN_FORMATL_GOLD = "Dustman wusch Geld für <<2>>x <<t:1>> im Wert von <<3>>|t16:16:EsoUI/Art/currency/currency_gold.dds|t.", 
    DUSTMAN_FORMATL_NOTSOLD = "Dustman konnte für <<t:1>> nicht Geld waschen.", 
    DUSTMAN_FORMATL_TOTAL = "Dustman wusch Geld für <<1>> <<1[item/items]>> im Wert von <<2>>|t16:16:EsoUI/Art/currency/currency_gold.dds|t.", 
    DUSTMAN_ZOS_RESTRICTIONS = "Aufgrund Einschränkungen von ZOS kann Dustman nur 50 Aktionen durchführen. Bitte warte 10 Sekunden und probiere es erneut.", 
    --bursar of tributes
    DUSTMAN_BOT_QUEST_NAME_1 = "Eine Frage des Tributs", 
    DUSTMAN_BOT_QUEST_NAME_2 = "Eine Frage des Respekts", 
    DUSTMAN_BOT_QUEST_NAME_3 = "Eine Frage der Muße", 
    DUSTMAN_BOT_QUEST_NAME_4 = "Glitzern und Funkeln", 
    DUSTMAN_BOT_QUEST_NAME_5 = "Bröckchen und Bisschen", 
    DUSTMAN_BOT_QUEST_NAME_6 = "Stückchen und Häppchen", 
    DUSTMAN_BOT_COSMETIC = "Kosmetika", 
    DUSTMAN_BOT_GROOMING_ITEMS = "Körperpflegegegenständ", 
    DUSTMAN_BOT_UTENSILS = "Utensilien", 
    DUSTMAN_BOT_DAC = "Teller und Kochgeschirr", 
    DUSTMAN_BOT_DRINKWARE = "Trinkgefäße", 
    DUSTMAN_BOT_CT = "Kinderspielzeug", 
    DUSTMAN_BOT_DOLLS = "Puppen", 
    DUSTMAN_BOT_GAMES = "Spiele", 
    DUSTMAN_BOT = "Save Bursar of Tributes quest items", --TO TRANSLATE
    DUSTMAN_BOT_DESC = "Save items for Bursar of Tributes quests. Since there are six possible quests given by the raven npc, you can choose to save all items required for all the possible quests or to save only the items required for the active quest.", --TO TRANSLATE
    DUSTMAN_BOT_DD_ALL = "All items required for all the quests", --TO TRANSLATE
    DUSTMAN_BOT_DD_ACTIVE = "Items required for active quest only" --TO TRANSLATE
}

for stringId, stringValue in pairs(strings) do
    ZO_CreateStringId(stringId, stringValue)
    SafeAddVersion(stringId, 1)
end