extends Node2D

func _ready() -> void:
	print(Global.current_scene)	

func _process(delta: float) -> void:
	change_scene()

func _on_door_inside_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "WorldHouse"
		Global.transition_scene = true

func _on_door_to_city_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "outside"
		Global.transition_scene = true

func change_scene():
	if Global.transition_scene:
		match Global.next_scene:
			"WorldHouse":
				ChangeScene.change_scene_anim("res://Scenes/WorldHouse.tscn")
			"outside":
				ChangeScene.change_scene_anim("res://Scenes/outside.tscn")
		Global.finish_changescenes()
