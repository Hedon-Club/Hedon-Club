/datum/reagent/drug/maint/tar
	name = "Maintenance Tar"
	description = "An unknown tar that you most likely gotten from an assistant, a bored chemist... or cooked yourself."
	reagent_state = LIQUID
	color = "#000000"
	overdose_threshold = 30

/datum/reagent/drug/copium
	name = "Copium"
	description = "Cope and sssethe"
	taste_description = "coping"
	color = "#0f0"
	overdose_threshold = 30
	gas = GAS_COPIUM
	value = REAGENT_VALUE_GLORIOUS

/datum/reagent/drug/copium/on_mob_life(mob/living/carbon/M)
	. = ..()

	if (!ishuman(M))
		return
	var/mob/living/carbon/human/H = M
	if (prob(10))
		to_chat(H, "<span class='notice'>You feel like you can cope!</span>")
		H.adjust_disgust(-10)
		SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "copium", /datum/mood_event/cope, name)
	. = 1

/datum/reagent/drug/copium/overdose_start(mob/living/M)
	to_chat(M, "<span class='userdanger'>What the fuck.</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overdose, name)

/datum/reagent/drug/copium/overdose_process(mob/living/M)
	var/mob/living/carbon/human/H = M
	if (prob(5))
		H.adjust_disgust(20)
		to_chat(H, "<span class='warning'>I can't stand it anymore!</span>")
	..()
