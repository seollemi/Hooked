extends Control

@onready var start: TextureButton = $CanvasLayer/Start
@onready var hints: TextureButton = $CanvasLayer/Hints
@onready var quit: TextureButton = $CanvasLayer/Quit
@onready var objective: TextureButton = $CanvasLayer/objective

var music_node_path: NodePath = "/root/MusicPlayer"  # 🛠 Global path for music

func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	hints.pressed.connect(_on_hints_pressed)
	quit.pressed.connect(_on_quit_pressed)
	objective.pressed.connect(_on_objective_pressed)
	
	if not has_node(music_node_path):
		var music = AudioStreamPlayer2D.new()
		music.name = "MusicPlayer"
		music.stream = preload("res://sounds/3_Night_1_Master.mp3")
		music.set_as_top_level(true)
		music.autoplay = true
		get_tree().root.call_deferred("add_child", music)
	else:
		# Music already exists
		pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://MiniGameTscn/level_selector.tscn")

func _on_hints_pressed() -> void:
	get_tree().change_scene_to_file("res://MiniGameTscn/Hints_page.tscn")

func _on_quit_pressed() -> void:
	Global.scrolling_background.visible = false
	if get_tree().root.has_node("MusicPlayer"):
		var music = get_tree().root.get_node("MusicPlayer")
		music.stop()
		music.queue_free()
	get_tree().change_scene_to_file("res://Scenes/Office.tscn")

func _on_objective_pressed() -> void:
	get_tree().change_scene_to_file("res://MiniGameTscn/objective_menu.tscn")
