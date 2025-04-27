extends Node2D

@export var password_scene : PackedScene

func create_password():
	var password_instance = password_scene.instantiate()
	add_child(password_instance)
	password_instance.global_position = Vector2(300, 200) # You can set a better position
	return password_instance
