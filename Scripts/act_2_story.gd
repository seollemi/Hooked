extends Control

var dialog_started := false

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if not dialog_started:
		dialog_started = true
		Dialogic.start("Act 2")
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
		"right_choice":
			%AudioStreamPlayer2D.stop()
			%good_end.play()
		"Replay":
			Dialogic.start("Act 2")
			%AudioStreamPlayer2D.play()



 
