extends Control

@onready var back_button: TextureButton = $TextureButton2

func _ready() -> void:
	Global.scrolling_background.visible = true
	back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://MiniGameTscn/Hints_page.tscn")
