

/datum/extract_reaction
	var/name = "extract reaction"
	var/trigger_text = "unknown trigger"
	var/effect_text = "no effect"
	var/severity = REACTION_SEVERITY_NONE
	var/category = REACTION_CATEGORY_NONE
	var/point_cost = POINT_COST_NONE
	var/point_reward = POINT_REWARD_NONE
	var/discovered = FALSE
	var/datum/reagent/required_reagent
	var/required_reagent_amount = 5
	var/processed_reagent_amount = 0
/* -------------------------------- Standard -------------------------------- */

/datum/extract_reaction/plasma
	name = "plasma reaction"
	trigger_text = "A dosage of plasma"
	required_reagent = /datum/reagent/toxin/plasma

/datum/extract_reaction/water
	name = "water reaction"
	trigger_text = "A dosage of water"
	required_reagent = /datum/reagent/water

/datum/extract_reaction/lumi
	name = "lumi reaction"
	trigger_text = "Absorbtion by similar kind"

/datum/extract_reaction/blood
	name = "blood reaction"
	trigger_text = "A dosage of blood"
	required_reagent = /datum/reagent/blood

/datum/extract_reaction/other
	name = "non-standard reaction"

/* ------------------------------ Crossbreeding ----------------------------- */

// TODO //

// /datum/extract_reaction/burning
// 	name = "burning reaction"

// /datum/extract_reaction/charged
// 	name = "charged reaction"

// /datum/extract_reaction/chilling
// 	name = "chilling reaction"

// /datum/extract_reaction/consuming
// 	name = "consuming reaction"

// /datum/extract_reaction/industrial
// 	name = "industrial reaction"

// /datum/extract_reaction/prismatic
// 	name = "prismatic reaction"

// /datum/extract_reaction/recurring
// 	name = "recurring reaction"

// /datum/extract_reaction/regenerative
// 	name = "regenerative reaction"

// /datum/extract_reaction/reproductive
// 	name = "reproductive reaction"

// /datum/extract_reaction/selfsustaining
// 	name = "self sustaining reaction"

// /datum/extract_reaction/stabilized
// 	name = "stabilized reaction"

// TODO //

/* --------------------------------- Methods -------------------------------- */

/datum/extract_reaction/classify_severity()
	switch(severity)
		if(REACTION_SEVERITY_NONE)
			return "SAFE"
		if(REACTION_SEVERITY_LOW)
			return "LOW RISK"
		if(REACTION_SEVERITY_MEDIUM)
			return "MEDIUM RISK"
		if(REACTION_SEVERITY_HIGH)
			return "HIGH RISK"
	return "UNKNOWN"

/datum/extract_reaction/classify_category()
	return category

/datum/extract_reaction/do_process(obj/item/slime_extract/extract)
	if(!required_reagent)
		return

	var/working = FALSE
	if(extract.reagents.has_reagent(required_reagent, amount = 2) && required_reagent_amount > 1)
		reagents.remove_reagent(required_reagent, 2)
		processed_reagent_amount += 2
		working = TRUE
	else if(extract.reagents.has_reagent(required_reagent, amount = 1))
		extract.reagents.remove_reagent(required_reagent, 1)
		processed_reagent_amount += 1
		working = TRUE
	if (processed_reagent_amount >= required_reagent_amount)
		playsound(extract, 'sound/effects/attackblob.ogg', 50, 1)
		processed_reagent_amount -= required_reagent_amount
		on_chemical_reaction(extract)
	else if (working)
		playsound(src, 'sound/effects/bubbles.ogg', 5, 1)

	if (working)
		extract.icon_state = "industrial"
	else
		extract.icon_state = "base"

	return TRUE


/datum/extract_reaction/post_react(obj/item/slime_extract/extract)
	// TODO: Add Science Points.
	discovered = TRUE
	return


/* -------------------------------- Overrides ------------------------------- */


/datum/extract_reaction/examine(obj/item/slime_extract/extract, mob/user)
	return

/datum/extract_reaction/on_chemical_reaction(obj/item/slime_extract/extract)
	return FALSE

/datum/extract_reaction/use_item(obj/item/slime_extract/extract, obj/item/O, mob/user)
	return FALSE

/datum/extract_reaction/on_grind(obj/item/slime_extract/extract, )
	return FALSE

/datum/extract_reaction/activate(obj/item/slime_extract/extract, mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	return FALSE

/datum/extract_reaction/on_microwave(obj/item/slime_extract/extract, obj/machinery/microwave/M)
	return FALSE

/datum/extract_reaction/on_hear(obj/item/slime_extract/extract, message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, atom/movable/source)
	return FALSE

/datum/extract_reaction/on_attack_hand(obj/item/slime_extract/extract, mob/user, act_intent, unarmed_attack_flags)
	return FALSE

/datum/extract_reaction/use_on_slime(obj/item/slime_extract/extract, mob/living/simple_animal/slime/target_slime, mob/user)
	return FALSE

/* ------------------------------------ - ----------------------------------- */
