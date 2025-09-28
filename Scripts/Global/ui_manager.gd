extends CanvasLayer

@onready var save_modal: SaveModal = $SaveModal

func show_save_confirmation(message: String = "Game saved successfully!", duration: float = 3.0) -> void:
	save_modal.get_node("NinePatchRect/MarginContainer/VBoxContainer/Label").text = message
	save_modal.show()
	if duration > 0:
		await get_tree().create_timer(duration).timeout
		if save_modal.visible:
			save_modal.hide()


func show_load_error(message: String = "No save file found.", duration: float = 3.0) -> void:
	save_modal.get_node("NinePatchRect/MarginContainer/VBoxContainer/Label").text = message
	save_modal.show()

	if duration > 0:
		await get_tree().create_timer(duration).timeout
		if save_modal.visible:
			save_modal.hide()



func _on_save_modal_ok_pressed() -> void:
	save_modal.hide()
