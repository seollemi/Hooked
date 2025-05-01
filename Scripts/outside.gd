extends Node2D


var cutscene_played := false
@onready var quest_hehe: Quest_hehe = $Quest_hehe


func _ready() -> void:
	print(Global.current_scene)
	if Global.bridge_cutscene_done == true:
		$Cutscene_trigger/CollisionShape2D.disabled = true
	else:
		$Cutscene_trigger/CollisionShape2D.disabled = false
		
		
	

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
		if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe.reach_goal()
		
func _on_dialogue_ended(body: Player) -> void:
	body.can_move = true  # Re-enable movement

# Ensure your global script is autoloaded as "Global"
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is Player and not Global.npc_mark:
		Global.npc_mark = true
		body.can_move = false   # Disable player movement
		Dialogic.start("act1")
		
		# Connect to Dialogic's signal to re-enable movement after dialogue
		Dialogic.timeline_ended.connect(_on_dialogue_ended.bind(body))
