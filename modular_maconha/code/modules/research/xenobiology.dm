// TODO: IDs for every type of reaction
//GLOBAL_LIST_EMPTY(extract_reaction_ids)

/obj/item/slime_extract
	name = "slime extract"
	desc = "Goo extracted from a slime. Legends claim these to have \"magical powers\"."
	icon = 'icons/obj/slimecrossing.dmi'
	icon_state = "base"
	force = 0
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 6
	grind_results = list()
	var/colour = "null"
	var/Uses = 1 // uses before it goes inert
	var/qdel_timer = null // deletion timer, for delayed reactions
	var/effectmod
	var/list/activate_reagents = list() //Reagents required for activation
	var/recurring = FALSE
	var/datum/extract_reaction/reaction_blood
	var/datum/extract_reaction/reaction_lumi
	var/datum/extract_reaction/reaction_other
	var/datum/extract_reaction/reaction_plasma
	var/datum/extract_reaction/reaction_water

/obj/item/slime_extract/examine(mob/user)
	. = ..()
	if(Uses > 1)
		. += "It has [Uses] uses remaining."

	var/reactions = get_reactions()
	for(var/datum/extract_reaction/reaction in reactions)
		var/result = reaction.examine(src, user)
		if (result)
		. += result

/obj/item/slime_extract/attackby(obj/item/O, mob/user)
	var/reactions = get_reactions()
	for(var/datum/extract_reaction/reaction in reactions)
		var/result = reaction.use_item(src, O, user)
		if (result == TRUE)
			return ..()

	if(istype(O, /obj/item/slimepotion/enhancer))
		if(Uses >= 5 || recurring)
			to_chat(user, "<span class='warning'>You cannot enhance this extract further!</span>")
			return ..()
		if(O.type == /obj/item/slimepotion/enhancer) //Seriously, why is this defined here...?
			to_chat(user, "<span class='notice'>You apply the enhancer to the slime extract. It may now be reused one more time.</span>")
			Uses++
		if(O.type == /obj/item/slimepotion/enhancer/max)
			to_chat(user, "<span class='notice'>You dump the maximizer on the slime extract. It can now be used a total of 5 times!</span>")
			Uses = 5
		qdel(O)
	..()

/obj/item/slime_extract/on_grind()
	var/reactions = get_reactions()
	for(var/datum/extract_reaction/reaction in reactions)
		var/result = reaction.on_grind(src)
		if (result == TRUE)
			return


	if(Uses)
		grind_results[/datum/reagent/toxin/slimejelly] = 20

//Effect when activated by a Luminescent. Separated into a minor and major effect. Returns cooldown in deciseconds.
/obj/item/slime_extract/proc/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	var/reactions = get_reactions()
	for(var/datum/extract_reaction/reaction in reactions)
		var/result = reaction.activate(src, user, species, activation_type)
	to_chat(user, "<span class='notice'>Nothing happened... This slime extract cannot be activated this way.</span>")
	return 0

//Core-crossing: Feeding adult slimes extracts to obtain a much more powerful, single extract.
/obj/item/slime_extract/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		return ..()

	var/reactions = get_reactions()
	for(var/datum/extract_reaction/reaction in reactions)
		var/result = reaction.use_on_slime(src, M, user)
		if (result == TRUE)
			return

	if(M.stat)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return
	if(!M.is_adult)
		to_chat(user, "<span class='warning'>The slime must be an adult to cross it's core!</span>")
		return
	if(M.effectmod && M.effectmod != effectmod)
		to_chat(user, "<span class='warning'>The slime is already being crossed with a different extract!</span>")
		return

	if(!M.effectmod)
		M.effectmod = effectmod

	M.applied++
	qdel(src)
	to_chat(user, "<span class='notice'>You feed the slime [src], [M.applied == 1 ? "starting to mutate its core." : "further mutating its core."]</span>")
	playsound(M, 'sound/effects/attackblob.ogg', 50, 1)

	if(M.applied >= SLIME_EXTRACT_CROSSING_REQUIRED)
		M.spawn_corecross()

/obj/item/slime_extract/microwave_act(obj/machinery/microwave/M)
	var/reactions = get_reactions()
	for(var/datum/extract_reaction/reaction in reactions)
		var/result = reaction.on_microwave(src, M)
		if(result == TRUE)
			return
	. = ..()

/obj/item/slime_extract/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, atom/movable/source)
	. = ..()
	var/reactions = get_reactions()
	for(var/datum/extract_reaction/reaction in reactions)
		var/result = reaction.on_hear(src, message, speaker, message_language, raw_message, radio_freq, spans, message_mode, source)
		if (result == TRUE)
			return

/obj/item/slime_extract/attack_hand(mob/user, act_intent, attackchain_flags)
	. = ..()
	var/reactions = get_reactions()
	for(var/datum/extract_reaction/reaction in reactions)
		var/result = reaction.on_attack_hand(src, user, act_intent, attackchain_flags)
		if (result == TRUE)
			return

/* -------------------------------------------------------------------------- */
/*                               Internal Stuff                               */
/* -------------------------------------------------------------------------- */

/obj/item/slime_extract/get_reactions()
	var/list/results = list()

	if (reaction_blood)
		results.Add(reaction_blood)
	if (reaction_lumi)
		results.Add(reaction_lumi)
	if (reaction_other)
		results.Add(reaction_other)
	if (reaction_plasma)
		results.Add(reaction_plasma)
	if (reaction_water)
		results.Add(reaction_water)

	return results

/obj/item/slime_extract/pick_reactions()
	// Load all xenobiology reactions
	var/reactions_plasma = subtypesof(/datum/extract_reaction/plasma)
	var/reactions_water = subtypesof(/datum/extract_reaction/water)
	var/reactions_blood = subtypesof(/datum/extract_reaction/blood)
	var/reactions_lumi = subtypesof(/datum/extract_reaction/lumi)
	var/reactions_other = subtypesof(/datum/extract_reaction/other)

	// Select a random one for this slime
	reaction_water = new pick(reactions_water)
	if (prob(50))
		reaction_plasma = new pick(reactions_plasma)
	if (prob(20))
		reaction_blood = new pick(reactions_blood)
	if(prob(20))
		reaction_lumi = new pick(reactions_lumi)
	if(prob(30) && !reaction_lumi)
		reaction_other = new pick(reactions_other)


/* -------------------------------------------------------------------------- */
/*                               Initialization                               */
/* -------------------------------------------------------------------------- */

/obj/item/slime_extract/Initialize(mapload)
	. = ..()
	create_reagents(100, INJECTABLE | DRAWABLE)
	pick_reactions()
	name = colour + " slime extract"
	var/itemcolor = "#FFFFFF"
	switch(colour)
		if("orange")
			itemcolor = "#FFA500"
		if("purple")
			itemcolor = "#B19CD9"
		if("blue")
			itemcolor = "#ADD8E6"
		if("metal")
			itemcolor = "#7E7E7E"
		if("yellow")
			itemcolor = "#FFFF00"
		if("dark purple")
			itemcolor = "#551A8B"
		if("dark blue")
			itemcolor = "#0000FF"
		if("silver")
			itemcolor = "#D3D3D3"
		if("bluespace")
			itemcolor = "#32CD32"
		if("sepia")
			itemcolor = "#704214"
		if("cerulean")
			itemcolor = "#2956B2"
		if("pyrite")
			itemcolor = "#FAFAD2"
		if("red")
			itemcolor = "#FF0000"
		if("green")
			itemcolor = "#00FF00"
		if("pink")
			itemcolor = "#FF69B4"
		if("gold")
			itemcolor = "#FFD700"
		if("oil")
			itemcolor = "#505050"
		if("black")
			itemcolor = "#000000"
		if("light pink")
			itemcolor = "#FFB6C1"
		if("adamantine")
			itemcolor = "#008B8B"
	add_atom_colour(itemcolor, FIXED_COLOUR_PRIORITY)

/* -------------------------------------------------------------------------- */
/*                                 Processing                                 */
/* -------------------------------------------------------------------------- */

/obj/item/slime_extract/process(delta_time)
	var/working = FALSE
	var/reactions = get_reactions()
	for(var/datum/extract_reaction/reaction in reactions)
		var/result = reaction.do_process()
		if (result == TRUE)
			working = TRUE
			return
	. = ..()

/* -------------------------------------------------------------------------- */
/*                                   Colors                                   */
/* -------------------------------------------------------------------------- */

/obj/item/slime_extract/orange
	colour = "orange"

/obj/item/slime_extract/purple
	colour = "purple"

/obj/item/slime_extract/blue
	colour = "blue"

/obj/item/slime_extract/metal
	colour = "metal"

/obj/item/slime_extract/yellow
	colour = "yellow"

/obj/item/slime_extract/dark_purple
	colour = "dark purple"

/obj/item/slime_extract/dark_blue
	colour = "dark blue"

/obj/item/slime_extract/silver
	colour = "silver"

/obj/item/slime_extract/bluespace
	colour = "bluespace"

/obj/item/slime_extract/sepia
	colour = "sepia"

/obj/item/slime_extract/cerulean
	colour = "cerulean"

/obj/item/slime_extract/pyrite
	colour = "pyrite"

/obj/item/slime_extract/red
	colour = "red"

/obj/item/slime_extract/green
	colour = "green"

/obj/item/slime_extract/pink
	colour = "pink"

/obj/item/slime_extract/gold
	colour = "gold"

/obj/item/slime_extract/oil
	colour = "oil"

/obj/item/slime_extract/black
	colour = "black"

/obj/item/slime_extract/light_pink
	colour = "light pink"

/obj/item/slime_extract/adamantine
	colour = "adamantine"

/obj/item/slime_extract/grey
	colour = "grey"


/* ------------------------------------ - ----------------------------------- */
