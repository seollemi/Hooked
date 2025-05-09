extends CharacterBody2D


@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var act_2_quest: Quest_hehe = $"Act 2 quest"
@onready var act_2_quest_p2: Quest_hehe = $"Act 2 quest2"

var talking: bool = false
var dialog_started: bool = false
var waiting_for_player: bool = false
var dialog_was_interrupted: bool = false

func _ready():
	if not Dialogic.signal_event.is_connected(_on_dialogic_signal_event):
		Dialogic.signal_event.connect(_on_dialogic_signal_event)


func start_dialog():
	talking = true
	dialog_started = true
	print("🕒 Waiting before starting conversation...")

	await get_tree().create_timer(1).timeout  # Small delay if you want
	
	if not dialog_was_interrupted:  # Only start dialog if not interrupted
		print("🗣️ NPC: Starting conversation...")
		Dialogic.start("Npc_act2")

func _on_dialogic_signal_event(event_name: String) -> void:
	if event_name == "Finished_dialogic_1":
		print("✅ NPC finished Act 1 talking.")
		talking = false
		waiting_for_player = true  # Now wait for player

		if Dialogic.signal_event.is_connected(_on_dialogic_signal_event):
			Dialogic.signal_event.disconnect(_on_dialogic_signal_event)

func _on_act_2_body_entered(body: Node2D) -> void:
	if body is Player and not Global.npc_evnt2_done and not Global.act_2_done:
		print("👀 Player entered! Interrupting if necessary and starting Act 2...")

		Global.npc_evnt2_done = true  # ✅ mark event as done
		# If NPC is still talking, stop the dialog
		if talking:
			dialog_was_interrupted = true
			talking = false
			Dialogic.end_timeline()
		if act_2_quest_p2.quest_statuss == act_2_quest_p2.QuestStatus.started:
			act_2_quest_p2.reach_goal()
		if act_2_quest.should_show_quest_ui():
			Qbox.get_node("Questbox").visible = true	
		ChangeScene.change_scene_anim("res://Scenes/Act2_story.tscn")
