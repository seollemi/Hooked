extends Control

@onready var level1_button: TextureButton = $CanvasLayer/Level1
@onready var level2_button: TextureButton = $CanvasLayer/Level2
@onready var level3_button: TextureButton = $CanvasLayer/Level3
@onready var quit_button: TextureButton = $CanvasLayer/Quit

func _ready() -> void:
	level1_button.pressed.connect(_on_level1_pressed)
	level2_button.pressed.connect(_on_level2_pressed)
	level3_button.pressed.connect(_on_level3_pressed)
	quit_button.pressed.connect(_on_Quit_pressed)

	# 🛠 Level 2 unlocks if 3 or more hints
	if Global.collected_hints < 3:
		level2_button.disabled = true
	else:
		level2_button.disabled = false

	# 🛠 Level 3 unlocks if 9 or more hints
	if Global.collected_hints < 9:
		level3_button.disabled = true
	else:
		level3_button.disabled = false

func _on_level1_pressed() -> void:
	if get_tree().root.has_node("MusicPlayer"):
		var music = get_tree().root.get_node("MusicPlayer")
		music.stop()
		music.queue_free()

	get_tree().change_scene_to_file("res://MiniGameTscn/mini_game_1.tscn")

func _on_level2_pressed() -> void:
	if Global.collected_hints >= 3:
		if get_tree().root.has_node("MusicPlayer"):
			var music = get_tree().root.get_node("MusicPlayer")
			music.stop()
			music.queue_free()

		get_tree().change_scene_to_file("res://MiniGameTscn/mini_game_2.tscn")
	else:
		print("⛔ You need at least 3 hints to unlock Level 2!")

func _on_level3_pressed() -> void:
	if Global.collected_hints >= 9:
		if get_tree().root.has_node("MusicPlayer"):
			var music = get_tree().root.get_node("MusicPlayer")
			music.stop()
			music.queue_free()

		get_tree().change_scene_to_file("res://MiniGameTscn/mini_game_3.tscn")
	else:
		print("⛔ You need at least 9 hints to unlock Level 3!")

func _on_Quit_pressed() -> void:
	get_tree().change_scene_to_file("res://MiniGameTscn/MiniMenu.tscn")
