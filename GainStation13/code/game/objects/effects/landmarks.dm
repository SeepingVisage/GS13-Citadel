/obj/effect/landmark/stationroom/box/bar
	templates = list("Bar Default" = 3, "Bar Griller" = 3, "Bar Gambler" = 3, "Bar Botany" = 3)
	icon = 'icons/rooms/box/engine.dmi'

/obj/effect/landmark/stationroom/box/bar/New()
	. = ..()
	templates = CONFIG_GET(keyed_list/box_random_bar)

/datum/config_entry/keyed_list/box_random_bar
	key_mode = KEY_MODE_TEXT
	value_mode = VALUE_MODE_NUM
	lowercase_key = FALSE
	splitter = ","

/datum/map_template/ruin/station/box/bar
	id = "bar_default"
	suffix = "Box/Bar/bar_default.dmm"
	name = "Box Default"

/datum/map_template/ruin/station/box/bar/gambler
	id = "bar_gambler"
	suffix = "Box/Bar/bar_gambler.dmm"
	name = "Box Googley"

/datum/map_template/ruin/station/box/bar/griller
	id = "bar_griller"
	suffix = "Box/Bar/bar_griller.dmm"
	name = "Box Griller"

/datum/map_template/ruin/station/box/bar/botany
	id = "bar_botany"
	suffix = "Box/Bar/bar_botany.dmm"
	name = "Box Botany"

/obj/effect/spawner/lootdrop/arcadeboards
	name = "random arcade spawner"
	lootcount = 2
	lootdoubles = FALSE
	loot = list(/obj/item/circuitboard/computer/arcade/orion_trail = 5,
		/obj/item/circuitboard/computer/arcade/battle = 4,
		/obj/item/circuitboard/computer/arcade/amputation = 1)
