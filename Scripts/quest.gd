class_name Quest_hehe extends QuestManager

func _ready():
	await get_tree().process_frame
	update_quest_ui()

func start_quest() -> void:
	if quest_statuss == QuestStatus.available:
		quest_statuss = QuestStatus.started
		Global.quest_status = quest_statuss
		Global.current_quest_name = quest_name  # Important for loading
		Global.quest_description = quest_descrip
		update_quest_ui()

func reach_goal() -> void:
	if quest_statuss == QuestStatus.started:
		quest_statuss = QuestStatus.reach_goal
		Global.quest_status = quest_statuss
		Global.quest_description = reached_goal_text
		update_quest_ui()
		
func finish_quest() -> void:
	if quest_statuss == QuestStatus.reach_goal:
		quest_statuss = QuestStatus.finished
		Global.quest_status = quest_statuss
		update_quest_ui()


static func should_show_quest_ui() -> bool:
	# Only show if quest is started or reach_goal (not available/finished)
	return Global.quest_status in [QuestStatus.started, QuestStatus.reach_goal]

func update_quest_ui():
	quest_title.text = Global.current_quest_name
	quest_description.text = Global.quest_description
	QuestBox.visible = should_show_quest_ui() 
