extends Control

func _ready() -> void:
	# Load and play menu music once
	if not MusicManager.music.playing:
		MusicManager.music.stream = preload("res://sounds/1_Menu_Master.mp3")  # Replace with your file
		MusicManager.music.play()

func _on_play_pressed() -> void:
	ChangeScene.change_scene_anim("res://opening INtro/IntroOpening.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Options_Menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_continue_pressed() -> void:
	SaveManager.load_game()
	MusicManager.music.stream = preload("res://sounds/2_Day_1_Master.mp3")
	MusicManager.music.play()
