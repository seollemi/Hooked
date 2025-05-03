extends Control

@onready var email_button: TextureButton = $TextureButton


func _ready() -> void:
	email_button.pressed.connect(_on_TextureButton_pressed)

func _process(delta: float) -> void:
	pass


func _on_TextureButton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/password_instruction.tscn")
