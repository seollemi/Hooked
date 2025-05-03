extends Node2D


@onready var interactable: Area2D = $interactable
@onready var quest_hehe: Quest_hehe = $Quest_hehe
@onready var interactable_end_: Area2D = $"interactable_End'"

func _ready() -> void:
	interactable_end_.interact = _on_interact1
	interactable.interact = _on_interact
	if quest_hehe.should_show_quest_ui():
		Qbox.get_node("Questbox").visible = true
		
	if Global.quest_status != quest_hehe.QuestStatus.available:
		$Quest_hehe.update_quest_ui()
	if not Dialogic.signal_event.is_connected(_on_dialogic_signal):
		Dialogic.signal_event.connect(_on_dialogic_signal)
	if Global.game_first_loadin == true:
		$Player.position.x = Global.player_start_posx
		$Player.position.y = Global.player_start_posy
		start_dialog()
	else: 
		$Player.position.x = Global.player_enter_house_posx
		$Player.position.y = Global.player_enter_house_posy
		
func _process(delta: float) -> void:
	change_scene()
 
	if Global.act_3_done==true:
		$"interactable_End'"/CollisionShape2D.disabled=false
	else:
		$"interactable_End'"/CollisionShape2D.disabled=true

func start_dialog():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("House_dialog")
	$Door_outside/CollisionShape2D.disabled = true
	$interactable/CollisionShape2D.disabled = true
	

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	quest_hehe.start_quest()
	$Door_outside/CollisionShape2D.disabled = false
	$interactable/CollisionShape2D.disabled = false


#func _on_door_outside_body_entered(body: Node2D) -> void:
	#if body is Player:
		#Global.next_scene = "outsidehouse"
		#Global.transition_scene = true

func _on_interact():
		Global.next_scene = "outsidehouse"
		Global.transition_scene = true
		quest_hehe.reach_goal()

func change_scene():
	if Global.transition_scene:
		if Global.next_scene == "outsidehouse":
			ChangeScene.change_scene_anim("res://Scenes/outsidehouse.tscn")
			Global.game_first_loadin = false
			Global.finish_changescenes()
	


func _on_interact1():
	Dialogic.start("THE END")

func _on_dialogic_signal(End: String) -> void:
	print("📨 Received signal:", End)

	if Global.act_3_done == true:
		get_tree().change_scene_to_file("res://Scenes/Ending_mini_game/Ending.tscn")
		print("✅ Mini-game is now enabled!")
