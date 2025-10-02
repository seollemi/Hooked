extends Control

@export var next_scene_path: String = "res://Scenes/EndingScene.tscn"
@export var wait_time: float = 5.0

func _ready() -> void:
	await get_tree().create_timer(wait_time).timeout
	get_tree().change_scene_to_file(next_scene_path)
