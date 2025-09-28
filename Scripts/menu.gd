extends Control

@onready var conf: ConfirmationModal = $Confirmation/ConfirmationModal


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		conf.customize(
		"Are you sure?",
		"Any unsaved progress will be lost.",
		"Confirm",
		"Cancel"
	)
		var is_confirmed = await conf.prompt(true)
	
		if is_confirmed:
			get_tree().quit()
			SaveManager.save_settings()
			
func _ready() -> void:

	$NinePatchRect/Settings/Master.value = Global.master_volume
	$NinePatchRect/Settings/MusicVolSlider.value = Global.music_volume
	$NinePatchRect/Settings/SFXVolSlider.value = Global.sfx_volume
	
	Global.apply_audio_settings()
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
	SaveManager.load_game()
	#MusicManager.music.stream = preload("res://sounds/2_Day_1_Master.mp3")
	#MusicManager.music.play()

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	$MarginContainer/Main_buttons.visible = true
	$NinePatchRect.visible = false


func _on_master_value_changed(value: float) -> void:
	Global.master_volume = value
	Global.apply_audio_settings()


func _on_music_vol_slider_value_changed(value: float) -> void:
	Global.music_volume = value
	Global.apply_audio_settings()


func _on_sfx_vol_slider_value_changed(value: float) -> void:
	Global.sfx_volume = value
	Global.apply_audio_settings()
