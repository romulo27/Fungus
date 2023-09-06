//Main code edits
/datum/quirk/photographer
	desc = "You carry your camera and personal photo album everywhere you go, and you're quicker at taking pictures."

/datum/quirk/photographer/on_spawn()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/storage/photo_album/photo_album = new(get_turf(H))
	H.put_in_hands(photo_album)
	H.equip_to_slot(photo_album, ITEM_SLOT_BACKPACK)
	photo_album.persistence_id = "personal_[H.mind.key]" // this is a persistent album, the ID is tied to the account's key to avoid tampering
	photo_album.persistence_load()
	photo_album.name = "[H.real_name]'s photo album"

//Own stuff
/datum/quirk/tough
	name = "Tough"
	desc = "Your body is abnormally enduring and can take 10% more damage."
	value = 4
	medical_record_text = "Patient has an abnormally high capacity for injury."
	gain_text = span_notice("You feel very sturdy.")
	lose_text = span_notice("You feel less sturdy.")

/datum/quirk/tough/add()
	quirk_holder.maxHealth *= 1.1

/datum/quirk/tough/remove()
	if(!quirk_holder)
		return
	quirk_holder.maxHealth *= 0.909 //close enough

/datum/quirk/ashresistance
	name = "Ashen Resistance"
	desc = "Your body is adapted to the burning sheets of ash that coat volcanic worlds, though the heavy downpours of silt will still tire you."
	value = 2 //Is not actually THAT good. Does not grant breathing and does stamina damage to the point you are unable to attack. Crippling on lavaland, but you'll survive. Is not a replacement for SEVA suits for this reason. Can be adjusted.
	mob_trait = TRAIT_ASHRESISTANCE
	medical_record_text = "Patient has an abnormally thick epidermis."
	gain_text = span_notice("You feel resistant to burning brimstone.")
	lose_text = span_notice("You feel less as if your flesh is more flamamble.")

/* --FALLBACK SYSTEM INCASE THE TRAIT FAILS TO WORK. Do NOT enable this without editing ash_storm.dm to deal stamina damage with ash immunity.
/datum/quirk/ashresistance/add()
	quirk_holder.weather_immunities |= "ash"

/datum/quirk/ashresistance/remove()
	if(!quirk_holder)
		return
	quirk_holder.weather_immunities -= "ash"
*/

/datum/quirk/rad_fiend
	name = "Rad Fiend"
	desc = "You've been blessed by Cherenkov's warming light, causing you to emit a subtle glow at all times. Only -very- intense radiation is capable of penetrating your protective barrier."
	value = 2
	mob_trait = TRAIT_RAD_FIEND
	gain_text = span_notice("You feel empowered by Cherenkov's glow.")
	lose_text = span_notice("You realize that rads aren't so rad.")

/datum/quirk/rad_fiend/add()
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder
	// Add glow control action
	var/datum/action/rad_fiend/update_glow/quirk_action = new
	quirk_action.Grant(quirk_mob)

/datum/quirk/rad_fiend/remove()
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove glow control action
	var/datum/action/rad_fiend/update_glow/quirk_action = locate() in quirk_mob.actions
	quirk_action.Remove(quirk_mob)

	// Remove glow effect
	quirk_mob.remove_filter("rad_fiend_glow")

/datum/quirk/dominant_aura
	name = "Dominant Aura"
	desc = "Your mere presence is assertive enough to appear as powerful to other people, so much in fact that the weaker kind can't help but throw themselves at your feet at the snap of a finger."
	value = 1
	gain_text = span_notice("You feel like making someone your pet.")
	lose_text = span_notice("You feel less assertive.")

/datum/quirk/dominant_aura/add()
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE, .proc/on_examine_holder)
	RegisterSignal(quirk_holder, COMSIG_MOB_EMOTE, .proc/handle_snap)

/datum/quirk/dominant_aura/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE)
	UnregisterSignal(quirk_holder, COMSIG_MOB_EMOTE)

/datum/quirk/dominant_aura/proc/on_examine_holder(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!ishuman(user))
		return
	var/mob/living/carbon/human/sub = user
	if(!sub.has_quirk(/datum/quirk/well_trained) || (sub == quirk_holder))
		return

	examine_list += span_lewd("\nYou can't make eye contact with [quirk_holder.p_them()] before flustering away!")
	if(!TIMER_COOLDOWN_CHECK(user, COOLDOWN_DOMINANT_EXAMINE))
		to_chat(quirk_holder, span_notice("\The [user] tries to look at you but immediately turns away with a red face..."))
		TIMER_COOLDOWN_START(user, COOLDOWN_DOMINANT_EXAMINE, 10 SECONDS)
		sub.dir = turn(get_dir(sub, quirk_holder), pick(-90, 90))
		sub.emote("blush")

/datum/quirk/dominant_aura/proc/handle_snap(datum/source, list/emote_args)
	SIGNAL_HANDLER

	. = FALSE
	var/datum/emote/E
	E = E.emote_list[lowertext(emote_args[EMOTE_ACT])]
	if(TIMER_COOLDOWN_CHECK(quirk_holder, COOLDOWN_DOMINANT_SNAP) || !findtext(E?.key, "snap"))
		return
	for(var/mob/living/carbon/human/sub in hearers(DOMINANT_DETECT_RANGE, quirk_holder))
		if(!sub.has_quirk(/datum/quirk/well_trained) || (sub == quirk_holder))
			continue
		var/good_x = "pet"
		switch(sub.gender)
			if(MALE)
				good_x = "boy"
			if(FEMALE)
				good_x = "girl"
		switch(E?.key)
			if("snap")
				sub.dir = get_dir(sub, quirk_holder)
				sub.emote(pick("blush", "pant"))
				sub.visible_message(span_notice("\The <b>[sub]</b> turns shyly towards \the <b>[quirk_holder]</b>."),
									span_lewd("You stare into \the [quirk_holder] submissively."))
			if("snap2")
				sub.dir = get_dir(sub, quirk_holder)
				sub.KnockToFloor()
				sub.emote(pick("blush", "pant"))
				sub.visible_message(span_lewd("\The <b>[sub]</b> submissively throws [sub.p_them()]self on the floor."),
									span_lewd("You throw yourself on the floor like a pathetic beast on <b>[quirk_holder]</b>'s command."))
			if("snap3")
				sub.KnockToFloor()
				step(sub, get_dir(sub, quirk_holder))
				sub.emote(pick("blush", "pant"))
				sub.do_jitter_animation(30) //You're being moved anyways
				sub.visible_message(span_lewd("\The <b>[sub]</b> crawls closer to \the <b>[quirk_holder]</b> on all fours, following [quirk_holder.p_their()] command."),
									span_lewd("You get on your hands and knees and crawl towards \the <b>[quirk_holder]</b> like a good [good_x] would."))
		. = TRUE

	if(.)
		TIMER_COOLDOWN_START(quirk_holder, COOLDOWN_DOMINANT_SNAP, DOMINANT_SNAP_COOLDOWN)

/datum/quirk/arachnid
	name = "Arachnid"
	desc = "Your bodily anatomy allows you to spin webs and cocoons, even if you aren't an arachnid! (Note that this quirk does nothing for members of the arachnid species)"
	value = 1
	medical_record_text = "Patient has attempted to cover the room in webs, claiming to be \"making a nest\"."
	mob_trait = TRAIT_ARACHNID
	gain_text = span_notice("You feel a strange sensation near your anus...")
	lose_text = span_notice("You feel like you can't spin webs anymore...")
	processing_quirk = TRUE

/datum/quirk/arachnid/add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	if(is_species(H,/datum/species/arachnid))
		to_chat(H, span_warning("As an arachnid, this quirk does nothing for you, as these abilities are innate to your species."))
		return
	var/datum/action/innate/spin_web/SW = new
	var/datum/action/innate/spin_cocoon/SC = new
	SC.Grant(H)
	SW.Grant(H)

/datum/quirk/arachnid/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	if(is_species(H,/datum/species/arachnid))
		return
	var/datum/action/innate/spin_web/SW = locate(/datum/action/innate/spin_web) in H.actions
	var/datum/action/innate/spin_cocoon/SC = locate(/datum/action/innate/spin_cocoon) in H.actions
	SC?.Remove(H)
	SW?.Remove(H)

/datum/quirk/flutter
	name = "Flutter"
	desc = "You are able to move about freely in pressurized low-gravity environments be it through the use of wings, magic, or some other physiological nonsense."
	value = 1
	mob_trait = TRAIT_FLUTTER

/datum/quirk/cloth_eater
	name = "Clothes Eater"
	desc = "You can eat most apparel to gain a boost in mood, and to gain some nutrients. (Insects already have this.)"
	value = 1
	var/mood_category ="cloth_eaten"
	mob_trait = TRAIT_CLOTH_EATER

/datum/quirk/ropebunny
	name = "Rope Bunny"
	desc = "You have mastered all forms of bondage! You can create bondage rope out of cloth, and bondage bolas out of bondage rope!"
	value = 2

/datum/quirk/ropebunny/add()
	.=..()
	var/mob/living/carbon/human/H = quirk_holder
	if (!H)
		return
	var/datum/action/ropebunny/conversion/C = new
	C.Grant(H)

/datum/quirk/ropebunny/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/action/ropebunny/conversion/C = locate() in H.actions
	C.Remove(H)
	. = ..()

/datum/quirk/hallowed
	name = "Hallowed"
	desc = "You have been fortified against the dark arts, and made pure by something greater yourself. Demonic forces cannot touch you, and holy ones will favor you. A divine halo will hover over you at all times to show your purity. You could gain even more than that, if you have the right quirks."
	value = 1 // Maybe up the cost if more is added later.
	mob_trait = TRAIT_HALLOWED
	gain_text = span_notice("A divine light smiles down upon you.")
	lose_text = span_notice("You have forsaken the great gods...")
	medical_record_text = "Patient emits a measurable amount of unidentified radiation. Consult a scientist or perhaps a chaplain for advice."

	// Halo overlay effect
	var/mutable_appearance/quirk_halo
	var/mutable_appearance/quirk_halo_emi

	// Holy glow overlay effect
	var/mutable_appearance/quirk_glow

	// Emitted light effect
	var/quirk_light

	var/list/admin_perks = list(TRAIT_STUNIMMUNE, TRAIT_IGNORESLOWDOWN, TRAIT_TESLA_SHOCKIMMUNE, TRAIT_NODISMEMBER, TRAIT_QUICKER_CARRY, TRAIT_REAGENT_SCANNER, TRAIT_NODECAP, TRAIT_NOGUT, TRAIT_WEATHER_IMMUNE, TRAIT_NOBREATH ,TRAIT_RESISTCOLD, TRAIT_RESISTHEAT, TRAIT_RESISTHIGHPRESSURE, TRAIT_RESISTLOWPRESSURE, TRAIT_BOMBIMMUNE, TRAIT_TASED_RESISTANCE, TRAIT_SLEEPIMMUNE, TRAIT_SHOCKIMMUNE, TRAIT_INSANE_AIM,TRAIT_VIRUSIMMUNE, TRAIT_GENELESS, TRAIT_RADIMMUNE, TRAIT_PIERCEIMMUNE, TRAIT_NOHUNGER,TRAIT_NOTHIRST, TRAIT_NOFIRE, TRAIT_MINDSHIELD)

/datum/quirk/hallowed/add()
	// Define quirk mob.
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Give the holy trait.
	ADD_TRAIT(quirk_mob, TRAIT_HOLY, "quirk_hallowed")

	// Give the antimagic trait.
	ADD_TRAIT(quirk_mob, TRAIT_ANTIMAGIC_NO_SELFBLOCK, "quirk_hallowed")

	// Makes the user holy.
	quirk_mob.mind.isholy = TRUE

	// Add examine text.
	RegisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE, .proc/quirk_examine_Hallowed)

/datum/quirk/hallowed/remove()
	// Define quirk mob.
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove the holy trait.
	REMOVE_TRAIT(quirk_mob, TRAIT_HOLY, "quirk_hallowed")

	// Remove the antimagic trait.
	REMOVE_TRAIT(quirk_mob, TRAIT_ANTIMAGIC_NO_SELFBLOCK, "quirk_hallowed")

	// Makes the user not holy.
	quirk_mob.mind.isholy = FALSE

	// Remove examine text
	UnregisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE)

	// Tehee.
	if (quirk_mob.ckey && (quirk_mob.ckey == "fegelein17" || quirk_mob.ckey == "terantrizium"))
		for(var/perk in admin_perks)
			REMOVE_TRAIT(quirk_mob, perk, "quirk_hallowed")

	// Remove overlays
	quirk_holder.cut_overlay(quirk_halo)
	quirk_holder.cut_overlay(quirk_halo_emi)
	quirk_holder.cut_overlay(quirk_glow)

	// Remove light
	if(quirk_light)
		qdel(quirk_light)

	// Define deity name
	var/deity_name = DEFAULT_DEITY

	// Check for custom name
	if(quirk_holder.client && quirk_holder.client.prefs.custom_names["deity"])
		deity_name = quirk_holder.client.prefs.custom_names["deity"]

	to_chat(quirk_holder, span_boldwarning("You claimed to know [deity_name], but by your actions you denied Them. You are detestable, disobedient, and unfit for doing anything good."))

// Quirk examine text.
/datum/quirk/hallowed/proc/quirk_examine_Hallowed(atom/examine_target, mob/living/carbon/human/examiner, list/examine_list)
	examine_list += "[quirk_holder.p_they(TRUE)] radiates divine power..."

/datum/quirk/hallowed/post_add()
	. = ..()
	var/mob/living/carbon/human/quirk_mob = quirk_holder
	playsound(get_turf(quirk_mob), 'sound/effects/pray.ogg', 50, 0)

	// Tehee.
	if (quirk_mob.ckey && (quirk_mob.ckey == "fegelein17" || quirk_mob.ckey == "terantrizium"))
		for(var/perk in admin_perks)
			ADD_TRAIT(quirk_mob, perk, "quirk_hallowed")
		// Set halo overlay appearance
		quirk_halo = quirk_halo || mutable_appearance('modular_splurt/icons/obj/clothing/head.dmi', "halo_gold", ABOVE_MOB_LAYER)
		quirk_halo_emi = quirk_halo_emi || emissive_appearance('modular_splurt/icons/obj/clothing/head.dmi', "halo_gold_emi", ABOVE_MOB_LAYER)

		// Set halo offset
		quirk_halo.pixel_y += 4
		quirk_halo_emi.pixel_y += 4

		// Add halo to user
		quirk_mob.add_overlay(quirk_halo)
		quirk_mob.add_overlay(quirk_halo_emi)

		// Glow overlay
		quirk_glow = quirk_glow || mutable_appearance('icons/effects/genetics.dmi', "servitude", -MUTATIONS_LAYER)
		quirk_mob.add_overlay(quirk_glow)

		// Light
		quirk_light = quirk_mob.mob_light(_color = LIGHT_COLOR_HOLY_MAGIC, _range = 2)

		/* ---------------------------- Decorative Wings ---------------------------- */

		//var/has_wings = (quirk_mob.dna.species.mutant_bodyparts["deco_wings"] && quirk_mob.dna.features["deco_wings"] != "None" || quirk_mob.dna.species.mutant_bodyparts["insect_wings"] && quirk_mob.dna.features["insect_wings"] != "None")

		//// Assign wings if none exist
		//if(!has_wings)
		//	quirk_mob.dna.features["deco_wings"] = "Feathery"

		/* ---------------------------- Functional Wings ---------------------------- */

		// Define user's existing functional wings (taken from flightpotion)
		//var/has_functional_wings = (quirk_mob.dna.species.mutant_bodyparts["wings"] != null)
		//// Check if user already has functional wings
		//if(!has_functional_wings)
		//	// Give functional wings
		//	quirk_mob.dna.species.GiveSpeciesFlight(quirk_mob, FALSE)

	// Define deity name
	var/deity_name = DEFAULT_DEITY

	// Check for custom name
	if(quirk_holder.client && quirk_holder.client.prefs.custom_names["deity"])
		deity_name = quirk_holder.client.prefs.custom_names["deity"]

	// Based on John 5:24
	// Alert user of blessed status.
	quirk_mob.update_body()
	to_chat(quirk_holder, span_boldnotice("Truly, truly, you have heard the word of [deity_name] and believe They who sent you eternal life. Your kin will not come into judgment, but pass from death to life!"))


