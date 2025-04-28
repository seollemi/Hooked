extends Node2D

@export var password_scene : PackedScene

func create_password():
	var password_instance = password_scene.instantiate()
	add_child(password_instance)
	password_instance.global_position = get_viewport().size / 2
	return password_instance
