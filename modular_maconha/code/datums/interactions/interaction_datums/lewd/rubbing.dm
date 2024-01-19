/datum/interaction/lewd/rub
	description = "Rub their pussy."
	interaction_sound = null
	write_log_user = "fingerrubbed"
	write_log_target = "was fingerrubbed by"
	require_user_hands = TRUE
	require_target_vagina = REQUIRE_EXPOSED
	max_distance = 1
	dynamic_act_name = "rub_pussy"

/datum/interaction/lewd/rub/display_interaction(mob/living/user, mob/living/partner)
	if((user.a_intent == INTENT_HELP) || (user.a_intent == INTENT_DISARM))
		user.visible_message("<span class='lewd'><b>\The [user]</b> [pick("rubs \the <b>[partner]</b> using his fingers.",
			"rubs \the <b>[partner]</b>'s pussy with his hands.",
			"gently rubs \the <b>[partner]</b>'s pussy with his fingers.")]</span>", ignored_mobs = user.get_unconsenting())
	if((user.a_intent == INTENT_GRAB) || (user.a_intent == INTENT_HARM))
		user.visible_message("<span class='lewd'><b>\The [user]</b> [pick("quickly rubs \the <b>[partner]</b> with his fingers.",
			"rubs \the <b>[partner]</b>'s pussy, agressively",
			"rubs \the <b>[partner]</b>'s pussy hard with his quick fingers")]</span>", ignored_mobs = user.get_unconsenting())
	partner.handle_post_sex(5, null, user, "vagina", dynamic_act_name)



/datum/interaction/lewd/rubcock
	description = "Rub their pussy with your cock."
	interaction_sound = null
	write_log_user = "rubbed"
	write_log_target = "was rubbed by"
	require_user_penis = REQUIRE_EXPOSED
	require_target_vagina = REQUIRE_EXPOSED
	max_distance = 1
	dynamic_act_name = "rub_pussy_penis"

/datum/interaction/lewd/rubcock/display_interaction(mob/living/user, mob/living/partner)
	if((user.a_intent == INTENT_HELP) || (user.a_intent == INTENT_DISARM))
		user.visible_message("<span class='lewd'><b>\The [user]</b> [pick("rubs \the <b>[partner]</b> using his cock.",
			"rubs \the <b>[partner]</b>'s pussy with his cock.",
			"gently rubs \the <b>[partner]</b>'s pussy with his tool.")]</span>", ignored_mobs = user.get_unconsenting())
	if((user.a_intent == INTENT_GRAB) || (user.a_intent == INTENT_HARM))
		user.visible_message("<span class='lewd'><b>\The [user]</b> [pick("aggresively rubs \the <b>[partner]</b> with his cock.",
			"rubs \the <b>[partner]</b>'s pussy rough with his tool.",
			"rubs \the <b>[partner]</b>'s pussy hard with his cock")]</span>", ignored_mobs = user.get_unconsenting())
	partner.handle_post_sex(5, null, user, "vagina", dynamic_act_name)
