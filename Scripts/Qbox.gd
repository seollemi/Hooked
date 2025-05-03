extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func hide_quest_ui() -> void:
	if has_node("Questbox"):
		get_node("Questbox").visible = false
