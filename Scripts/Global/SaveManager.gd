extends Node


var next_player_position: Vector2
var load_requested := false

func load_game():
	var data = ResourceLoader.load("user://Player_save.tres") as SceneData
	if data:
		next_player_position = data.player_position
		load_requested = true
		Global.game_first_loadin = data.game_first_loadin
		Global.current_scene = data.current_scene
		Global.game_outside_loadin = data.game_outside_loadin
		
		Global.teleport_back = data.teleport_back
		Global.dialog_pc_opened = data.dialog_pc_opened
		Global.pc_start_opened = data.pc_start_opened
		Global.mail_open_opened = data.mail_open_opened
		Global.fakelogin_open_opened = data.fakelogin_open_opened
		Global.gate_cutscene_done = data.gate_cutscene_done
		Global.bridge_cutscene_done = data.bridge_cutscene_done
		
		Global.previous_scene_path = data.previous_scene_path
		Global.info_desk = data.info_desk

		Global.mini_game_enable = data.mini_game_enable
		Global.collected_questions = data.collected_questions
		Global.introduction_1 = data.introduction_1
		Global.act_1_done = data.act_1_done
		Global.act_2_done = data.act_2_done
		Global.act_3_done = data.act_3_done
		Global.act2_cutscene_done = data.act2_cutscene_done
		Global.minigame_done = data.minigame_done

		Global.collected_hint_ids = data.collected_hint_ids
		Global.collected_hints = data.collected_hints
		Global.hints_read = data.hints_read
		Global.player_points = data.player_points
		Global.chosen_password_number = data.chosen_password_number
		Global.has_faded_in = data.has_faded_in
		Global.mini_level_1 = data.mini_level_1
		Global.mini_level_2 = data.mini_level_2
		Global.mini_level_3 = data.mini_level_3
		Global.show_button_after_hint = data.show_button_after_hint
		Global.last_hint_opened = data.last_hint_opened

		Global.npc_event_done = data.npc_event_done
		Global.npc_evnt2_done = data.npc_evnt2_done
		Global.npc_mark = data.npc_mark

		Global.quest_status = data.quest_statuss
		Global.quest_stage_index = data.current_quest_stage
		Global.quest_description = data.current_quest_name
		Global.current_quest_name = data.current_quest_title
		
		
		get_tree().change_scene_to_file(data.current_scene_path)
	else:
		print("No saved data found or failed to load!")
