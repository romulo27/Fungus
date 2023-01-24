// Add incompatible quirks
/datum/controller/subsystem/processing/quirks/Initialize(timeofday)
	. = ..()
	
	// Prevent Blessed Blood with traditionally 'unholy' quirks
	LAZYADD(quirk_blacklist, list(
		list("Blessed Blood","Cursed Blood"),
		list("Blessed Blood","Incubus"),
		list("Blessed Blood","Succubus"),
		list("Blessed Blood","Bloodsucker Fledgling"),
		list("Blessed Blood","Werewolf"),
		list("Blessed Blood","Gargoyle"),
		list("Blessed Blood","Masochism"),
		list("Blessed Blood","Dullahan"),
		//list("Blessed Blood","Rad Fiend"), // Doesn't exist yet
		))
