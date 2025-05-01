class_name Quest_hehe extends QuestManager

func start_quest() -> void:
	if quest_statuss == QuestStatus.available:
		quest_statuss = QuestStatus.started
		
		QuestBox.visible = true
		quest_title.text = quest_name
		quest_description.bbcode_enabled = true
		current_stage_index = 0

		if quest_stages.size() > 0:
			quest_description.text = quest_stages[current_stage_index]


func reach_goal() -> void:
	if quest_statuss == QuestStatus.started and current_stage_index < quest_stages.size() - 1:
		var old_text = quest_description.text
		current_stage_index += 1
		var new_text = quest_stages[current_stage_index]
		
		# Strike through the previous and add the new one
		var updated_text = "[s]" + old_text + "[/s]\n" + new_text
		quest_description.text = updated_text

		# If it's the last stage, change status
		if current_stage_index == quest_stages.size() - 1:
			quest_statuss = QuestStatus.reach_goal

		
		
func finish_quest() -> void:
	if quest_statuss == QuestStatus.reach_goal:
		quest_statuss = QuestStatus.finished
		QuestBox.visible = false
