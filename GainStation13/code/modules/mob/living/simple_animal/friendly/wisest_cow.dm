/mob/living/simple_animal/cow/wisdom/wisest
	name = "Vernn"
	desc = "The wisest of the wisdom cows, proudly kept by the Research Director as an appreciation of it's vast knowledge"
	speak_chance = 13 // I will make it lower once I give it the sci headset. Don't want the scientists going insane...

/mob/living/simple_animal/cow/wisdom/wisest/Initialize(mapload)
	. = ..()
	speak.Add("Prefer pushing from pulling", "Prefer pulling from pushing", "Do not ask the administration on how to utilize the self-pleasuring device", "Unwrenching a pipe with high pressure, will send you flying beyond measure", "Remember to tailor your hardsuit", "Beware the long-eared menace", "IT'S FUCKING FUUUUSIIIIING!!", "The all-consuming dark mass shall consume your workplace shortly", "Clowns and Engineers don't mix, and yet they are one and the same", "You will be shot in the back by a dragon dressed in blue")