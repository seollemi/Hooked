extends Control

func _ready() -> void:
	# Load and play menu music once
	$NinePatchRect/Settings/Master.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$NinePatchRect/Settings/MusicVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("MUSIC")))
	$NinePatchRect/Settings/SFXVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	if not MusicManager.music.playing:
		MusicManager.music.stream = preload("res://sounds/1_Menu_Master.mp3")  # Replace with your file
		MusicManager.music.play()

func _on_play_pressed() -> void:
	ChangeScene.change_scene_anim("res://opening INtro/IntroOpening.tscn")
	Global.reset()
func _on_options_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/Options_Menu.tscn")
	$MarginContainer/Main_buttons.visible = false
	$NinePatchRect.visible = true

func _on_continue_pressed() -> void:
	var success = SaveManager.load_game()  # make this return true if load worked
	
	if success:
		# Only play music if save data exists
		MusicManager.music.stream = preload("res://sounds/2_Day_1_Master.mp3")
		MusicManager.music.play()
	else:
		# Optional: give feedback if no save found
		print("No save found, skipping music.")

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	$MarginContainer/Main_buttons.visible = true
	$NinePatchRect.visible = false


func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"),value)


func _on_music_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("MUSIC"),value)


func _on_sfx_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"),value)
