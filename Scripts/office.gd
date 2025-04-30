extends Node2D
@onready var player: Player = $Player
@onready var interactable: Area2D = $interactable
var arg : String = "" 

func _ready() -> void:
	interactable.interact = _on_interact
	$act2_cutscene/CollisionShape2D.disabled = true
	$act2_intro/CollisionShape2D.disabled = true
	if Global.act_1_done == true:
		$act2_intro/CollisionShape2D.disabled = false

func _process(delta: float) -> void:
	change_scene()
	pass

func _on_interact():
	Global.next_scene = "computer"
	Global.transition_scene = true
	Global.player_PC_Location
func start_dialog():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("Malware_discussion")
	player.can_move = false	
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	$act2_cutscene/CollisionShape2D.disabled = false

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

# This method is triggered when the player enters the area leading to the office
func _on_door_to_office_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "officelobby"
		Global.transition_scene = true

# This method is triggered when the player enters the area and triggers the cutscene
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is Player and not Global.gate_cutscene_done:
		Global.gate_cutscene_done = true
		body.cutscene_move([
			Vector2(224, 68),
			Vector2(223, 91),
			Vector2(358, 91)
		] as Array[Vector2])

func _on_act_2_intro_body_entered(body: Node2D) -> void:
	start_dialog()  # Start the dialogue

func _on_act_2_cutscene_body_entered(body: Node2D) -> void:
	if body is Player:
		body.cutscene_move([
			Vector2(416, 92),
			Vector2(375, 88),
			Vector2(375, 22),
			Vector2(451, 22)
		] as Array[Vector2])

func _on_dialogic_signal(event_name: String) -> void:
	if event_name == "Game_enable":
		Global.mini_game_enable = true
		print("✅ Mini-game is now enabled!")
