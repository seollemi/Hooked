extends Node2D
@onready var quest_hehe: Quest_hehe = $Quest_hehe
@onready var player: Player = $Player

@onready var conf: ConfirmationModal = $Confirmation/ConfirmationModal
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		conf.customize(
		"Are you sure?",
		"Any unsaved progress will be lost.",
		"Confirm",
		"Cancel"
	)
		var is_confirmed = await conf.prompt(true)
	
		if is_confirmed:
			get_tree().quit()
			SaveManager.save_settings()
		

func _ready() -> void:
	
	print(Global.current_scene)
	
	MusicManager.play_music("res://sounds/2_Day_1_Master.mp3", 2.5)
	
	#if quest_hehe.should_show_quest_ui():
	Qbox.get_node("Questbox").visible = false
	if Global.quest_status != quest_hehe.QuestStatus.available:
		$Quest_hehe.update_quest_ui()
			
func _process(delta: float) -> void:
	change_scene()
	

func _on_door_inside_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "WorldHouse"
		Global.transition_scene = true

func _on_door_to_city_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "outside"
		Global.transition_scene = true
		
		if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe.reach_goal()

func change_scene():
	if Global.transition_scene:
		match Global.next_scene:
			"WorldHouse":
				ChangeScene.change_scene_anim("res://Scenes/WorldHouse.tscn")
			"outside":
				ChangeScene.change_scene_anim("res://Scenes/bridge.tscn")
		Global.finish_changescenes()


func _on_toggle_quest_button_pressed() -> void:
	var questbox_node = Qbox.get_node("Questbox")
	questbox_node.visible = not questbox_node.visible
