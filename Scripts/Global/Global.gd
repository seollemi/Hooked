extends Node

var current_scene = "WorldHouse"
var next_scene = ""  # NEW: Store target scene name
var transition_scene = false
var last_player_position: Vector2 = Vector2.ZERO
var outside_scene : PackedScene = null

#passwordgame to officelobby
var previous_scene_path: String = ""
var info_desk= false
var player_PC1_Location = Vector2(230.0, -78.0)
func set_previous_scene(scene_path: String, player_location: Vector2):
	previous_scene_path = scene_path
	player_PC1_Location = player_location
	
#player locations when entering world
var player_enter_house_posx = -149.0
var player_enter_house_posy = -21.0
var player_start_posx = -16.0
var player_start_posy = -120.0

#player loc when entering bridge/main city
var player_bridge_posx = 917.0
var player_brigde_posy = -248.0

var player_bridgecutscene_posx = 497.0
var player_bridgecutscene_posy = -248.0


#PLAYER EVENT MOVEMENT
var player_PC_Location = Vector2(463.0, 76.0)
var teleport_back := false
var dialog_pc_opened := false # ano to it only happen 1 time permanently even across scene reloads
var pc_start_opened: bool = false  # interact once only happen 1 time permanently even across scene reloads
var mail_open_opened: bool = false  # interact once only happen 1 time permanently even across scene reloads 
var fakelogin_open_opened: bool = false
var gate_cutscene_done: bool = false
var bridge_cutscene_done: bool = false


#EVENT SCENES TO SWITCH ACTS
var mini_game_enable: bool = false
var collected_questions: Array = []
var introduction_1: bool = false
var act_1_done: bool = false



 # Start at zero
var global_triggered = false
var global_alex = false


#####global dialogics
var dialogue_played: bool = false

#MINI GAME_Password_Global
var collected_hint_ids: Array = []
var collected_hints: int = 0 # Start at zero
var hints_read: int = 0  # counts how many hints have been opened
var scrolling_background: Node2D = null
var player_points: int = 0
var chosen_password_number: int = 1  # default 1 = Andrew
var has_faded_in: bool = false

func add_points(points_to_add: int) -> void:
	player_points += points_to_add
	print("⭐ Points Added: ", points_to_add, " | Total Points: ", player_points)

func reset_points_only() -> void:
	player_points = 0
#NPC MOVEMENT
var NPC_Office_location = Vector2(463.0, 76.0)

#NPC GLOBAL ONE TIME USED
var npc_event_done: bool = false
var npc_evnt2_done: bool = false
var npc_mark:bool = false

var game_first_loadin = true
var game_outside_loadin = true
func finish_changescenes():
	if transition_scene:
		transition_scene = false
		current_scene = next_scene
		next_scene = ""  # Reset after transition
