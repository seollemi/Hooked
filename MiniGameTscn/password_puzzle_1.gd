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
@onready var retry: RichTextLabel = $retry/Retry
@onready var retry_button: TextureButton = $retry
@onready var 	level_music: AudioStreamPlayer2D = $AudioStreamPlayer2D

var time_left := 30
var hard_started := false

func _ready() -> void:
	submit_button.pressed.connect(_on_submit_pressed)
	set_process_input(true)
	process_mode = Node.PROCESS_MODE_ALWAYS
	password_input.grab_focus()

	timer_label.bbcode_enabled = true
	timer_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	instruction_label.bbcode_enabled = true
	instruction_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	button_label.bbcode_enabled = true
	level_music.play()
	
	_update_timer_display()
	countdown_timer.start()
	countdown_timer.timeout.connect(_on_timer_tick)


	soft_tick.play()

	retry.visible = false
	retry_button.visible = false

func _on_submit_pressed() -> void:
	var input_password = password_input.text
	if input_password.length() >= 14:
		await _handle_success()
	else:
		print("⛔ Password too short.")
		password_input.clear()
		password_input.placeholder_text = "Too short! Try again..."

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

	await get_tree().create_timer(1.0).timeout
	retry.visible = true
	retry_button.visible = true


func _on_retry_pressed():
	print("🔁 Reloading mini_game_1...")
	get_tree().change_scene_to_file("res://MiniGameTscn/level_selector.tscn")

func _close_and_proceed():
	get_tree().change_scene_to_file("res://MiniGameTscn/level_selector.tscn")

# ✅ Success logic
func _handle_success() -> void:
	level_music.stop()
	countdown_timer.stop()
	soft_tick.stop()
	hard_tick.stop()

	password_input.editable = false
	submit_button.disabled = true

	# ✅ Show success feedback
	instruction_label.text = "[center][color=green]Brute-force attack avoided![/color]\nRedirecting to system dashboard...[/center]"
	
		# ✅ Grant bonus hints only once
	if not Global.mini_level_1:
		Global.collected_hints += 3
		Global.mini_level_1 = true

	success_sound.play()
	await get_tree().create_timer(7.0).timeout
	_close_and_proceed()
