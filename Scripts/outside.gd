extends Node2D




func _ready() -> void:
	print(Global.current_scene)
	if Global.game_outside_loadin == false:
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
			await get_tree().create_timer(0.2).timeout
			Dialogic.start("phone_seq0")
			Dialogic.timeline_ended.connect(end_dialog)
		
func end_dialog():
		%AudioStreamPlayer2D.play()

func _on_audio_stream_player_2d_finished() -> void:
	ChangeScene.change_scene_anim("res://Scenes/Phone_sequence.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	ChangeScene.change_scene_anim("res://Scenes/Office.tscn")
