extends Control
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$Label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	MusicManager.music.stream = preload("res://sounds/boss.mp3")
	MusicManager.music.play()
	
func _process(delta: float) -> void:
	pass


func _on_submit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/scrambledscene/scrambled.tscn")
