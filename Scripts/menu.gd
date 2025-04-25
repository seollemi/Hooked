extends Control



func _on_play_pressed() -> void:
	ChangeScene.change_scene_anim("res://opening INtro/IntroOpening.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Options_Menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
