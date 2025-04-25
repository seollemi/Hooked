extends Node

var current_scene = "WorldHouse"
var next_scene = ""  # NEW: Store target scene name
var transition_scene = false

var outside_scene : PackedScene = null

var player_enter_house_posx = -149.0
var player_enter_house_posy = -21.0
var player_start_posx = -16.0
var player_start_posy = -120.0

var game_first_loadin = true
var game_outside_loadin = true
func finish_changescenes():
	if transition_scene:
		transition_scene = false
		current_scene = next_scene
		next_scene = ""  # Reset after transition
