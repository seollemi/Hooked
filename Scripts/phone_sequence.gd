extends Node2D

signal sequence_finished
func _ready() -> void:
	$Node2D/Camera2D.enabled = true  # Activate this camera
	%AnimationPlayer.play("phone_Seq#1")
	

func start_intro_dialog():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("phone_seq1")
	%AnimationPlayer.pause()

func _on_dialogic_signal(argument: String) -> void:
	if argument == "pause_here1":
		%AnimationPlayer.play()
	

#func resume_dialog():
	#Dialogic.start("phone_seq0")
	#%AnimationPlayer.pause()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Global.game_outside_loadin = false
	Global.bridge_cutscene_done = true
	emit_signal("sequence_finished")
	queue_free()
	#ChangeScene.change_scene_anim("res://Scenes/bridge.tscn")
