
//////////////////////////Poison stuff (Toxins & Acids)///////////////////////

/datum/reagent/toxin
	name = "Toxin"
	description = "A toxic chemical."
	color = "#CF3600" // rgb: 207, 54, 0
	taste_description = "bitterness"
	taste_mult = 1.2
	value = REAGENT_VALUE_COMMON //Encouraging people to mix toxins for reasons beyond harming each other or mixing reagents such as pen acid.
	var/toxpwr = 1.5

// Are you a bad enough dude to poison your own plants?
/datum/reagent/toxin/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustToxic(round(chems.get_reagent_amount(type) * 2))

/datum/reagent/toxin/amatoxin
	name = "Amatoxin"
	description = "A powerful poison derived from certain species of mushroom."
	color = "#792300" // rgb: 121, 35, 0
	toxpwr = 2.5
	taste_description = "mushroom"
	value = REAGENT_VALUE_UNCOMMON
	pH = 13

/datum/reagent/toxin/mutagen
	name = "Unstable mutagen"
	description = "Might cause unpredictable mutations. Keep away from children."
	color = "#00FF00"
	chemical_flags = REAGENT_ALL_PROCESS
	toxpwr = 0
	taste_description = "slime"
	taste_mult = 0.9
	value = REAGENT_VALUE_VERY_COMMON
	pH = 2.3

/datum/reagent/toxin/mutagen/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	mytray.mutation_roll(user)
	if(chems.has_reagent(type, 1))
		mytray.adjustToxic(1.5) //It is still toxic, mind you, but not to the same degree.

/datum/reagent/toxin/plasma
	name = "Plasma"
	description = "Plasma in its liquid form."
	taste_description = "bitterness"
	specific_heat = SPECIFIC_HEAT_PLASMA
	taste_mult = 1.5
	color = "#8228A0"
	toxpwr = 3
	pH = 4
	value = REAGENT_VALUE_RARE //sheets are worth more
	material = /datum/material/plasma

/datum/reagent/toxin/lexorin
	name = "Lexorin"
	description = "A powerful poison used to stop respiration."
	color = "#7DC3A0"
	toxpwr = 0
	taste_description = "acid"
	pH = 1.2
	value = REAGENT_VALUE_RARE

/datum/reagent/toxin/slimejelly
	name = "Slime Jelly"
	description = "A gooey semi-liquid produced from one of the deadliest lifeforms in existence. SO REAL."
	color = "#801E28" // rgb: 128, 30, 40
	toxpwr = 0
	taste_description = "slime"
	taste_mult = 1.3
	pH = 10
	value = REAGENT_VALUE_UNCOMMON

/datum/reagent/toxin/minttoxin
	name = "Mint Toxin"
	description = "Useful for dealing with undesirable customers."
	color = "#CF3600" // rgb: 207, 54, 0
	toxpwr = 0
	taste_description = "mint"
	pH = 8
	value = REAGENT_VALUE_UNCOMMON

/datum/reagent/toxin/carpotoxin
	name = "Carpotoxin"
	description = "A deadly neurotoxin produced by the dreaded spess carp."
	color = "#003333" // rgb: 0, 51, 51
	toxpwr = 2
	taste_description = "fish"
	pH = 12
	value = REAGENT_VALUE_RARE

/datum/reagent/toxin/carpotoxin/on_mob_life(mob/living/carbon/M)
	. = ..()
	for(var/i in M.all_scars)
		qdel(i)

/datum/reagent/toxin/zombiepowder
	name = "Zombie Powder"
	description = "A strong neurotoxin that puts the subject into a death-like state."
	reagent_state = SOLID
	color = "#669900" // rgb: 102, 153, 0
	toxpwr = 0.5
	taste_description = "death"
	var/fakedeath_active = FALSE
	pH = 13
	value = REAGENT_VALUE_EXCEPTIONAL

/datum/reagent/toxin/ghoulpowder
	name = "Ghoul Powder"
	description = "A strong neurotoxin that slows metabolism to a death-like state, while keeping the patient fully active. Causes toxin buildup if used too long."
	reagent_state = SOLID
	color = "#664700" // rgb: 102, 71, 0
	toxpwr = 0.8
	taste_description = "death"
	pH = 14.5
	value = REAGENT_VALUE_EXCEPTIONAL

/datum/reagent/toxin/mindbreaker
	name = "Mindbreaker Toxin"
	description = "A powerful hallucinogen. Not a thing to be messed with. For some mental patients. it counteracts their symptoms and anchors them to reality."
	color = "#B31008" // rgb: 139, 166, 233
	toxpwr = 0
	taste_description = "sourness"
	pH = 11
	value = REAGENT_VALUE_UNCOMMON

/datum/reagent/toxin/mindbreaker/on_mob_life(mob/living/carbon/M)
	M.hallucination += 5
	return ..()

/datum/reagent/toxin/plantbgone
	name = "Plant-B-Gone"
	description = "A harmful toxic mixture to kill plantlife. Do not ingest!"
	color = "#49002E" // rgb: 73, 0, 46
	toxpwr = 1
	taste_mult = 1
	pH = 2.7
	value = REAGENT_VALUE_NONE

/datum/reagent/toxin/plantbgone/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(-round(chems.get_reagent_amount(type) * 10))
		mytray.adjustToxic(round(chems.get_reagent_amount(type) * 6))
		mytray.adjustWeeds(-rand(4,8))

/datum/reagent/toxin/plantbgone/reaction_obj(obj/O, reac_volume)
	if(istype(O, /obj/structure/alien/weeds))
		var/obj/structure/alien/weeds/alien_weeds = O
		alien_weeds.take_damage(rand(15,35), BRUTE, 0) // Kills alien weeds pretty fast
	else if(istype(O, /obj/structure/glowshroom)) //even a small amount is enough to kill it
		qdel(O)
	else if(istype(O, /obj/structure/spacevine))
		var/obj/structure/spacevine/SV = O
		SV.on_chem_effect(src)

/datum/reagent/toxin/plantbgone/weedkiller
	name = "Weed Killer"
	description = "A harmful toxic mixture to kill weeds. Do not ingest!"
	color = "#4B004B" // rgb: 75, 0, 75
	pH = 3
	value = REAGENT_VALUE_NONE

//Weed Spray
/datum/reagent/toxin/plantbgone/weedkiller/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	if(!mytray)
		return
	if(chems.has_reagent(type, 1))
		mytray.adjustToxic(round(chems.get_reagent_amount(type) * 0.5))
		mytray.adjustWeeds(-rand(1,2))

/datum/reagent/toxin/pestkiller
	name = "Pest Killer"
	description = "A harmful toxic mixture to kill pests. Do not ingest!"
	color = "#4B004B" // rgb: 75, 0, 75
	toxpwr = 1
	pH = 3.2
	value = REAGENT_VALUE_NONE

//Pest Spray
/datum/reagent/toxin/pestkiller/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	if(!mytray)
		return
	if(chems.has_reagent(type, 1))
		mytray.adjustToxic(round(chems.get_reagent_amount(type) * 1))
		mytray.adjustPests(-rand(1,2))

/datum/reagent/toxin/spore
	name = "Spore Toxin"
	description = "A natural toxin produced by blob spores that inhibits vision when ingested."
	color = "#9ACD32"
	toxpwr = 1
	pH = 11
	value = REAGENT_VALUE_RARE

/datum/reagent/toxin/spore_burning
	name = "Burning Spore Toxin"
	description = "A natural toxin produced by blob spores that induces combustion in its victim."
	color = "#9ACD32"
	toxpwr = 0.5
	taste_description = "burning"
	pH = 13
	value = REAGENT_VALUE_VERY_RARE

/datum/reagent/toxin/spore_burning/on_mob_life(mob/living/carbon/M)
	M.adjust_fire_stacks(2)
	M.IgniteMob()
	return ..()

/datum/reagent/toxin/chloralhydrate
	name = "Chloral Hydrate"
	description = "A powerful sedative that induces confusion and drowsiness before putting its target to sleep."
	reagent_state = SOLID
	color = "#000067" // rgb: 0, 0, 103
	toxpwr = 0
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	pH = 11

/datum/reagent/toxin/fakebeer	//disguised as normal beer for use by emagged brobots
	name = "Beer"
	description = "A specially-engineered sedative disguised as beer. It induces instant sleep in its target."
	color = "#664300" // rgb: 102, 67, 0
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "piss water"
	glass_icon_state = "beerglass"
	glass_name = "glass of beer"
	glass_desc = "A freezing pint of beer."
	pH = 2
	value = REAGENT_VALUE_VERY_RARE

/datum/reagent/toxin/fakebeer/on_mob_life(mob/living/carbon/M)
	switch(current_cycle)
		if(1 to 50)
			M.Sleeping(40, 0)
		if(51 to INFINITY)
			M.Sleeping(40, 0)
	return ..()

/datum/reagent/toxin/coffeepowder
	name = "Coffee Grounds"
	description = "Finely ground coffee beans, used to make coffee."
	reagent_state = SOLID
	color = "#5B2E0D" // rgb: 91, 46, 13
	toxpwr = 0.5
	pH = 4.2
	value = REAGENT_VALUE_VERY_COMMON

/datum/reagent/toxin/teapowder
	name = "Ground Tea Leaves"
	description = "Finely shredded tea leaves, used for making tea."
	reagent_state = SOLID
	color = "#7F8400" // rgb: 127, 132, 0
	toxpwr = 0.5
	pH = 4.9
	value = REAGENT_VALUE_VERY_COMMON

/datum/reagent/toxin/teapowder/red
	name = "Ground Red Tea Leaves"
	toxpwr = 0.4

/datum/reagent/toxin/teapowder/green
	name = "Ground Green Tea Leaves"
	toxpwr = 0.6

/datum/reagent/toxin/mutetoxin //the new zombie powder.
	name = "Mute Toxin"
	description = "A nonlethal poison that inhibits speech in its victim."
	color = "#F0F8FF" // rgb: 240, 248, 255
	toxpwr = 0
	taste_description = "silence"
	pH = 12.2

/datum/reagent/toxin/staminatoxin
	name = "Tirizene"
	description = "A nonlethal poison that causes extreme fatigue and weakness in its victim."
	color = "#6E2828"
	data = 15
	toxpwr = 0
	value = REAGENT_VALUE_UNCOMMON

/datum/reagent/toxin/polonium
	name = "Polonium"
	description = "An extremely radioactive material in liquid form. Ingestion results in fatal irradiation."
	reagent_state = LIQUID
	color = "#787878"
	metabolization_rate = 0.125 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_ALL_PROCESS
	toxpwr = 0
	value = REAGENT_VALUE_VERY_RARE

/datum/reagent/toxin/histamine
	name = "Histamine"
	description = "Histamine's effects become more dangerous depending on the dosage amount. They range from mildly annoying to incredibly lethal."
	reagent_state = LIQUID
	color = "#FA6464"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30
	toxpwr = 0
	value = REAGENT_VALUE_UNCOMMON

/datum/reagent/toxin/formaldehyde
	name = "Formaldehyde"
	description = "Formaldehyde, on its own, is a fairly weak toxin. It contains trace amounts of Histamine, very rarely making it decay into Histamine."
	reagent_state = LIQUID
	color = "#B4004B"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_ALL_PROCESS
	toxpwr = 1

/datum/reagent/toxin/venom
	name = "Venom"
	description = "An exotic poison extracted from highly toxic fauna. Causes scaling amounts of toxin damage and bruising depending and dosage. Often decays into Histamine."
	reagent_state = LIQUID
	color = "#F0FFF0"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	toxpwr = 0
	value = REAGENT_VALUE_VERY_RARE

/datum/reagent/toxin/fentanyl
	name = "Fentanyl"
	description = "Fentanyl will inhibit brain function and cause toxin damage before eventually knocking out its victim."
	reagent_state = LIQUID
	color = "#64916E"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	toxpwr = 0

/datum/reagent/toxin/cyanide
	name = "Cyanide"
	description = "An infamous poison known for its use in assassination. Causes small amounts of toxin damage with a small chance of oxygen damage or a stun."
	reagent_state = LIQUID
	color = "#00B4FF"
	metabolization_rate = 0.125 * REAGENTS_METABOLISM
	toxpwr = 1.25
	value = REAGENT_VALUE_UNCOMMON


/datum/reagent/toxin/bad_food
	name = "Bad Food"
	description = "The result of some abomination of cookery, food so bad it's toxic."
	reagent_state = LIQUID
	color = "#d6d6d8"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	toxpwr = 0.5
	taste_description = "bad cooking"
	value = REAGENT_VALUE_NONE

/datum/reagent/toxin/itching_powder
	name = "Itching Powder"
	description = "A powder that induces itching upon contact with the skin. Causes the victim to scratch at their itches and has a very low chance to decay into Histamine."
	reagent_state = LIQUID
	color = "#C8C8C8"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	toxpwr = 0

/datum/reagent/toxin/initropidril
	name = "Initropidril"
	description = "A powerful poison with insidious effects. It can cause stuns, lethal breathing failure, and cardiac arrest."
	reagent_state = LIQUID
	color = "#7F10C0"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	toxpwr = 2.5
	value = REAGENT_VALUE_EXCEPTIONAL

/datum/reagent/toxin/pancuronium
	name = "Pancuronium"
	description = "An undetectable toxin that swiftly incapacitates its victim. May also cause breathing failure."
	reagent_state = LIQUID
	color = "#195096"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	toxpwr = 0
	taste_mult = 0 // undetectable, I guess?
	value = REAGENT_VALUE_VERY_RARE

/datum/reagent/toxin/sodium_thiopental
	name = "Sodium Thiopental"
	description = "Sodium Thiopental induces heavy weakness in its target as well as unconsciousness."
	reagent_state = LIQUID
	color = "#6496FA"
	metabolization_rate = 0.75 * REAGENTS_METABOLISM
	toxpwr = 0
	value = REAGENT_VALUE_VERY_RARE

/datum/reagent/toxin/sulfonal
	name = "Sulfonal"
	description = "A stealthy poison that deals minor toxin damage and eventually puts the target to sleep."
	reagent_state = LIQUID
	color = "#7DC3A0"
	metabolization_rate = 0.125 * REAGENTS_METABOLISM
	toxpwr = 0.5

/datum/reagent/toxin/amanitin
	name = "Amanitin"
	description = "A very powerful delayed toxin. Upon full metabolization, a massive amount of toxin damage will be dealt depending on how long it has been in the victim's bloodstream."
	reagent_state = LIQUID
	color = "#FFFFFF"
	toxpwr = 0
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	value = REAGENT_VALUE_RARE

/datum/reagent/toxin/lipolicide
	name = "Lipolicide"
	description = "A powerful toxin that will destroy fat cells, massively reducing body weight in a short time. Deadly to those without nutriment in their body."
	taste_description = "mothballs"
	reagent_state = LIQUID
	color = "#F0FFF0"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	toxpwr = 0

/datum/reagent/toxin/coniine
	name = "Coniine"
	description = "Coniine metabolizes extremely slowly, but deals high amounts of toxin damage and stops breathing."
	reagent_state = LIQUID
	color = "#7DC3A0"
	metabolization_rate = 0.06 * REAGENTS_METABOLISM
	toxpwr = 1.75
	value = REAGENT_VALUE_EXCEPTIONAL

/datum/reagent/toxin/spewium
	name = "Spewium"
	description = "A powerful emetic, causes uncontrollable vomiting.  May result in vomiting organs at high doses."
	reagent_state = LIQUID
	color = "#2f6617" //A sickly green color
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 29
	toxpwr = 0
	taste_description = "vomit"
	value = REAGENT_VALUE_VERY_RARE

/datum/reagent/toxin/curare
	name = "Curare"
	description = "Causes slight toxin damage followed by chain-stunning and oxygen damage."
	reagent_state = LIQUID
	color = "#191919"
	metabolization_rate = 0.125 * REAGENTS_METABOLISM
	toxpwr = 1
	value = REAGENT_VALUE_VERY_RARE

/datum/reagent/toxin/heparin //Based on a real-life anticoagulant. I'm not a doctor, so this won't be realistic.
	name = "Heparin"
	description = "A powerful anticoagulant. All open cut wounds on the victim will open up and bleed much faster"
	reagent_state = LIQUID
	color = "#C8C8C8" //RGB: 200, 200, 200
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	toxpwr = 0
	value = REAGENT_VALUE_VERY_RARE

/datum/reagent/toxin/rotatium //Rotatium. Fucks up your rotation and is hilarious
	name = "Rotatium"
	description = "A constantly swirling, oddly colourful fluid. Causes the consumer's sense of direction and hand-eye coordination to become wild."
	reagent_state = LIQUID
	color = "#AC88CA" //RGB: 172, 136, 202
	metabolization_rate = 0.6 * REAGENTS_METABOLISM
	toxpwr = 0.5
	taste_description = "spinning"
	value = REAGENT_VALUE_VERY_RARE

/datum/reagent/toxin/rotatium/on_mob_life(mob/living/carbon/M)
	return ..()		// until fixed - the rotations never stop
/*
	if(M.hud_used)
		if(current_cycle >= 20 && current_cycle%20 == 0)
			var/list/screens = list(M.hud_used.plane_masters["[FLOOR_PLANE]"], M.hud_used.plane_masters["[GAME_PLANE]"],
									M.hud_used.plane_masters["[LIGHTING_PLANE]"], M.hud_used.plane_masters["[WALL_PLANE]"],
									M.hud_used.plane_masters["[ABOVE_WALL_PLANE]"])
			var/rotation = min(round(current_cycle/20), 89) // By this point the player is probably puking and quitting anyway
			for(var/whole_screen in screens)
				animate(whole_screen, transform = matrix(rotation, MATRIX_ROTATE), time = 5, easing = QUAD_EASING, loop = -1)
				animate(transform = matrix(-rotation, MATRIX_ROTATE), time = 5, easing = QUAD_EASING)
	return ..()

/datum/reagent/toxin/rotatium/on_mob_end_metabolize(mob/living/M)
	if(M && M.hud_used)
		var/list/screens = list(M.hud_used.plane_masters["[FLOOR_PLANE]"], M.hud_used.plane_masters["[GAME_PLANE]"], M.hud_used.plane_masters["[LIGHTING_PLANE]"])
		for(var/whole_screen in screens)
			animate(whole_screen, transform = matrix(), time = 5, easing = QUAD_EASING)
	..()
*/

/datum/reagent/toxin/skewium
	name = "Skewium"
	description = "A strange, dull coloured liquid that appears to warp back and forth inside its container. Causes any consumer to experience a visual phenomena similar to said warping."
	reagent_state = LIQUID
	color = "#ADBDCD"
	metabolization_rate = 0.8 * REAGENTS_METABOLISM
	toxpwr = 0.25
	taste_description = "skewing"
	value = REAGENT_VALUE_EXCEPTIONAL

/datum/reagent/toxin/skewium/on_mob_life(mob/living/carbon/M)
	/*
	if(M.hud_used)
		if(current_cycle >= 5 && current_cycle % 3 == 0)
			var/list/screens = list(M.hud_used.plane_masters["[FLOOR_PLANE]"], M.hud_used.plane_masters["[GAME_PLANE]"],
									M.hud_used.plane_masters["[LIGHTING_PLANE]"], M.hud_used.plane_masters["[WALL_PLANE]"],
									M.hud_used.plane_masters["[ABOVE_WALL_PLANE]"])			var/matrix/skew = matrix()
			var/intensity = 8
			skew.set_skew(rand(-intensity,intensity), rand(-intensity,intensity))
			var/matrix/newmatrix = skew

			if(prob(33)) // 1/3rd of the time, let's make it stack with the previous matrix! Mwhahahaha!
				for(var/whole_screen in screens)
					var/atom/movable/screen/plane_master/PM = whole_screen
					newmatrix = skew * PM.transform

			for(var/whole_screen in screens)
				animate(whole_screen, transform = newmatrix, time = 5, easing = QUAD_EASING, loop = -1)
				animate(transform = -newmatrix, time = 5, easing = QUAD_EASING)
	*/
	return ..()
/*
/datum/reagent/toxin/skewium/on_mob_end_metabolize(mob/living/M)
	if(M && M.hud_used)
		var/list/screens = list(M.hud_used.plane_masters["[FLOOR_PLANE]"], M.hud_used.plane_masters["[GAME_PLANE]"], M.hud_used.plane_masters["[LIGHTING_PLANE]"])
		for(var/whole_screen in screens)
			animate(whole_screen, transform = matrix(), time = 5, easing = QUAD_EASING)
	..()
*/

/datum/reagent/toxin/anacea
	name = "Anacea"
	description = "A toxin that quickly purges medicines and metabolizes very slowly."
	reagent_state = LIQUID
	color = "#3C5133"
	metabolization_rate = 0.08 * REAGENTS_METABOLISM
	toxpwr = 0.15
	value = REAGENT_VALUE_VERY_RARE

//ACID


/datum/reagent/toxin/acid
	name = "Sulphuric acid"
	description = "A strong mineral acid with the molecular formula H2SO4."
	color = "#00FF32"
	toxpwr = 1
	chemical_flags = REAGENT_ALL_PROCESS	//Ever injected acid into a robot?
	var/acidpwr = 10 //the amount of protection removed from the armour
	taste_description = "acid"
	self_consuming = TRUE
	pH = 2.75
	value = REAGENT_VALUE_NONE

// Sure, go ahead and pour acid on your precious plants. What's the worst that could happen?
/datum/reagent/toxin/acid/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(-round(chems.get_reagent_amount(type) * 1))
		mytray.adjustToxic(round(chems.get_reagent_amount(type) * 1.5))
		mytray.adjustWeeds(-rand(1,2))

/datum/reagent/toxin/acid/fluacid
	name = "Fluorosulfuric acid"
	description = "Fluorosulfuric acid is an extremely corrosive chemical substance."
	color = "#5050FF"
	toxpwr = 2
	acidpwr = 42.0
	value = REAGENT_VALUE_COMMON

// ACID II: UNHEEDED WARNINGS
/datum/reagent/toxin/acid/fluacid/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(-round(chems.get_reagent_amount(type) * 2))
		mytray.adjustToxic(round(chems.get_reagent_amount(type) * 3))
		mytray.adjustWeeds(-rand(1,4))

/datum/reagent/toxin/delayed
	name = "Toxin Microcapsules"
	description = "Causes heavy toxin damage after a brief time of inactivity."
	reagent_state = LIQUID
	metabolization_rate = 0 //stays in the system until active.
	var/actual_metaboliztion_rate = REAGENTS_METABOLISM
	toxpwr = 0
	value = REAGENT_VALUE_VERY_RARE
	var/actual_toxpwr = 5
	var/delay = 30

/datum/reagent/toxin/mimesbane
	name = "Mime's Bane"
	description = "A nonlethal neurotoxin that interferes with the victim's ability to gesture."
	color = "#F0F8FF" // rgb: 240, 248, 255
	toxpwr = 0
	taste_description = "stillness"
	value = REAGENT_VALUE_RARE

/datum/reagent/toxin/bonehurtingjuice //oof ouch
	name = "Bone Hurting Juice"
	description = "A strange substance that looks a lot like water. Drinking it is oddly tempting. Oof ouch."
	color = "#AAAAAA77" //RGBA: 170, 170, 170, 77
	toxpwr = 0
	taste_description = "bone hurting"
	overdose_threshold = 20
	value = REAGENT_VALUE_VERY_RARE //because it's very funny.

/datum/reagent/toxin/brainhurtingjuice //oof ouch
	name = "Brain Hurting Juice"
	color = "#AAAAAA77" //RGBA: 170, 170, 170, 77
	toxpwr = 0
	taste_description = "brain hurting"
	metabolization_rate = 5
	value = REAGENT_VALUE_EXCEPTIONAL

/datum/reagent/toxin/bungotoxin
	name = "Bungotoxin"
	description = "A horrible cardiotoxin that protects the humble bungo pit."
	//silent_toxin = TRUE //I guess we don't really have the entire tox system ported.
	color = "#EBFF8E"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	toxpwr = 0
	taste_description = "tannin"
	value = REAGENT_VALUE_RARE

/datum/reagent/toxin/leadacetate
	name = "Lead Acetate"
	description = "Used hundreds of years ago as a sweetener, before it was realized that it's incredibly poisonous."
	reagent_state = SOLID
	color = "#2b2b2b" // rgb: 127, 132, 0
	toxpwr = 0.5
	taste_mult = 1.3
	taste_description = "sugary sweetness"
