extends CanvasLayer

@onready var hint_1: TextureButton = $Hint1
@onready var hint_2: TextureButton = $Hint2
@onready var hint_3: TextureButton = $Hint3
@onready var hint_4: TextureButton = $Hint4
@onready var hint_5: TextureButton = $Hint5
@onready var hint_6: TextureButton = $Hint6
@onready var hint_7: TextureButton = $Hint7
@onready var hint_8: TextureButton = $Hint8
@onready var hint_9: TextureButton = $Hint9
@onready var proceed_button: TextureButton = $TextureButton
@onready var quit: TextureButton = $Quit
@onready var hack_time_label: RichTextLabel = $HackTimeEstimate
@onready var current_password_label: RichTextLabel = $CurrentPassword
@onready var continue_button: TextureButton = $ContinueButton

func _ready() -> void:
	_update_password_display()
	Global.scrolling_background.visible = true
	_update_hint_unlock()
	_update_button_visibility()
	quit.pressed.connect(_on_quit_pressed)
	hint_1.pressed.connect(_on_hint1_pressed)
	hint_2.pressed.connect(_on_hint2_pressed)
	hint_3.pressed.connect(_on_hint3_pressed)
	hint_4.pressed.connect(_on_hint4_pressed)
	hint_5.pressed.connect(_on_hint5_pressed)
	hint_6.pressed.connect(_on_hint6_pressed)
	hint_7.pressed.connect(_on_hint7_pressed)
	hint_8.pressed.connect(_on_hint8_pressed)
	hint_9.pressed.connect(_on_hint9_pressed)
	proceed_button.pressed.connect(_on_proceed_button_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
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
				current_password_label.text = "YouAbiAn"
				hack_time_label.text = "30 dayss"
			4:
				current_password_label.text = "C8rYouAb1An"
				hack_time_label.text = "Hackable in: ~2000 years"
	else:
		print("⚠️ Warning: Password or HackTime label missing!")

func _update_hint_unlock() -> void:
	hint_1.set_locked(Global.collected_hints < 1)
	hint_2.set_locked(Global.collected_hints < 2)
	hint_3.set_locked(Global.collected_hints < 3)
	hint_4.set_locked(Global.collected_hints < 4)
	hint_5.set_locked(Global.collected_hints < 5)
	hint_6.set_locked(Global.collected_hints < 6)
	hint_7.set_locked(Global.collected_hints < 7)
	hint_8.set_locked(Global.collected_hints < 8)
	hint_9.set_locked(Global.collected_hints < 9)

func _on_hint1_pressed() -> void:
	if not hint_1.disabled:
		if not 1 in Global.collected_hint_ids:
			Global.hints_read += 1
			Global.collected_hint_ids.append(1)
		hint_1.disabled = true
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_1.tscn")

func _on_hint2_pressed() -> void:
	if not hint_2.disabled:
		if not 2 in Global.collected_hint_ids:
			Global.hints_read += 1
			Global.collected_hint_ids.append(2)
		hint_2.disabled = true
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_2.tscn")

func _on_hint3_pressed() -> void:
	if not hint_3.disabled:
		if not 3 in Global.collected_hint_ids:
			Global.hints_read += 1
			Global.collected_hint_ids.append(3)
		hint_3.disabled = true
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_3.tscn")

func _on_hint4_pressed() -> void:
	if not hint_4.disabled:
		if not 4 in Global.collected_hint_ids:
			Global.hints_read += 1
			Global.collected_hint_ids.append(4)
		hint_4.disabled = true
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_4.tscn")

func _on_hint5_pressed() -> void:
	if not hint_5.disabled:
		if not 5 in Global.collected_hint_ids:
			Global.hints_read += 1
			Global.collected_hint_ids.append(5)
		hint_5.disabled = true
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_5.tscn")

func _on_hint6_pressed() -> void:
	if not hint_6.disabled:
		if not 6 in Global.collected_hint_ids:
			Global.hints_read += 1
			Global.collected_hint_ids.append(6)
		hint_6.disabled = true
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_6.tscn")

func _on_hint7_pressed() -> void:
	if not hint_7.disabled:
		if not 7 in Global.collected_hint_ids:
			Global.hints_read += 1
			Global.collected_hint_ids.append(7)
		hint_7.disabled = true
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_7.tscn")

func _on_hint8_pressed() -> void:
	if not hint_8.disabled:
		if not 8 in Global.collected_hint_ids:
			Global.hints_read += 1
			Global.collected_hint_ids.append(8)
		hint_8.disabled = true
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_8.tscn")

func _on_hint9_pressed() -> void:
	if not hint_9.disabled:
		if not 9 in Global.collected_hint_ids:
			Global.hints_read += 1
			Global.collected_hint_ids.append(9)
		hint_9.disabled = true
	get_tree().change_scene_to_file("res://MiniGameTscn/hintpaper_9.tscn")


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://MiniGameTscn/MiniMenu.tscn")

func _on_proceed_button_pressed() -> void:
	if Global.hints_read == 3 and Global.chosen_password_number == 1:
		print("✅ Proceeding to Password Upgrade 1!")
		get_tree().change_scene_to_file("res://MiniGameAssets/cutscene_after_upgrade.tscn")
	elif Global.hints_read == 6 and Global.chosen_password_number == 2:
		print("✅ Proceeding to Password Upgrade 2!")
		get_tree().change_scene_to_file("res://MiniGameTscn/cutscene_after_upgrade_2.tscn")
	elif Global.hints_read == 9 and Global.chosen_password_number == 3:
		print("✅ Proceeding to Password Upgrade 3!")
		get_tree().change_scene_to_file("res://MiniGameTscn/cutscene_after_upgrade_3.tscn")
	else:
		print("⛔ Not enough hints yet!")
		get_tree().change_scene_to_file("yessir")

	print("Password: ", Global.chosen_password_number, ", Number: ", Global.collected_hints, ", Hints: ", Global.hints_read)	

func _update_button_visibility() -> void: 
	if Global.chosen_password_number == 4:
		$ContinueButton.visible = true
	else:
		$ContinueButton.visible = false



func _on_continue_pressed() -> void:
	Global.act_3_done = true
	Global.scrolling_background.visible = false

	if get_tree().root.has_node("MusicPlayer"):
		var music = get_tree().root.get_node("MusicPlayer")
		music.stop()
		music.queue_free()

	get_tree().change_scene_to_file("res://Scenes/Office.tscn")
