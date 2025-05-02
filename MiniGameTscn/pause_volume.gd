extends Control

var pause_menu_ref: Control = null  # 🔁 Receive the pause menu node

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false  # Or just delete this line entirely — it's added visible later

func _on_quit_to_main_menu_pressed() -> void:
	if pause_menu_ref:
		pause_menu_ref.visible = true  # 🔁 Show PauseMenu again
	queue_free()  # ✅ Remove PauseVolume
