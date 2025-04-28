extends Node2D

@onready var interactable: Area2D = $interactable

func _ready() -> void:
	interactable.interact = _on_interact
	Dialogic.signal_event.connect(_on_dialogic_signal_event)  # Listen for Dialogic events

func _on_interact() -> void:
	Dialogic.start("Chapter_1_training")

func _on_dialogic_signal_event(event_name: String, value):
	if event_name == "dialogic_end":
		_collect_questions()
		
func _process(delta: float) -> void:
	change_scene()
	
func change_scene():
	if Global.transition_scene:
		match Global.next_scene:
			"officelobby":
				ChangeScene.change_scene_anim("res://Scenes/officelobby.tscn")
		Global.finish_changescenes()

func _collect_questions() -> void:
	var q1 = Dialogic.Variables.get_variable("Q_1")
	var q2 = Dialogic.Variables.get_variable("Q_2")
	var q3 = Dialogic.Variables.get_variable("Q_3")
	var q4 = Dialogic.Variables.get_variable("Q_4")

	Global.collected_questions = [q1, q2, q3, q4]

	if q1 and q2 and q3 and q4:
		Global.introduction_1 = true
		print("✅ All questions collected! Introduction_1 is now true.")
	else:
		print("⚠️ Some questions not completed yet.")


func _on_scene_to_office_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "officelobby"
		Global.transition_scene = true
