extends Node2D
@onready var interactable: Area2D = $interactable
@onready var player: Player = $Player
@onready var act_done_scene = preload("res://Scenes/Act_done.tscn")
@onready var act_2_quest: Quest_hehe = $"Act 2 quest"
@onready var act_2_quest_p2: Quest_hehe = $"Act 2 quest2"
@onready var act_3_quest: Quest_hehe = $"Act 3 quest"



		
func _ready() -> void:
	MusicManager.play_music("res://sounds/2_Day_1_Master.mp3", 2.5)
	$act_2/CollisionShape2D.disabled = true
	$act2_cutscene/CollisionShape2D.disabled = true
	$act2_intro/CollisionShape2D.disabled = true
	interactable.interact = _on_interact
	
	if not Global.act_2_done:
		$interactable/CollisionShape2D.disabled = true
		
	#if act_2_quest.should_show_quest_ui():
	Qbox.get_node("Questbox").visible = false
	#if act_3_quest.should_show_quest_ui():
	#Qbox.get_node("Questbox").visible = false
	if not Dialogic.signal_event.is_connected(_on_dialogic_signal):
		Dialogic.signal_event.connect(_on_dialogic_signal)
		print("🔌 Dialogic signal_event connected!")
	if Global.act_2_done == true and Global.act_2_seen == false:
		var act_done_instance = act_done_scene.instantiate()
		add_child(act_done_instance)
		$interactable/CollisionShape2D.disabled = false


func _process(delta: float) -> void:
	change_scene()
	
	
func _on_interact():
	if act_2_quest.quest_statuss == act_2_quest.QuestStatus.started:
			act_2_quest.reach_goal()
			act_2_quest.QuestStatus.reach_goal
			act_2_quest.finish_quest()
	Global.next_scene = "computer"
	Global.transition_scene = true

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

# ✅ Trigger dialog when player enters
func _on_act_2_intro_body_entered(body: Node2D) -> void:
	if body is Player and not Global.act_2_done:
		player.can_move = false  
		Dialogic.start("Malware_discussion")
		$act2_intro/CollisionShape2D.disabled = false
		$act2_cutscene/CollisionShape2D.disabled = false
		$interactable/CollisionShape2D.disabled = false
		
		
		
func _on_dialogic_signal(event_name: String) -> void:
	print("📨 Received signal:", event_name)

	if event_name == "Game_enable":
		Global.mini_game_enable = true
		print("✅ Mini-game is now enabled!")

	if event_name == "act2_intro_done" and not Global.act_2_done:
		print("🎬 act2_intro_done signal received — starting cutscene movement.")
		$act_2/CollisionShape2D.disabled = false
		$interactable/CollisionShape2D.disabled = false
		
		

		player.can_move = false
		player.cutscene_move([
			Vector2(660, 289),
			Vector2(660, 216),
			Vector2(682, 216),
			Vector2(682, 207),
			Vector2(733, 207)
		] as Array[Vector2])
		
		
	
		await get_tree().create_timer(4.0).timeout
	if event_name == "act_1_done":
		Global.act_2_done = true
		Global.act_2_cut_done = true

	if Global.act_2_cut_done == true and Global.act_2_seen == false:
		var act_done_instance = act_done_scene.instantiate()
		add_child(act_done_instance)
		act_3_quest.start_quest()
		


	else:
		print("🛑 Skipping cutscene move — Act 2 is already done.")
		$act2_intro/CollisionShape2D.disabled = false
		player.can_move = true


# ✅ Scene transitions
func _on_door_to_office_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "officelobby"
		Global.transition_scene = true
		Global.teleport_back = true
		Global.player_PC_Location = Vector2(813, 327)

# ✅ Another area-triggered cutscene
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is Player and not Global.gate_cutscene_done:
		Global.gate_cutscene_done = true 
		player.can_move = false
		body.cutscene_move([
			Vector2(532, 269),
			Vector2(532, 300),
			Vector2(645, 297)
		]as Array[Vector2])
		
		
		
		

func _run_cutscene(path: Array[Vector2]) -> void:
	print("🎬 Cutscene moving through points:", path)


func _on_toggle_quest_button_pressed() -> void:
	var questbox_node = Qbox.get_node("Questbox")
	questbox_node.visible = not questbox_node.visible
