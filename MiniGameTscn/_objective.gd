extends Control

@onready var continue_button: TextureButton = $ContinueButton

func _ready() -> void:
	continue_button.pressed.connect(_on_continue_pressed)
	Global.scrolling_background.visible = false
func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://MiniGameTscn/mini_game_1.tscn")
