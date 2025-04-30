extends Control

@onready var back_button: TextureButton = $TextureButton

func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)
	set_process_input(true)
	process_mode = Node.PROCESS_MODE_ALWAYS  # ✅ Allows E input even when paused

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		_close_popup()

func _close_popup():
	queue_free()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://MiniGameTscn/Hints_page.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://MiniGameTscn/Hints_page.tscn")
