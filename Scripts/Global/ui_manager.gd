extends CanvasLayer

func show_save_confirmation():
	$SaveConfirmDialog.dialog_text = "Game saved successfully!"
	$SaveConfirmDialog.popup_centered()

func show_load_error():
	$LoadErrorDialog.dialog_text = "Failed to load game! No save file found."
	$LoadErrorDialog.popup_centered()


func _on_button_pressed() -> void:
	pass # Replace with function body.
