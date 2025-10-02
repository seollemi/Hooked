extends Node2D

@onready var quest_hehe: Quest_hehe = $Quest_hehe
@onready var interactable: Area2D = $interactable

		

func _ready() -> void:

	interactable.interact = _on_interact
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.timeline_ended.connect(_on_dialog_ended)
	#if quest_hehe.should_show_quest_ui():
	Qbox.get_node("Questbox").visible = false


func _on_interact() -> void:
	var player = get_node("Player")
	player.set_can_move(false)
	Dialogic.start("Chapter_1_training")
	
func _on_dialog_ended() -> void:
	var player = get_node("Player")
	player.set_can_move(true)

func _on_dialogic_signal(event_name: String) -> void:
	if event_name in ["Q_1", "Q_2", "Q_3", "Q_4"]:
		_collect_question(event_name)

func _collect_question(question_name: String) -> void:
	if not question_name in Global.collected_questions:
		Global.collected_questions.append(question_name)
		print("✅ Collected:", question_name)

	if "Q_1" in Global.collected_questions and \
	   "Q_2" in Global.collected_questions and \
	   "Q_3" in Global.collected_questions and \
	   "Q_4" in Global.collected_questions:
		Global.introduction_1 = true
		$StarMarker.visible = false
		if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe.reach_goal()
		print("🎉 All questions answered! Introduction_1 is now TRUE.")


func _process(delta: float) -> void:
	change_scene()
	

func change_scene():		
	if Global.transition_scene:
		match Global.next_scene:
			"officelobby":
				ChangeScene.change_scene_anim("res://Scenes/officelobby.tscn")
		Global.finish_changescenes()
		
		
func _on_scene_to_office_body_entered(body: Node2D) -> void:
	if body is Player:
		
		Global.teleport_back = true
		Global.next_scene = "officelobby"
		Global.transition_scene = true
		Global.player_PC_Location = Vector2(751, 507)
			
			


func _on_toggle_quest_button_pressed() -> void:
	var questbox_node = Qbox.get_node("Questbox")
	questbox_node.visible = not questbox_node.visible
