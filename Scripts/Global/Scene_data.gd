extends Resource
class_name SceneData

@export var player_position: Vector2
@export var current_scene_path: String
@export var game_first_loadin: bool
@export var current_scene: String
@export	var game_outside_loadin = true


@export var teleport_back := false
@export var dialog_pc_opened := false # ano to it only happen 1 time permanently even across scene reloads
@export var pc_start_opened: bool = false  # interact once only happen 1 time permanently even across scene reloads
@export var mail_open_opened: bool = false  # interact once only happen 1 time permanently even across scene reloads 
@export var fakelogin_open_opened: bool = false
@export var gate_cutscene_done: bool = false
@export var bridge_cutscene_done: bool = false


#passwordgame to officelobby
@export var previous_scene_path: String = ""
@export var info_desk= false

#EVENT SCENES TO SWITCH ACTS
@export var mini_game_enable: bool = false
@export var collected_questions: Array = []
@export var introduction_1: bool = false
@export var act_1_done: bool = false
@export var act_2_done: bool = false
@export var act_3_done:bool = false
@export var act2_cutscene_done := false
@export var minigame_done:bool = false
@export var act_1_seen = false
@export var act_2_seen = false
@export var act_3_seen = false

#MINI GAME_Password_Global
@export var collected_hint_ids: Array = []
@export var collected_hints: int = 0 # Start at zero
@export var hints_read: int = 0  # counts how many hints have been opened
@export var player_points: int = 0
@export var chosen_password_number: int = 1  # default 1 = Andrew
@export var has_faded_in: bool = true
@export var mini_level_1: bool = false
@export var mini_level_2: bool = false
@export var mini_level_3: bool = false
@export var show_button_after_hint := false
@export var last_hint_opened := 0

#NPC GLOBAL ONE TIME USED
@export var npc_event_done: bool = false
@export var npc_evnt2_done: bool = false
@export var npc_mark:bool = false
@export var introduction_mark: bool = false

# Quest-related data
@export var quest_statuss: int
@export var current_quest_name: String
@export var current_quest_title: String
@export var current_quest_stage: int
