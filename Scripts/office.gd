extends Node2D


@onready var interactable: Area2D = $interactable

func _ready() -> void:
	interactable.interact = _on_interact
	$Marker/AnimationPlayer.play("marker")
func _process(delta: float) -> void:
	change_scene()

func _on_interact():
		Global.next_scene = "computer"
		Global.transition_scene = true
	
func change_scene():
	if Global.transition_scene:
		if Global.next_scene == "computer":
			ChangeScene.change_scene_anim("res://Scenes/outsidehouse.tscn")
			Global.game_first_loadin = false
			Global.finish_changescenes()
