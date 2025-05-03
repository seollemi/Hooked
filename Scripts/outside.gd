extends Node2D


var cutscene_played := false
@onready var quest_hehe: Quest_hehe = $Quest_hehe
@onready var quest_hehe_p_2: Quest_hehe = $Quest_hehe_p2


func _ready() -> void:
	$Area2D/CollisionShape2D.disabled = false
	if quest_hehe.should_show_quest_ui():
		Qbox.get_node("Questbox").visible = true
	print("Loaded quest name: ", Global.current_quest_name)
	print("Loaded quest status: ", Global.quest_status)
	if Global.bridge_cutscene_done == true:
		$Cutscene_trigger/CollisionShape2D.disabled = true
	else:
		$Cutscene_trigger/CollisionShape2D.disabled = false
		
	if Global.act_1_done==true:
		$Area2D2/CollisionShape2D.disabled=true
		
	else:
		$Area2D2/CollisionShape2D.disabled=false
	Dialogic.connect("signal_event", Callable(self, "_on_dialogic_signal"))
func _process(delta: float) -> void:
	change_scene()

func _on_door_to_outsidehouse_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "outsidehouse"
		Global.transition_scene = true
		
		
func change_scene():
	if Global.transition_scene:
		match Global.next_scene:
			"outsidehouse":
				ChangeScene.change_scene_anim("res://Scenes/outsidehouse.tscn")
			"outside":
				ChangeScene.change_scene_anim("res://Scenes/bridge.tscn")
		Global.finish_changescenes()


func _on_cutscene_trigger_body_entered(body: Node2D) -> void:
	if Global.game_outside_loadin == true:
		if body is Player:
			$Player.can_move = false
			%AudioStreamPlayer2D.play()


		

func _on_audio_stream_player_2d_finished() -> void:
	if cutscene_played:
		return  # Prevent triggering it again
	
	cutscene_played = true  # Mark as played

	var phone_sequence_scene = preload("res://Scenes/Phone_sequence.tscn")
	var phone_sequence_instance = phone_sequence_scene.instantiate()

	# Get player camera position and offset
	var player_camera = $Player.get_node("Outside_camera")
	var camera_position = player_camera.global_position
	var offset = Vector2(50, -50)  # Adjust this as needed
	phone_sequence_instance.global_position = camera_position + offset
	phone_sequence_instance.sequence_finished.connect(_on_phone_sequence_finished)
	add_child(phone_sequence_instance)
	phone_sequence_instance.z_index = 100 
	
func _on_phone_sequence_finished():
	$Player.can_move = true
	Global.bridge_cutscene_done = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		ChangeScene.change_scene_anim("res://Scenes/officelobby.tscn")
		Global.teleport_back = true
		Global.player_PC_Location = Vector2(117, 314)
		if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe.reach_goal()
		
func _on_dialogue_ended(body: Player) -> void:
	body.can_move = true  # Re-enable movement

# Ensure your global script is autoloaded as "Global"
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is Player and not Global.npc_mark:
		
		body.can_move = false   # Disable player movement
		Dialogic.start("act1")
		# Connect to Dialogic's signal to re-enable movement after dialogue
		Dialogic.timeline_ended.connect(_on_dialogue_ended.bind(body))

			
func _on_dialogic_signal(event_name: String) -> void:
	if event_name in ["Q1", "Q2", "Q3", "Q4"]:
		_collect_question(event_name)

func _collect_question(question_name: String) -> void:
	if not question_name in Global.collected_questions:
		Global.collected_questions.append(question_name)
		print("✅ Collected:", question_name)

	if "Q1" in Global.collected_questions and \
	   "Q2" in Global.collected_questions and \
	   "Q3" in Global.collected_questions and \
	   "Q4" in Global.collected_questions:
		Global.introduction_mark = true
		$Area2D/CollisionShape2D.disabled = false  # ✅ Enable collision here
		if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe_p_2.reach_goal()
