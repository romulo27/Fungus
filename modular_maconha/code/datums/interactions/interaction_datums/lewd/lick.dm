/datum/interaction/lewd/lickpenis
	description = "Lick their penis."
	interaction_sound = null
	require_user_mouth = TRUE
	require_target_penis = REQUIRE_EXPOSED
	max_distance = 1
	dynamic_act_name = "lick_penis"

/datum/interaction/lewd/lickpenis/display_interaction(mob/living/user, mob/living/partner)
	var/message = "[pick(
		"<b>\The [user]</b> licks \the <b>[partner]</b>'s tool",
		"<b>\The [user]</b> licks \the <b>[partner]</b>'s penis",
		"<b>\The [user]</b> licks \the <b>[partner]</b>'s shaft",
		"<b>\The [user]</b> licks across \the <b>[partner]</b>'s penis"
		"<b>\The [user]</b> traces her tongue across \the <b>[partner]</b>'s penis",
	)]" // I'm not the best on writing these messages.
	user.visible_message(span_lewd(message))
	user.handle_post_sex(LOW_LUST, null, partner, null, dynamic_act_name)
	partner.handle_post_sex(LOW_LUST, null, user, null, dynamic_act_name)
