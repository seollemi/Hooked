extends Node2D
@onready var quest_hehe: Quest_hehe = $Quest_hehe

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
		if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe.reach_goal()

func change_scene():
	if Global.transition_scene:
		match Global.next_scene:
			"WorldHouse":
				ChangeScene.change_scene_anim("res://Scenes/WorldHouse.tscn")
			"outside":
				ChangeScene.change_scene_anim("res://Scenes/bridge.tscn")
		Global.finish_changescenes()
