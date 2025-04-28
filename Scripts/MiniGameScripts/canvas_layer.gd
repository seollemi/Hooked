extends CanvasLayer

@onready var hint_1: TextureButton = $Hint1
@onready var hint_2: TextureButton = $Hint2
@onready var hint_3: TextureButton = $Hint3
@onready var hint_4: TextureButton = $Hint4
@onready var hint_5: TextureButton = $Hint5
@onready var hint_6: TextureButton = $Hint6
@onready var proceed_button: TextureButton = $TextureButton
@onready var quit: TextureButton = $Quit
@onready var hack_time_label: RichTextLabel = $HackTimeEstimate
@onready var current_password_label: RichTextLabel = $CurrentPassword

func _ready() -> void:
	_update_password_display()
	Global.scrolling_background.visible = true
	_update_hint_unlock()
	
	quit.pressed.connect(_on_quit_pressed)
	hint_1.pressed.connect(_on_hint1_pressed)
	hint_2.pressed.connect(_on_hint2_pressed)
	hint_3.pressed.connect(_on_hint3_pressed)
	hint_4.pressed.connect(_on_hint4_pressed)
	hint_5.pressed.connect(_on_hint5_pressed)
	hint_6.pressed.connect(_on_hint6_pressed)
	proceed_button.pressed.connect(_on_proceed_button_pressed)
	
	proceed_button.disabled = false  # ✅ ENABLED for testing (block by code later)

func _update_password_display() -> void:
	if is_instance_valid(current_password_label) and is_instance_valid(hack_time_label):
		print("✅ Updating password display:")
		print("Password number from Global: ", Global.chosen_password_number)

		match Global.chosen_password_number:
			1:
				current_password_label.text = "drew"
				hack_time_label.text = "59 seconds"
			2:
				current_password_label.text = "Youabian"
				hack_time_label.text = "58 minutes"
			3:
				current_password_label.text = "NextPassword"
				hack_time_label.text = "minutes"
			_:
				current_password_label.text = "Unknown"
				hack_time_label.text = "Hackable in: ???"
	else:
		print("⚠️ Warning: Password or HackTime label missing!")

func _update_hint_unlock() -> void:
	hint_1.set_locked(Global.collected_hints < 1)
	hint_2.set_locked(Global.collected_hints < 2)
	hint_3.set_locked(Global.collected_hints < 3)
	hint_4.set_locked(Global.collected_hints < 4)
	hint_5.set_locked(Global.collected_hints < 5)
	hint_6.set_locked(Global.collected_hints < 6)

func _on_hint1_pressed() -> void:
	Global.hints_read += 1
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_1.tscn")

func _on_hint2_pressed() -> void:
	Global.hints_read += 1
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_2.tscn")

func _on_hint3_pressed() -> void:
	Global.hints_read += 1
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_3.tscn")

func _on_hint4_pressed() -> void:
	Global.hints_read += 1
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_4.tscn")

func _on_hint5_pressed() -> void:
	Global.hints_read += 1
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_5.tscn")

func _on_hint6_pressed() -> void:
	Global.hints_read += 1
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_6.tscn")

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://MiniGameTscn/MiniMenu.tscn")

func _on_proceed_button_pressed() -> void:
	if Global.hints_read == 3:
		print("✅ Proceeding to Password Upgrade!")
		get_tree().change_scene_to_file("res://MiniGameTscn/passwordupgrade.tscn")
	elif Global.hints_read == 6:
		print("✅ Proceeding to Second Password Upgrade!")
		get_tree().change_scene_to_file("res://MiniGameTscn/passwordupgrade2.tscn")
	elif Global.hints_read == 9:
		print("✅ Proceeding to Third Password Upgrade!")
		get_tree().change_scene_to_file("res://MiniGameTscn/passwordupgrade3.tscn")
	else:
		print("⛔ Not enough hints yet!")
		get_tree().change_scene_to_file("res://MiniGameTscn/writeblank.tscn")
