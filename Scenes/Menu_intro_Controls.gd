extends Control

@onready var continue_button: TextureButton = $ContinueButton

func _ready() -> void:
	continue_button.pressed.connect(_on_continue_pressed)
	Global.scrolling_background.visible = false
	continue_button.visible = false  # Start hidden
	await get_tree().create_timer(4.0).timeout
	continue_button.visible = true  # Show after 4 seconds
func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/WorldHouse.tscn")
