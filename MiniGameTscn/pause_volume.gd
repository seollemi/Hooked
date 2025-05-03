extends Control

var pause_menu_ref: Control = null  # 🔁 Receive the pause menu node

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false  # Or just delete this line entirely — it's added visible later

func _on_quit_to_main_menu_pressed() -> void:
	if pause_menu_ref:
		pause_menu_ref.visible = true  # 🔁 Show PauseMenu again
	queue_free()  # ✅ Remove PauseVolume
	
func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("pause") and not event.is_echo():
		get_viewport().set_input_as_handled()  # 🔒 Prevent pause/escape while open
