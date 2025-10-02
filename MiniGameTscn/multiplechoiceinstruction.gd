extends Control
@onready var label: Label = $Label
@onready var submit_button: Button = $SubmitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$Label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	MusicManager.music.stream = preload("res://sounds/boss.mp3")
	MusicManager.music.play()

	submit_button.pressed.connect(_on_submit_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_submit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://MiniGameTscn/multiplechoice.tscn")
