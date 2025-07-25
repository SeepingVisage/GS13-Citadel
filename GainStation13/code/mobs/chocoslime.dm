/mob/living/simple_animal/hostile/feed
	var/food_per_feeding = 5
	var/food_fed = /datum/reagent/consumable/nutriment

/mob/living/simple_animal/hostile/feed/CanAttack(atom/the_target)
	var/mob/living/carbon/target = the_target
	if(!istype(the_target)|| !check_target_prefs(target))
		return FALSE

	return ..()

/// Called when seeing if a target can be attacked. See if the target has the pref on and return accordingly.
/mob/living/simple_animal/hostile/proc/check_target_prefs(mob/living/carbon/target)
	if(!istype(target))
		return FALSE

	return target?.client?.prefs?.weight_gain_weapons

/mob/living/simple_animal/hostile/feed/AttackingTarget()
	. = ..()
	var/mob/living/carbon/L = target
	if(!istype(L) || !L.reagents || !L.is_mouth_covered(head_only = 1))
		return FALSE

	L.reagents.add_reagent(food_fed, food_per_feeding)

/mob/living/simple_animal/hostile/feed/chocolate_slime
	name = "Chocolate slime"
	desc = "It's a living blob of tasty chocolate!"
	icon = 'GainStation13/icons/mob/candymonster.dmi'
	icon_state = "a_c_slime"
	icon_living = "a_c_slime"
	icon_dead = "a_c_slime_dead"
	speak_emote = list("blorbles")
	emote_hear = list("blorbles")
	speak_chance = 5
	turns_per_move = 5
	see_in_dark = 10
	butcher_results = list(/obj/item/reagent_containers/food/snacks/chocolatebar = 4)
	maxHealth = 100
	health = 100
	obj_damage = 0
	melee_damage_lower = 0.001
	melee_damage_upper = 0.001
	faction = list("slime")
	pass_flags = PASSTABLE
	move_to_delay = 7
	attack_sound = 'sound/items/eatfood.ogg'
	unique_name = 1
	gold_core_spawnable = HOSTILE_SPAWN
	see_in_dark = 3
	blood_volume = 0
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	initial_language_holder = /datum/language_holder/slime
	vore_flags = DEVOURABLE | DIGESTABLE | FEEDING

//Creambeast - basically a bit tougher mob that has feeding ranged attacks
/mob/living/simple_animal/hostile/feed/chocolate_slime/creambeast
	name = "Creambeast"
	desc = "A strange mass of thick, creamy ice cream given some sense of instinct."
	icon_state = "icecream_monster"
	icon_living = "icecream_monster"
	icon_dead = "icecream_monster_dead"
	icon_gib = "icecream_monster_dead"
	move_to_delay = 10
	projectiletype = /obj/item/projectile/beam/fattening/icecream
	projectilesound = 'sound/weapons/pierce.ogg'
	ranged = 1
	ranged_message = "schlorps"
	ranged_cooldown_time = 30
	vision_range = 2
	speed = 3
	maxHealth = 100
	health = 100
	obj_damage = 0
	vision_range = 2
	aggro_vision_range = 9
	turns_per_move = 5
	blood_volume = 0
	gold_core_spawnable = HOSTILE_SPAWN
	butcher_results = list(/obj/item/reagent_containers/food/snacks/icecream = 4)

/obj/item/projectile/beam/fattening/icecream //might as well make use of this thing to not make ton of different variants of the same thing
	name = "ice cream blob"
	icon = 'GainStation13/icons/mob/candymonster.dmi'
	icon_state = "icecream_projectile"
	ricochets_max = 0
	ricochet_chance = 0
	hitsound = 'sound/weapons/tap.ogg'
	hitsound_wall = 'sound/weapons/tap.ogg'
	is_reflectable = FALSE
	light_range = 0
	var/food_per_feeding = 5
	var/food_fed = /datum/reagent/consumable/nutriment
	var/fullness_add = 30

/obj/item/projectile/beam/fattening/icecream/on_hit(atom/target, blocked)
	. = ..()
	var/mob/living/carbon/L = target
	if(!istype(L) || !L.reagents || L.is_mouth_covered(head_only = 1))
		return FALSE

	L.reagents.add_reagent(food_fed, food_per_feeding)
	if(HAS_TRAIT(L, TRAIT_VORACIOUS))
		fullness_add = fullness_add * 0.67
	L.fullness += (fullness_add)



//should probably put this in elsewhere or whatever, but for now it'll do

/mob/living/simple_animal/hostile/fatten/magehand
	name = "Magehand"
	desc = "It's a floating mage hand of strange, crackling orange energy..."
	icon = 'GainStation13/icons/mob/fathand.dmi'
	icon_state = "fathand"
	icon_living = "fathand"
	icon_dead = "fathand_dead"
	speak_emote = list("crackles")
	emote_hear = list("crackles")
	speak_chance = 5
	mob_biotypes = MOB_SPIRIT
	pressure_resistance = 9000
	turns_per_move = 5
	aggro_vision_range = 10
	see_in_dark = 10
	maxHealth = 20
	health = 20
	obj_damage = 0
	melee_damage_lower = 0.001
	melee_damage_upper = 0.001
	blood_volume = 0 //don't want it to bleed
	del_on_death = TRUE //it's an apparition, shouldn't have a body
	movement_type = FLYING
	attack_verb_continuous = "pokes"
	attack_verb_simple = "pokes"
	a_intent = INTENT_HARM
	pass_flags = PASSTABLE
	move_to_delay = 2 //very fast
	attack_sound = 'sound/weapons/pulse.ogg'
	unique_name = 1
	faction = list(ROLE_WIZARD)
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = INFINITY

/mob/living/simple_animal/hostile/fatten
	var/fat_per_hit = 30

/mob/living/simple_animal/hostile/fatten/AttackingTarget()
	. = ..()
	var/mob/living/carbon/L = target
	if(!istype(L))
		return FALSE

	L.adjust_fatness(fat_per_hit, FATTENING_TYPE_MAGIC)

/mob/living/simple_animal/hostile/fatten/CanAttack(atom/the_target)
	var/mob/living/carbon/target = the_target
	if(!istype(the_target)|| !check_target_prefs(target))
		return FALSE

	return ..()

/mob/living/simple_animal/hostile/fatten/check_target_prefs(mob/living/carbon/target)
	return target?.client?.prefs?.weight_gain_magic

/mob/living/simple_animal/hostile/feed/chocolate_slime/creambeast/cream_demon
	name = "Cream Demon"
	desc = "A strange mass of thick, creamy ice cream given some sense of instinct. This one seems better put together, as though it was sculpted by an artist, and it glows with a demonic power."
	move_to_delay = 7
	projectiletype = /obj/item/projectile/beam/fattening/icecream/strong
	ranged_cooldown_time = 20
	speed = 2.5
	maxHealth = 250
	health = 250
	vision_range = 7
	charger = 1
	charge_frequency = 10 SECONDS
	//galbanic attack
	/*var/maximum_reagent_storage = 10
	var/special_reagent_stored = 10
	var/special_reagent = /datum/reagent/fermi_fat
	var/special_feed_amount = 1
	var/normal_reagent = /datum/reagent/consumable/lipoifier
	var/normal_feed_amount = 5*/

/obj/item/projectile/beam/fattening/icecream/strong
	ricochets_max = 1
	ricochet_chance = 50
	food_fed = /datum/reagent/consumable/lipoifier
	food_per_feeding = 5
	fullness_add = 60
	fat_added = 0


//Turns your fat into permafat. Watch out!
/mob/living/simple_animal/hostile/feed/chocolate_slime/creambeast/cream_demon/AttackingTarget()
	. = ..()
	var/mob/living/carbon/L = target
	if(istype(L) && L.client?.prefs?.weight_gain_permanent)
		if(L.fatness_real > 10)
			L.fatness_real = L.fatness_real - 10
			L.fatness_perma += 1
			to_chat(target, "<span class='notice'>You feel yourself getting.. smaller?</span>")
		else
			L.adjustToxLoss(5, 0)
			to_chat(target, "<span class='userdanger'>You've run out of fat to burn! Your organs feel on fire!</span>")

/mob/living/simple_animal/hostile/feed/chocolate_slime/creambeast/cream_demon/attack_hand(mob/living/user, act_intent = user.a_intent)
	. = ..()
	if (ishuman(user) && user.has_dna() && act_intent == "help")
		if(user.cursed_fat)
			to_chat(user, "<span class='notice'>You've already received the blessing of this demon. If you want more, you'll have to exhaust the blessing first.</span>")
		else
			user.cursed_fat = 1
			user.fattening_steps_left += 200
			to_chat(user, "<span class='notice'>As you embrace the creature, a warmth passes you as it passes onto you its cursed blessing. You feel a strange, warm sensation inside, growing stronger the more you move...</span>")

/mob/living/simple_animal/hostile/feed/chocolate_slime/creambeast/cream_demon/PickTarget(list/Targets)
	if(target != null)//If we already have a target, but are told to pick again, calculate the lowest distance between all possible, and pick from the lowest distance targets
		for(var/pos_targ in Targets)
			var/atom/A = pos_targ
			to_chat(A, "<span class='notice'>you've been put up for picking!!</span>")
			var/target_dist = get_dist(targets_from, target)
			var/possible_target_distance = get_dist(targets_from, A)
			if(target_dist < possible_target_distance)
				Targets -= A
			var/mob/living/fatty = A
			if(istype(fatty) && fatty.cursed_fat)
				to_chat(A, "<span class='notice'>you've been spared due to your awesome fattiness</span>")
				Targets -= A
	if(!Targets.len)//We didnt find nothin!
		return
	var/chosen_target = pick(Targets)//Pick the remaining targets (if any) at random
	return chosen_target
