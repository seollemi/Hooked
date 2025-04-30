extends Control

@onready var submit_button: TextureButton = $TextureButton
@onready var password_input: LineEdit = $password_input
@onready var timer_label: RichTextLabel = $timer_end
@onready var countdown_timer: Timer = $timer_end/Timer
@onready var instruction_label: RichTextLabel = $Instruction
@onready var button_label: RichTextLabel = $TextureButton/Submit
@onready var soft_tick: AudioStreamPlayer2D = $Soft_tick
@onready var hard_tick: AudioStreamPlayer2D = $hard_tick
@onready var success_sound: AudioStreamPlayer2D = $victory
@onready var retry_label: RichTextLabel = $retry/Retry
@onready var retry_button: TextureButton = $retry
@onready var level_music: AudioStreamPlayer2D = $AudioStreamPlayer2D

var time_left := 30
var hard_started := false

func _ready() -> void:
	submit_button.pressed.connect(_on_submit_pressed)
	set_process_input(true)
	process_mode = Node.PROCESS_MODE_ALWAYS
	password_input.grab_focus()
	level_music.play()
	timer_label.bbcode_enabled = true
	timer_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	instruction_label.bbcode_enabled = true
	instruction_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	button_label.bbcode_enabled = true

	_update_timer_display()
	countdown_timer.start()
	countdown_timer.timeout.connect(_on_timer_tick)

	soft_tick.play()
	level_music.play()
	# Hide retry until timeout
	retry_label.visible = false
	retry_button.visible = false

func _on_submit_pressed() -> void:
	var input_password = password_input.text
	var has_upper := false

	# Check for at least 1 uppercase letter
	for char in input_password:
		if char == char.to_upper() and char != char.to_lower():
			has_upper = true
			break

	if input_password.length() >= 14 and has_upper:
		await _handle_success()
	else:
		print("⛔ Invalid password.")
		password_input.clear()
		if input_password.length() < 14:
			password_input.placeholder_text = "Password too short (min 14)."
		elif not has_upper:
			password_input.placeholder_text = "Use at least 1 capital letter."
		else:
			password_input.placeholder_text = "Try again."

func _on_timer_tick():
	time_left -= 1
	_update_timer_display()

	if time_left == 8 and not hard_started:
		soft_tick.stop()
		hard_tick.play()
		hard_started = true

	if time_left <= 0:
		countdown_timer.stop()
		soft_tick.stop()
		hard_tick.stop()
		_on_time_up()

func _update_timer_display():
	var color := "green"
	if time_left <= 20:
		color = "yellow"
	if time_left <= 8:
		color = "red"

	timer_label.text = "[color=%s]Time left: %ds[/color]" % [color, time_left]

func _on_time_up():
	timer_label.text = "[color=red]Time's up![/color]"
	password_input.editable = false
	submit_button.disabled = true

	retry_label.visible = true
	retry_button.visible = true

func _close_and_proceed():
	get_tree().change_scene_to_file("res://MiniGameTscn/level_selector.tscn")

func _handle_success() -> void:
	level_music.stop()
	countdown_timer.stop()
	soft_tick.stop()
	hard_tick.stop()

	password_input.editable = false
	submit_button.disabled = true

	instruction_label.text = "[center][color=green]Brute-force attack avoided![/color]\nRedirecting to system dashboard...[/center]"

	success_sound.play()

	if not Global.mini_level_2:
		Global.collected_hints += 3
		Global.mini_level_1 = true

	await get_tree().create_timer(7.0).timeout
	_close_and_proceed()

func _on_retry_2_pressed() -> void:
	print("🔁 Reloading mini_game_1...")
	get_tree().change_scene_to_file("res://MiniGameTscn/mini_game_2.tscn")
