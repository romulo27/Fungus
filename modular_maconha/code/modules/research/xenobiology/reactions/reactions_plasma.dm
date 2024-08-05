
/* -------------------------------------------------------------------------- */
/*                                   Genesis                                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------- Monkey Creation ---------------------------- */

/datum/extract_reaction/plasma/create_monkey
	effect_text = "summons a monkey cube"
	category = REACTION_CATEGORY_CREATION
	point_cost = POINT_COST_MINIMAL
	point_reward = POINT_REWARD_MINIMAL

/datum/extract_reaction/plasma/create_monkey/on_chemical_reaction(obj/item/slime_extract/extract)
	new /obj/item/reagent_containers/food/snacks/cube/monkey(get_turf(extract))
