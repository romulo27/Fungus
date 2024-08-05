/*
 If someone decides to name a var slot_flags
 outside of /obj/item, I will find you.
 (this sort of bitfield definition will ALWAYS
 use this menu so you can't var edit normally)
*/

DEFINE_BITFIELD(flags_inv, list(
	"HIDEACCESSORY" = HIDEACCESSORY,
	"HIDEEARS" = HIDEEARS,
	"HIDEEYES" = HIDEEYES,
	"HIDEFACE" = HIDEFACE,
	"HIDEFACIALHAIR" = HIDEFACIALHAIR,
	"HIDEGLOVES" = HIDEGLOVES,
	"HIDEHAIR" = HIDEHAIR,
	"HIDEJUMPSUIT" = HIDEJUMPSUIT,
	"HIDEMASK" = HIDEMASK,
	"HIDENECK" = HIDENECK,
	"HIDESHOES" = HIDESHOES,
	"HIDESNOUT" = HIDESNOUT,
	"HIDESUITSTORAGE" = HIDESUITSTORAGE,
	"HIDETAUR" = HIDETAUR,
	"HIDEUNDERWEAR" = HIDEUNDERWEAR,
	"HIDEWRISTS" = HIDEWRISTS,
))

DEFINE_BITFIELD(interaction_flags, list(
	"INTERACTION_FLAG_ADJACENT" = INTERACTION_FLAG_ADJACENT,
	"INTERACTION_FLAG_EXTREME_CONTENT" = INTERACTION_FLAG_EXTREME_CONTENT,
	"INTERACTION_FLAG_OOC_CONSENT" = INTERACTION_FLAG_OOC_CONSENT,
	"INTERACTION_FLAG_TARGET_NOT_TIRED" = INTERACTION_FLAG_TARGET_NOT_TIRED,
	"INTERACTION_FLAG_USER_IS_TARGET" = INTERACTION_FLAG_USER_IS_TARGET,
	"INTERACTION_FLAG_USER_NOT_TIRED" = INTERACTION_FLAG_USER_NOT_TIRED,
))

DEFINE_BITFIELD(required_from_user, list(
	"INTERACTION_REQUIRE_BOTTOMLESS" = INTERACTION_REQUIRE_BOTTOMLESS,
	"INTERACTION_REQUIRE_HANDS" = INTERACTION_REQUIRE_HANDS,
	"INTERACTION_REQUIRE_MOUTH" = INTERACTION_REQUIRE_MOUTH,
	"INTERACTION_REQUIRE_TOPLESS" = INTERACTION_REQUIRE_TOPLESS,
))

DEFINE_BITFIELD(required_from_user_exposed, list(
	"INTERACTION_REQUIRE_ANUS" = INTERACTION_REQUIRE_ANUS,
	"INTERACTION_REQUIRE_BALLS" = INTERACTION_REQUIRE_BALLS,
	"INTERACTION_REQUIRE_BREASTS" = INTERACTION_REQUIRE_BREASTS,
	"INTERACTION_REQUIRE_EARS" = INTERACTION_REQUIRE_EARS,
	"INTERACTION_REQUIRE_EARSOCKETS" = INTERACTION_REQUIRE_EARSOCKETS,
	"INTERACTION_REQUIRE_EYES" = INTERACTION_REQUIRE_EYES,
	"INTERACTION_REQUIRE_EYESOCKETS" = INTERACTION_REQUIRE_EYESOCKETS,
	"INTERACTION_REQUIRE_FEET" = INTERACTION_REQUIRE_FEET,
	"INTERACTION_REQUIRE_PENIS" = INTERACTION_REQUIRE_PENIS,
	"INTERACTION_REQUIRE_VAGINA" = INTERACTION_REQUIRE_VAGINA,
	"INTERACTION_REQUIRE_BELLY" = INTERACTION_REQUIRE_BELLY
))

DEFINE_BITFIELD(required_from_user_unexposed, list(
	"INTERACTION_REQUIRE_ANUS" = INTERACTION_REQUIRE_ANUS,
	"INTERACTION_REQUIRE_BALLS" = INTERACTION_REQUIRE_BALLS,
	"INTERACTION_REQUIRE_BREASTS" = INTERACTION_REQUIRE_BREASTS,
	"INTERACTION_REQUIRE_EARS" = INTERACTION_REQUIRE_EARS,
	"INTERACTION_REQUIRE_EARSOCKETS" = INTERACTION_REQUIRE_EARSOCKETS,
	"INTERACTION_REQUIRE_EYES" = INTERACTION_REQUIRE_EYES,
	"INTERACTION_REQUIRE_EYESOCKETS" = INTERACTION_REQUIRE_EYESOCKETS,
	"INTERACTION_REQUIRE_FEET" = INTERACTION_REQUIRE_FEET,
	"INTERACTION_REQUIRE_PENIS" = INTERACTION_REQUIRE_PENIS,
	"INTERACTION_REQUIRE_VAGINA" = INTERACTION_REQUIRE_VAGINA,
	"INTERACTION_REQUIRE_BELLY" = INTERACTION_REQUIRE_BELLY
))

DEFINE_BITFIELD(slot_flags, list(
	"ITEM_SLOT_ACCESSORY" = ITEM_SLOT_ACCESSORY,
	"ITEM_SLOT_BACK" = ITEM_SLOT_BACK,
	"ITEM_SLOT_BACKPACK" = ITEM_SLOT_BACKPACK,
	"ITEM_SLOT_BELT" = ITEM_SLOT_BELT,
	"ITEM_SLOT_DEX_STORAGE" = ITEM_SLOT_DEX_STORAGE,
	"ITEM_SLOT_EARS_LEFT" = ITEM_SLOT_EARS_LEFT,
	"ITEM_SLOT_EARS_RIGHT" = ITEM_SLOT_EARS_RIGHT,
	"ITEM_SLOT_EYES" = ITEM_SLOT_EYES,
	"ITEM_SLOT_FEET" = ITEM_SLOT_FEET,
	"ITEM_SLOT_GLOVES" = ITEM_SLOT_GLOVES,
	"ITEM_SLOT_HANDCUFFED" = ITEM_SLOT_HANDCUFFED,
	"ITEM_SLOT_HANDS" = ITEM_SLOT_HANDS,
	"ITEM_SLOT_HEAD" = ITEM_SLOT_HEAD,
	"ITEM_SLOT_ICLOTHING" = ITEM_SLOT_ICLOTHING,
	"ITEM_SLOT_ID" = ITEM_SLOT_ID,
	"ITEM_SLOT_LEGCUFFED" = ITEM_SLOT_LEGCUFFED,
	"ITEM_SLOT_LPOCKET" = ITEM_SLOT_LPOCKET,
	"ITEM_SLOT_MASK" = ITEM_SLOT_MASK,
	"ITEM_SLOT_NECK" = ITEM_SLOT_NECK,
	"ITEM_SLOT_OCLOTHING" = ITEM_SLOT_OCLOTHING,
	"ITEM_SLOT_RPOCKET" = ITEM_SLOT_RPOCKET,
	"ITEM_SLOT_SHIRT" = ITEM_SLOT_SHIRT,
	"ITEM_SLOT_SOCKS" = ITEM_SLOT_SOCKS,
	"ITEM_SLOT_SUITSTORE" = ITEM_SLOT_SUITSTORE,
	"ITEM_SLOT_UNDERWEAR" = ITEM_SLOT_UNDERWEAR,
	"ITEM_SLOT_WRISTS" = ITEM_SLOT_WRISTS,
))

DEFINE_BITFIELD(required_from_target, list(
	"INTERACTION_REQUIRE_BOTTOMLESS" = INTERACTION_REQUIRE_BOTTOMLESS,
	"INTERACTION_REQUIRE_HANDS" = INTERACTION_REQUIRE_HANDS,
	"INTERACTION_REQUIRE_MOUTH" = INTERACTION_REQUIRE_MOUTH,
	"INTERACTION_REQUIRE_TOPLESS" = INTERACTION_REQUIRE_TOPLESS,
))

DEFINE_BITFIELD(required_from_target_exposed, list(
	"INTERACTION_REQUIRE_ANUS" = INTERACTION_REQUIRE_ANUS,
	"INTERACTION_REQUIRE_BALLS" = INTERACTION_REQUIRE_BALLS,
	"INTERACTION_REQUIRE_BREASTS" = INTERACTION_REQUIRE_BREASTS,
	"INTERACTION_REQUIRE_EARS" = INTERACTION_REQUIRE_EARS,
	"INTERACTION_REQUIRE_EARSOCKETS" = INTERACTION_REQUIRE_EARSOCKETS,
	"INTERACTION_REQUIRE_EYES" = INTERACTION_REQUIRE_EYES,
	"INTERACTION_REQUIRE_EYESOCKETS" = INTERACTION_REQUIRE_EYESOCKETS,
	"INTERACTION_REQUIRE_FEET" = INTERACTION_REQUIRE_FEET,
	"INTERACTION_REQUIRE_PENIS" = INTERACTION_REQUIRE_PENIS,
	"INTERACTION_REQUIRE_VAGINA" = INTERACTION_REQUIRE_VAGINA,
	"INTERACTION_REQUIRE_BELLY" = INTERACTION_REQUIRE_BELLY
))

DEFINE_BITFIELD(required_from_target_unexposed, list(
	"INTERACTION_REQUIRE_ANUS" = INTERACTION_REQUIRE_ANUS,
	"INTERACTION_REQUIRE_BALLS" = INTERACTION_REQUIRE_BALLS,
	"INTERACTION_REQUIRE_BREASTS" = INTERACTION_REQUIRE_BREASTS,
	"INTERACTION_REQUIRE_EARS" = INTERACTION_REQUIRE_EARS,
	"INTERACTION_REQUIRE_EARSOCKETS" = INTERACTION_REQUIRE_EARSOCKETS,
	"INTERACTION_REQUIRE_EYES" = INTERACTION_REQUIRE_EYES,
	"INTERACTION_REQUIRE_EYESOCKETS" = INTERACTION_REQUIRE_EYESOCKETS,
	"INTERACTION_REQUIRE_FEET" = INTERACTION_REQUIRE_FEET,
	"INTERACTION_REQUIRE_PENIS" = INTERACTION_REQUIRE_PENIS,
	"INTERACTION_REQUIRE_VAGINA" = INTERACTION_REQUIRE_VAGINA,
	"INTERACTION_REQUIRE_BELLY" = INTERACTION_REQUIRE_BELLY
))

DEFINE_BITFIELD(vis_flags_inv, list(
	"HIDEACCESSORY" = HIDEACCESSORY,
	"HIDEEARS" = HIDEEARS,
	"HIDEEYES" = HIDEEYES,
	"HIDEFACE" = HIDEFACE,
	"HIDEFACIALHAIR" = HIDEFACIALHAIR,
	"HIDEGLOVES" = HIDEGLOVES,
	"HIDEHAIR" = HIDEHAIR,
	"HIDEJUMPSUIT" = HIDEJUMPSUIT,
	"HIDEMASK" = HIDEMASK,
	"HIDENECK" = HIDENECK,
	"HIDESHOES" = HIDESHOES,
	"HIDESNOUT" = HIDESNOUT,
	"HIDESUITSTORAGE" = HIDESUITSTORAGE,
	"HIDETAUR" = HIDETAUR,
	"HIDEUNDERWEAR" = HIDEUNDERWEAR,
	"HIDEWRISTS" = HIDEWRISTS,
))
