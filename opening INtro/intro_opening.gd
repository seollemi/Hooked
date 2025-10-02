extends Node2D

@onready var college_sprite = $Sprite2D_College
@onready var house_sprite = $Sprite2D_House
@onready var guard_sprite = $Sprite2D_Guard
@onready var fade = $ColorRect
@onready var anim = $AnimationPlayer
@onready var cam = $Camera2D


func fade_out_voice(duration: float = 1.5):
	if Dialogic.Voice.is_running():
		var tween = get_tree().create_tween()
		tween.tween_method(Dialogic.Voice.set_volume, 0.0, -80.0, duration)
		await tween.finished
		Dialogic.Voice.stop_audio()

			
func _ready():
	await run_intro_sequence()

func run_intro_sequence() -> void:
	# Setup
	college_sprite.visible = true
	house_sprite.visible = false
	guard_sprite.visible = false
	fade.modulate.a = 1.0
	cam.enabled = true

	### COLLEGE
	anim.play("fade_in")
	await anim.animation_finished

	Dialogic.start("CollegeDialogue")
	await Dialogic.timeline_ended
	
	await fade_out_voice(0.5)
	anim.play("fade_out")
	await anim.animation_finished

	### HOUSE
	college_sprite.visible = false
	house_sprite.visible = true
	
	anim.play("fade_in")
	await anim.animation_finished

	Dialogic.start("HouseDialogue")
	await Dialogic.timeline_ended
	
	await fade_out_voice(0.5)
	anim.play("fade_out")
	await anim.animation_finished

	### GUARD
	house_sprite.visible = false
	guard_sprite.visible = true

	anim.play("fade_in")
	await anim.animation_finished

	var tween = get_tree().create_tween()
	var start_position = cam.position
	var end_position = start_position + Vector2(0, -980)
	tween.tween_property(cam, "position", end_position, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished

	Dialogic.start("GuardDialogue")
	await Dialogic.timeline_ended

	# ✅ Final fade out
	await fade_out_voice(0.5)
	anim.play("fade_out")
	await anim.animation_finished
	
	var tween1 = get_tree().create_tween()
	tween1.tween_property(MusicManager.music, "volume_db", -80, 2.0)  
	await tween1.finished
	MusicManager.music.stop()

	# ✅ Scene change to WorldHouse
	get_tree().change_scene_to_file("res://Scenes/Intro_Controls.tscn")
