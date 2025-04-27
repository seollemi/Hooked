extends Control

var dialog_started := false
@onready var restoring_label = $TextureRect/black/anim_text
@onready var bad_end = $TextureRect/red/bad_end
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.timeline_ended.connect(_on_dialogic_end)
	if not dialog_started:
		dialog_started = true
		Dialogic.start("Act_2")
		%AudioStreamPlayer2D.play()

func _on_dialogic_signal(argument: String) -> void:
	match argument:
		"wna":
			$TextureRect/Sprite2D2.visible = false
			$TextureRect/Sprite2D.visible = true
		"shut":
			$TextureRect/Sprite2D.visible = false
			$TextureRect/black.visible = true
		"wrong_choice":
			%AudioStreamPlayer2D.stop()
			%bad_end.play()
			$TextureRect/red.visible = true
			bad_end.start_restore_typing()
		"right_choice":
			%AudioStreamPlayer2D.stop()
			%good_end.play()
			restoring_label.start_restore_typing()
		"Replay":
			Dialogic.start("Act_2")
			$TextureRect/red.visible = false
			%AudioStreamPlayer2D.play()

func _on_dialogic_end():
	ChangeScene.change_scene_anim("res://Scenes/Office.tscn")

 
