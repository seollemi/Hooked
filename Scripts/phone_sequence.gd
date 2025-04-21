extends Node2D

func _ready() -> void:
	%AnimationPlayer.play("phone_Seq#1")
	

func start_intro_dialog():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("phone_seq1")
	%AnimationPlayer.pause()

func _on_dialogic_signal(argument: String) -> void:
	if argument == "pause_here":
		%AnimationPlayer.play()
	elif argument == "pause_here1":
		%AnimationPlayer.play()
	

func resume_dialog():
	Dialogic.start("phone_seq2")
	%AnimationPlayer.pause()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Global.game_outside_loadin = false
	ChangeScene.change_scene_anim("res://Scenes/outside_v1.tscn")
