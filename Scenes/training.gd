extends Node2D


@onready var interactable: Area2D = $interactable

func _ready() -> void:

	interactable.interact = _on_interact
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_interact() -> void:
	Dialogic.start("Chapter_1_training")
	


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
		Global.player_PC_Location = Vector2(466, 311)  # Example position
		Global.next_scene = "officelobby"
		Global.transition_scene = true
