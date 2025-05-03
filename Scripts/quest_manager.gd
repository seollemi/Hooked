class_name QuestManager extends Node2D

@onready var QuestBox: CanvasLayer = Qbox.get_node('Questbox')
@onready var quest_title: RichTextLabel = Qbox.get_node('Questbox').get_node('QuestTitle')
@onready var quest_description: RichTextLabel = Qbox.get_node('Questbox').get_node('QuestDescription')


@export_group("Quest Settings")
@export var quest_name: String
@export var quest_descrip: String
@export var reached_goal_text: String


enum QuestStatus{
	available,
	started,
	reach_goal,
	finished,	
}

@export var quest_statuss: QuestStatus = QuestStatus.available
