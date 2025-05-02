extends Control

@export var is_paused: bool = false:
	set(value):
		is_paused = value
		get_tree().paused = value
		visible = value

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not event.is_echo():
		is_paused = !is_paused

func _on_resume_pressed() -> void:
	is_paused = false

func _on_settings_pressed() -> void:
	visible = false

	var volume_scene = preload("res://MiniGameTscn/pause_volume.tscn")
	var volume_instance = volume_scene.instantiate()
	volume_instance.name = "PauseVolume"
	volume_instance.process_mode = Node.PROCESS_MODE_ALWAYS
	volume_instance.set("pause_menu_ref", self)

	get_parent().add_child(volume_instance)
	volume_instance.visible = true  # ✅ Make it visible only now

func _on_quit_pressed() -> void:
	is_paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _on_save_pressed() -> void:
	pass  # Implement saving if needed
