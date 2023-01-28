// Add incompatible quirks
/datum/controller/subsystem/processing/quirks/Initialize(timeofday)
	. = ..()
	
	// Prevent Blessed Blood with traditionally 'unholy' quirks
	LAZYADD(quirk_blacklist, list(
		// The paleblood curse
		list("Blessed Blood","Cursed Blood"),

		// What do you want, milk drinker?
		//list("Blessed Blood","Incubus"),
		//list("Blessed Blood","Succubus"),

		// Vampires are traditionally harmed by anything holy
		list("Blessed Blood","Bloodsucker Fledgling"),

		// Werewolves are most often depicted as evil creatures harmed by anything holy
		list("Blessed Blood","Werewolf"),

		// Gargoyles can be interpreted as holy protectors
		//list("Blessed Blood","Gargoyle"),

		// Seeking self-harm can be interpreted as immoral
		// Wrath is one of the seven deadly sins
		list("Blessed Blood","Masochism"),

		// Causes rendering bugs
		// Comment this out if the bug is fixed
		list("Blessed Blood","Dullahan"),
		))
