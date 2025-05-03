extends Node2D

@onready var college_sprite = $Sprite2D_College
@onready var house_sprite = $Sprite2D_House
@onready var guard_sprite = $Sprite2D_Guard
@onready var fade = $ColorRect
@onready var anim = $AnimationPlayer
@onready var cam = $Camera2D

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

	anim.play("fade_out")
	await anim.animation_finished

	### HOUSE
	college_sprite.visible = false
	house_sprite.visible = true

	anim.play("fade_in")
	await anim.animation_finished

	Dialogic.start("HouseDialogue")
	await Dialogic.timeline_ended

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
	anim.play("fade_out")
	await anim.animation_finished
	
	var tween1 = get_tree().create_tween()
	tween1.tween_property(MusicManager.music, "volume_db", -80, 2.0)  
	await tween1.finished
	MusicManager.music.stop()

	# ✅ Scene change to WorldHouse
	get_tree().change_scene_to_file("res://Scenes/Intro_Controls.tscn")
