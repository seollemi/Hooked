extends Node2D


@onready var interactable: Area2D = $interactable

func _ready() -> void:
	interactable.interact = _on_interact
	#$Marker/AnimationPlayer.play("marker")
	
	
func _process(delta: float) -> void:
	change_scene()
func _on_interact():
		Global.next_scene = "computer"
		Global.transition_scene = true
		Global.player_PC_Location
		
func change_scene():
	if Global.transition_scene:
		match Global.next_scene:
			"outside":
				ChangeScene.change_scene_anim("res://Scenes/bridge.tscn")
			"officelobby":
				ChangeScene.change_scene_anim("res://Scenes/officelobby.tscn")
			"computer":
				ChangeScene.change_scene_anim("res://Scenes/PC_Game.tscn")
		Global.finish_changescenes()
		


func _on_door_to_office_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "officelobby"
		Global.transition_scene = true
		




func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is Player and not Global.gate_cutscene_done:  # ✅ Only if not yet done
		Global.gate_cutscene_done = true  # ✅ Mark as done
		body.cutscene_move([
			Vector2(224, 68),
			Vector2(223, 91),
			Vector2(358, 91)
		] as Array[Vector2])


func _on_act_2_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
