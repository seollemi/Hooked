extends Node2D

func _ready() -> void:
	if Global.game_first_loadin == true:
		$Player.position.x = Global.player_start_posx
		$Player.position.y = Global.player_start_posy
	else: 
		$Player.position.x = Global.player_enter_house_posx
		$Player.position.y = Global.player_enter_house_posy
	print(Global.current_scene)
func _process(delta: float) -> void:
	change_scene()


func _on_door_outside_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "outsidehouse"
		Global.transition_scene = true

func change_scene():
	if Global.transition_scene:
		if Global.next_scene == "outsidehouse":
			ChangeScene.change_scene_anim("res://Scenes/outsidehouse.tscn")
			Global.game_first_loadin = false
			Global.finish_changescenes()
