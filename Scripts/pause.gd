extends Control

@export var player: Player

@export var is_paused: bool = false:
	set(value):
		is_paused = value
		get_tree().paused = value
		visible = value

func _ready() -> void:
	
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	$NinePatchRect/Settings/Master.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$NinePatchRect/Settings/MusicVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("MUSIC")))
	$NinePatchRect/Settings/SFXVolSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not event.is_echo():
		is_paused = !is_paused

func _on_resume_pressed() -> void:
	is_paused = false

func _on_quit_pressed() -> void:
	pass
func _on_save_pressed() -> void:
	SaveManager.save_game()
	
	
func _on_options_pressed() -> void:
	$MarginContainer/Main_buttons.visible = false
	$NinePatchRect.visible = true


func _on_main_menu_pressed() -> void:
	quit_dialog_automatic.canvas_layer.visible = true
	quit_dialog_automatic.customize(
		"Are you sure?",
		"Any unsaved progress will be lost.",
		"Confirm",
		"Cancel"
	)
	var is_confirmed = await quit_dialog_automatic.prompt(true)
	
	# Always hide after user decides
	quit_dialog_automatic.canvas_layer.visible = false
	
	if is_confirmed:
		is_paused = false
		Qbox.get_node("Questbox").visible = false
		if Dialogic.current_timeline != null:
			Dialogic.end_timeline()
			
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
		MusicManager.music.stream = preload("res://sounds/1_Menu_Master.mp3")
		MusicManager.music.play()

	
	
func _on_back_pressed() -> void:
	$MarginContainer/Main_buttons.visible = true
	$NinePatchRect.visible = false
	


func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"),value)


func _on_music_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("MUSIC"),value)


func _on_sfx_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"),value)
