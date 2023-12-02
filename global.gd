extends Node


var player_current_attack = false

var current_scene = "field"
var transition_scene = false
var is_boss_defeated = false

var player_exit_cliffside_posx = 555
var player_exit_cliffside_posy = 121
var player_start_posx = 58
var player_start_posy = 313

var boss_health_pool = 500
var game_first_loadin = true
var is_boss_defeated2
var is_boss_defeated3

var player_health = 500

func finish_changing_scenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "field":
			current_scene = "lab"
		elif current_scene == "lab":
			current_scene = "hub"
		elif current_scene == "hub":
			current_scene = "hub"
		elif current_scene == "holder_one":
			current_scene = "plato"
		elif current_scene == "gallery":
			current_scene = "gallery"
		elif current_scene == "plato":
			current_scene = "plato_boss"
		elif current_scene == "plato_boss" && is_boss_defeated == true:
			current_scene = "jade"
		elif current_scene == "jade":
			current_scene = "statue_boss"
		elif current_scene == "statue_boss" && is_boss_defeated2 == true:
			current_scene = "material"
		elif current_scene == "material":
			current_scene = "nuke_boss"
		elif current_scene == "nuke_boss" && is_boss_defeated3 == true:
			current_scene = "victory"
		else:
			current_scene = "field"
