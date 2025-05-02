extends Control
var shuffle_button: Button
var scrambled_letters = ["A", "V", "A", "I", "L", "A", "B", "I", "L", "I", "T", "Y"]
var correct_word = "AVAILABILITY"
var selected_word = ""
var pressed_buttons: Array[Button] = []
var letter_buttons: Array[Button] = []
@onready var exit_confirm_dialog = $ExitConfirmDialog  # Adjust the path as needed
# Declare the buttons and output label
var button_1: Button
var button_2: Button
var button_3: Button
var button_4: Button
var button_5: Button
var button_6: Button
var button_7: Button
var button_8: Button
var button_9: Button
var button_10: Button
var button_11: Button
var button_12: Button
var submit_button: Button
var output_label: Label
var music_player: AudioStreamPlayer  # Declare the music player

func _ready():
	# Shuffle letters first
	scrambled_letters.shuffle()
	$Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$Label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	# Assign buttons from the scene
	# (your existing assignments follow here...)
	# Safely assign the buttons and output label from the scene
	button_1 = $HBoxContainer/Button1
	button_2 = $HBoxContainer/Button2
	button_3 = $HBoxContainer/Button3
	button_4 = $HBoxContainer/Button4
	button_5 = $HBoxContainer/Button5
	button_6 = $HBoxContainer/Button6
	button_7 = $HBoxContainer/Button7
	button_8 = $HBoxContainer/Button8
	button_9 = $HBoxContainer/Button9
	button_10 = $HBoxContainer/Button10
	button_11 = $HBoxContainer/Button11
	button_12 = $HBoxContainer/Button12
	
	submit_button = $SubmitButton
	output_label = $OutputLabel
	music_player = $MusicPlayer  # Assign the music player node

	# Ensure all buttons exist and are properly assigned
	var buttons = [button_1, button_2, button_3, button_4, button_5, button_6, button_7, button_8, button_9
	, button_10, button_11, button_12]
	var button_index = 0

	# Assign letters to the buttons if the buttons are valid
	for button in buttons:
		if button and button_index < scrambled_letters.size():
			button.text = scrambled_letters[button_index]
			button.pressed.connect(_on_LetterButton_pressed.bind(button))
			letter_buttons.append(button)
			button_index += 1

	# Connect the submit button
	if submit_button:
		submit_button.pressed.connect(_on_SubmitButton_pressed)

	# Play the background music (if it’s not already playing)
	if music_player:
		music_player.play()
	shuffle_button = $ShuffleButton  # Adjust the path if it's inside a container
	
	if shuffle_button:
		shuffle_button.pressed.connect(_on_ShuffleButton_pressed)
func _on_LetterButton_pressed(button: Button):
	if button:  # Check if button is not null
		selected_word += button.text
		button.disabled = true
		pressed_buttons.append(button)
		output_label.text = selected_word

func _on_SubmitButton_pressed():
	if selected_word == correct_word:
		output_label.text = "Correct! Word: " + selected_word
		# Change to another scene when the answer is correct
		get_tree().change_scene_to_file("res://Scenes/scrambledscene/scrambled8.tscn")
	else:
		output_label.text = "Incorrect. Try again!"
		_reset_and_shuffle()

func _reset_and_shuffle():
	selected_word = ""
	pressed_buttons.clear()

	# Shuffle the letters
	scrambled_letters.shuffle()

	# Apply new letters to the buttons and re-enable
	for i in range(letter_buttons.size()):
		var btn = letter_buttons[i]
		if btn:
			btn.text = scrambled_letters[i]
			btn.disabled = false

	output_label.text = ""

func _unhandled_input(event):
	# Handle Backspace to delete last letter
	if event.is_action_pressed("BACK") and selected_word.length() > 0:
		selected_word = selected_word.substr(0, selected_word.length() - 1)
		output_label.text = selected_word
		if pressed_buttons.size() > 0:
			var last_button = pressed_buttons.pop_back()
			last_button.disabled = false

	# Handle Escape to show confirmation dialog
	if event.is_action_pressed("exitscrambled"):
		exit_confirm_dialog.popup_centered()




func _on_exit_confirm_dialog_confirmed() -> void:
	# Replace with your actual scene path
	var scene = load("res://Scenes/training.tscn")
	var new_scene = scene.instantiate()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene

	# Move the player or object to (471, 252)
	var player = new_scene.get_node("Player")  # Update path if needed
	if player:
		player.position = Vector2(471, 252)

func _on_ShuffleButton_pressed() -> void:
	shuffle_button.disabled = true
	_reset_and_shuffle()
	await get_tree().create_timer(0.5).timeout
	shuffle_button.disabled = false
