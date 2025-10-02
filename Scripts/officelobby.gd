extends Node2D

@onready var interactable: Area2D = $interactable
@onready var infodesk: Area2D = $infodesk
@onready var player: Player = $Player
@onready var act_1: Area2D = $act1
@onready var minigame_done: Area2D = $minigame_done
@onready var quest_hehe: Quest_hehe = $Quest_hehe
@onready var act_2_quest: Quest_hehe = $"Act 2 quest"
@onready var move: Area2D = $move
@onready var act_done_scene = preload("res://Scenes/Act_done.tscn")
var global_alex = false
var triggered= false
var awaiting_act3_done := false
@onready var act_3_quest: Quest_hehe = $"Act 3 quest"
@onready var final_quest: Quest_hehe = $"Final quest"


func _ready() -> void:
	MusicManager.play_music("res://sounds/2_Day_1_Master.mp3", 2.5)

	# Restore quest UI if quest is active
	Qbox.get_node("Questbox").visible = false
		
	print(Global.act_1_done)
	
	print(Global.act_1_seen)
	if Global.act_1_done == true and Global.act_1_seen == false:
		var act_done_instance = act_done_scene.instantiate()
		add_child(act_done_instance)
		act_2_quest.start_quest()
		Global.act_1_seen = true
		
	#if quest_hehe.should_show_quest_ui():
	Qbox.get_node("Questbox").visible = false
	#if act_3_quest.should_show_quest_ui():
	Qbox.get_node("Questbox").visible = false
	Dialogic.timeline_ended.connect(_on_timeline_ended)  # Add this line
	Dialogic.signal_event.connect(_on_dialogic_signal)
	interactable.interact = _on_interact
	infodesk.interact = _on_interact1
	act_1.interact = _on_interact2
	Dialogic.timeline_ended.connect(_on_dialog_ended)
	

	#if Global.player_PC_Location != null:
		#var player = $Player  # Update the path to your Player node
		#if player:
			#player.position = Global.player_PC_Location
			
	$move/CollisionShape2D.disabled=true

	if Global.introduction_mark==true:
		$StarMarker.position = Vector2(752,523)
		
	if Global.introduction_1==true:
		$act1/CollisionShape2D.disabled=false
		$StarMarker.position = Vector2(600,352)
	else:
		$act1/CollisionShape2D.disabled=true
	
	if Global.act_1_done == true: 
		$act1/CollisionShape2D.disabled = true
		$StarMarker.position = Vector2(840,318)
		
	else:
		print("yello")
	if Global.minigame_done==true:
		$minigame_done/CollisionShape2D.disabled=false
	else:
		$minigame_done/CollisionShape2D.disabled=true
		
	if Global.act_3_done == true:
		
		$move/CollisionShape2D.disabled =false
		$interactable/CollisionShape2D.disabled=false
		$password/CollisionShape2D.disabled=false
		
	else:
		$interactable/CollisionShape2D.disabled=true
		$password/CollisionShape2D.disabled=true
		$move/CollisionShape2D.disabled =true
		



func start_dialog():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("password")
	MusicManager.music.stream_paused = true
	player.can_move = false	

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	$move/CollisionShape2D.disabled = false
	if awaiting_act3_done:
		awaiting_act3_done = false
		Global.act3minigame_done = true

		var act_done_instance = act_done_scene.instantiate()
		add_child(act_done_instance)
		
	else:
		# Existing timeline logic (like for password dialog)
		$move/CollisionShape2D.disabled = false
	
func _process(delta: float) -> void:
	change_scene()

#### FUNC FOR TRANSITION TO NEXT SCENE
func change_scene():
	if Global.transition_scene:
		match Global.next_scene:
			"outside":		
				ChangeScene.change_scene_anim("res://Scenes/bridge.tscn")
			"office":
				ChangeScene.change_scene_anim("res://Scenes/Office.tscn")
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
		if act_2_quest.quest_statuss == act_2_quest.QuestStatus.started:
			act_2_quest.reach_goal()
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
			Vector2(744, 338),
		] as Array[Vector2])
	else:
		Global.global_alex = true
		

func _on_interact1():
	Dialogic.start("attackers")
	var player = get_node("Player")
	player.set_can_move(false)
func _on_dialog_ended() -> void:
	var player = get_node("Player")  # Or get_tree().get_root().get_node("Path/To/Player")
	player.set_can_move(true)

func _on_interact2() -> void:
	if quest_hehe.should_show_quest_ui():
		Global.quest_status = quest_hehe.quest_statuss
		Global.current_quest_name = quest_hehe.quest_name
		Global.quest_description = quest_hehe.quest_descrip
		Qbox.get_node("Questbox").visible = false
	get_tree().change_scene_to_file("res://MiniGameTscn/multiplechoiceinstruction.tscn")
		
func _on_interact():
	if Global.act_3_done:
		if act_3_quest.quest_statuss == act_3_quest.QuestStatus.started:
			act_3_quest.reach_goal()
		if quest_hehe.should_show_quest_ui():
			Qbox.get_node("Questbox").visible = false
		Global.set_previous_scene("res://Scenes/officelobby.tscn", $Player.global_position)
		Global.next_scene = "computer"
		Global.transition_scene = true
	
func _on_area_2d_2_body_entered(body: Node2D) -> void:

	if not Global.global_triggered:
		Global.global_triggered = true
		
		

func _on_interactable_body_entered(body: Node2D) -> void:
	if Global.act_3_done == true :
		Global.previous_scene_path = get_tree().current_scene.scene_file_path
		get_tree().change_scene_to_file("res://Scenes/pc_game_password.tscn")
		

func _on_scene_to_bridge_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "bridge"
		Global.transition_scene = true
		Global.teleport_back = true
		Global.player_PC_Location = Vector2(194, 144)
####


func _on_move_body_entered(body: Node2D) -> void:
	pass


func _on_minigame_done_body_entered(body: Node2D) -> void:
	if body is Player and Global.minigame_done and not Global.act3minigame_done:
		if act_3_quest.quest_statuss == act_3_quest.QuestStatus.started:
			act_3_quest.finish_quest()
		MusicManager.music.play()
		Dialogic.start("ronnie_thanks")
		awaiting_act3_done = true
		
		var player = get_node("Player")
		player.set_can_move(false)
		final_quest.start_quest()


func _on_password_body_entered(body: Node2D) -> void:
	if body is Player and Global.act_3_done:
		body.cutscene_move([
			Vector2(630, 450),
			Vector2(631, 418),
			Vector2(616, 394)
		] as Array[Vector2])
		start_dialog()
		
func _on_dialogic_signal(event_name: String) -> void:
	if event_name == "done":
		MusicManager.play_music("res://sounds/2_Day_1_Master.mp3", 2.5)
		player.cutscene_move([
			Vector2(616, 394),
			Vector2(617, 359),
			Vector2(632, 356),
		] as Array[Vector2])


func _on_toggle_quest_button_pressed() -> void:
	var questbox_node = Qbox.get_node("Questbox")
	questbox_node.visible = not questbox_node.visible
