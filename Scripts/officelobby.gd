extends Node2D

@onready var interactable: Area2D = $interactable
@onready var infodesk: Area2D = $infodesk
@onready var player: Player = $Player
@onready var act_1: Area2D = $act1
@onready var minigame_done: Area2D = $minigame_done
@onready var quest_hehe: Quest_hehe = $Quest_hehe
@onready var act_2_quest: Quest_hehe = $"Act 2 quest"

@onready var act_done_scene = preload("res://Scenes/Act_done.tscn")
var global_alex = false
var triggered= false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact
	infodesk.interact = _on_interact1
	act_1.interact = _on_interact2
	if Global.introduction_1 == true:
		$StarMarker.position = Vector2(601,367)
	if Global.player_PC_Location != null:
		var player = $Player  # Update the path to your Player node
		if player:
			player.position = Global.player_PC_Location
			
	$move/CollisionShape2D.disabled=true
	if (Global.act_1_done and not Global.act_1_seen):
		var act_done_instance = act_done_scene.instantiate()
		add_child(act_done_instance)
	
	if Global.introduction_1==true:
		$act1/CollisionShape2D.disabled=false
		$StarMarker.position = Vector2(840,322)
	else:
		$act1/CollisionShape2D.disabled=true
	
	if Global.act_1_done==true:
		act_2_quest.start_quest()
		
		$minigame_done/CollisionShape2D.disabled=false
	else:
		$minigame_done/CollisionShape2D.disabled=true
	
	if Global.minigame_done==true:
		$minigame_done/CollisionShape2D.disabled=false
	else:
		$minigame_done/CollisionShape2D.disabled=true
	if Global.act_3_done== true:
		$Area2D2/CollisionShape2D.disabled =false
		$move/CollisionShape2D.disabled =false
		$interactable/CollisionShape2D.disabled=false
		
	else:
		$interactable/CollisionShape2D.disabled=true
		$Area2D2/CollisionShape2D.disabled =true
		$move/CollisionShape2D.disabled =true


func start_dialog():
	
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("password")
	player.can_move = false	
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	$move/CollisionShape2D.disabled = false
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()

#### FUNC FOR TRANSITION TO NEXT SCENE
func change_scene():
	if Global.transition_scene:
		match Global.next_scene:
			"outside":		
				ChangeScene.change_scene_anim("res://Scenes/bridge.tscn")
			"office":
				ChangeScene.change_scene_anim("res://Scenes/office.tscn")
			"computer":
				ChangeScene.change_scene_anim("res://Scenes/pc_game_password.tscn")
			"training":
				ChangeScene.change_scene_anim("res://Scenes/training.tscn")
			"bridge":
				ChangeScene.change_scene_anim("res://Scenes/bridge.tscn")
		Global.finish_changescenes()

#### FUNC FOR TRANSITION TO NEXT SCENE
func _on_door_to_office_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "office"
		Global.transition_scene = true

func _on_scene_to_training_body_entered(body: Node2D) -> void:
	if body is Player:
		if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe.reach_goal()
		Global.next_scene = "training"
		Global.transition_scene = true
####




func _on_area_2d_body_entered(body: Node2D) -> void:
	if not Global.act_1_done and body is Player:

		
		
		Dialogic.start("instruction_alex")
		body.cutscene_move([
			Vector2(477, 113),
		] as Array[Vector2])
	else:
		Global.global_alex = true

		
func _on_interact1():
	Dialogic.start("attackers")
	

func _on_interact2() -> void:
	if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe.reach_goal()
			quest_hehe.QuestStatus.reach_goal
			quest_hehe.finish_quest()
	get_tree().change_scene_to_file("res://Scenes/scrambledscene/scrambled.tscn")
		
func _on_interact():
	if Global.act_3_done:
		Global.set_previous_scene("res://Scenes/officelobby.tscn", $Player.global_position)
		Global.next_scene = "computer"
		Global.transition_scene = true
	
func _on_area_2d_2_body_entered(body: Node2D) -> void:

	

		
	if not Global.global_triggered:
		Global.global_triggered = true
		
		
	if body is Player and Global.act_3_done:
		body.cutscene_move([
			Vector2(346, 206),
		] as Array[Vector2])
		start_dialog()

func _on_interactable_body_entered(body: Node2D) -> void:
	if Global.act_3_done == true :
		Global.previous_scene_path = get_tree().current_scene.scene_file_path
		get_tree().change_scene_to_file("res://Scenes/pc_game_password.tscn")
		

	


func _on_scene_to_bridge_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "bridge"
		Global.transition_scene = true
####


func _on_move_body_entered(body: Node2D) -> void:
	if body is Player and Global.act_3_done:
		body.cutscene_move([
			Vector2(317, 208),
			Vector2(319, 137),
			Vector2(346, 135),
	])


func _on_minigame_done_body_entered(body: Node2D) -> void:
	if body is Player and Global.minigame_done:
		Dialogic.start("ronnie_thanks")
