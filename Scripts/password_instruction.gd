extends Control
@onready var label_2: Label = $Label2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label2.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$Label2.vertical_alignment = VERTICAL_ALIGNMENT_CENTER


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/emailcomp.tscn")
