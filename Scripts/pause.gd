extends Control

@export var player: Player

@export var is_paused: bool = false:
	set(value):
		is_paused = value
		get_tree().paused = value
		visible = value

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not event.is_echo():
		is_paused = !is_paused

func _on_resume_pressed() -> void:
	is_paused = false

func _on_settings_pressed() -> void:
	visible = false

	var volume_scene = preload("res://MiniGameTscn/pause_volume.tscn")
	var volume_instance = volume_scene.instantiate()
	volume_instance.name = "PauseVolume"
	volume_instance.process_mode = Node.PROCESS_MODE_ALWAYS
	volume_instance.set("pause_menu_ref", self)

	get_parent().add_child(volume_instance)
	volume_instance.visible = true  # ✅ Make it visible only now

func _on_quit_pressed() -> void:
	is_paused = false
	Qbox.get_node("Questbox").visible = false
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _on_save_pressed() -> void:
	var data = SceneData.new()
	data.player_position = Global.player.global_position
	data.current_scene_path = get_tree().current_scene.scene_file_path 
	data.game_first_loadin = Global.game_first_loadin
	data.current_scene = Global.current_scene

		# One-time interactions
	data.teleport_back = Global.teleport_back
	data.dialog_pc_opened = Global.dialog_pc_opened
	data.pc_start_opened = Global.pc_start_opened
	data.mail_open_opened = Global.mail_open_opened
	data.fakelogin_open_opened = Global.fakelogin_open_opened
	data.gate_cutscene_done = Global.gate_cutscene_done
	data.bridge_cutscene_done = Global.bridge_cutscene_done
	
	# Scene transitions and flags
	data.previous_scene_path = Global.previous_scene_path
	data.info_desk = Global.info_desk
	
	# Event/Act transitions
	data.mini_game_enable = Global.mini_game_enable
	data.collected_questions = Global.collected_questions
	data.introduction_1 = Global.introduction_1
	data.act_1_done = Global.act_1_done
	data.act_2_done = Global.act_2_done
	data.act_3_done = Global.act_3_done
	data.act2_cutscene_done = Global.act2_cutscene_done
	data.minigame_done = Global.minigame_done
	data.act_1_seen = Global.act_1_seen
	data.act_2_seen = Global.act_2_seen
	data.act_3_seen = Global.act_3_seen
	# Minigame related
	data.collected_hint_ids = Global.collected_hint_ids
	data.collected_hints = Global.collected_hints
	data.hints_read = Global.hints_read
	data.player_points = Global.player_points
	data.chosen_password_number = Global.chosen_password_number
	data.has_faded_in = Global.has_faded_in
	data.mini_level_1 = Global.mini_level_1
	data.mini_level_2 = Global.mini_level_2
	data.mini_level_3 = Global.mini_level_3
	data.show_button_after_hint = Global.show_button_after_hint
	data.last_hint_opened = Global.last_hint_opened
	
	# NPC events
	data.npc_event_done = Global.npc_event_done
	data.npc_evnt2_done = Global.npc_evnt2_done
	data.npc_mark = Global.npc_mark



	data.quest_statuss = int(Global.quest_status)
	data.current_quest_stage = Global.quest_stage_index
	data.current_quest_name = Global.quest_description
	data.current_quest_title = Global.current_quest_name

	
	ResourceSaver.save(data, "user://Player_save.tres")
	print("Saved game!")

	
