extends Control

@export var is_paused: bool = false:
	set(value):
		is_paused = value
		get_tree().paused = value
		visible = value

func _ready() -> void:
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not event.is_echo():
		is_paused = !is_paused

func _on_resume_pressed() -> void:
	is_paused = false

func _on_settings_pressed() -> void:
	# Handle settings logic here
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()
