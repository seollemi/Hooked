extends Control
var shuffle_button: Button
var change_letters = ["C", "H", "A", "N", "G", "E"]
var management_letters = ["M", "A", "N", "A", "G", "E", "M", "E", "N", "T"]
var scrambled_letters = change_letters + management_letters
var correct_word = "CHANGE MANAGEMENT"
var selected_word = ""
var pressed_buttons: Array[Button] = []
var letter_buttons: Array[Button] = []

@onready var exit_confirm_dialog = $ExitConfirmDialog  # Adjust the path as needed

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
var button_13: Button
var button_14: Button
var button_15: Button
var button_16: Button
var submit_button: Button
var output_label: Label
var music_player: AudioStreamPlayer  # Declare the music player


func _ready():
	# Shuffle both groups independently
	change_letters.shuffle()
	management_letters.shuffle()

	# Center-align label
	$Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$Label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	# Assign all buttons
	button_1 = $HBoxContainer/Button1
	button_2 = $HBoxContainer/Button2
	button_3 = $HBoxContainer/Button3
	button_4 = $HBoxContainer/Button4
	button_5 = $HBoxContainer/Button5
	button_6 = $HBoxContainer/Button6

	button_7 = $HBoxContainer2/Button7
	button_8 = $HBoxContainer2/Button8
	button_9 = $HBoxContainer2/Button9
	button_10 = $HBoxContainer2/Button10
	button_11 = $HBoxContainer2/Button11
	button_12 = $HBoxContainer2/Button12
	button_13 = $HBoxContainer2/Button13
	button_14 = $HBoxContainer2/Button14
	button_15 = $HBoxContainer2/Button15
	button_16 = $HBoxContainer2/Button16

	submit_button = $SubmitButton
	output_label = $OutputLabel

	# Assign CHANGE letters to first 6 buttons
	var change_buttons = [button_1, button_2, button_3, button_4, button_5, button_6]
	for i in range(change_letters.size()):
		var btn = change_buttons[i]
		btn.text = change_letters[i]
		btn.pressed.connect(_on_LetterButton_pressed.bind(btn))
		letter_buttons.append(btn)

	# Assign MANAGEMENT letters to remaining 10 buttons
	var management_buttons = [button_7, button_8, button_9, button_10, button_11, button_12, button_13, button_14, button_15, button_16]
	for i in range(management_letters.size()):
		var btn = management_buttons[i]
		btn.text = management_letters[i]
		btn.pressed.connect(_on_LetterButton_pressed.bind(btn))
		letter_buttons.append(btn)

	# Connect the submit button
	if submit_button:
		submit_button.pressed.connect(_on_SubmitButton_pressed)


	shuffle_button = $ShuffleButton  # Adjust the path if it's inside a container
	
	if shuffle_button:
		shuffle_button.pressed.connect(_on_ShuffleButton_pressed)
func _on_LetterButton_pressed(button: Button):
	if button:  # Check if button is not null
		selected_word += button.text
		button.disabled = true
		pressed_buttons.append(button)
		if selected_word.length() == 6:
			selected_word += " "
			
		output_label.text = selected_word

func _on_SubmitButton_pressed():
	if selected_word == correct_word:
		Global.act_1_done=true
		output_label.text = "Correct! Word: " + selected_word
		# Change to another scene when the answer is correct
		var scene = load("res://Scenes/officelobby.tscn")
		var new_scene = scene.instantiate()
		get_tree().root.add_child(new_scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = new_scene
		MusicManager.music.stream = preload("res://sounds/2_Day_1_Master.mp3")
		MusicManager.music.play()
		# Move the player or object to (471, 252)
		var player = new_scene.get_node("Player")  # Update path if needed
		if player:
			player.position = Vector2(315, 165)
	else:
		output_label.text = "Incorrect. Try again!"
		_reset_and_shuffle()
		

func _reset_and_shuffle():
	selected_word = ""
	pressed_buttons.clear()

	change_letters.shuffle()
	management_letters.shuffle()

	# Reassign letters
	var change_buttons = [button_1, button_2, button_3, button_4, button_5, button_6]
	for i in range(change_letters.size()):
		var btn = change_buttons[i]
		btn.text = change_letters[i]
		btn.disabled = false

	var management_buttons = [button_7, button_8, button_9, button_10, button_11, button_12, button_13, button_14, button_15, button_16]
	for i in range(management_letters.size()):
		var btn = management_buttons[i]
		btn.text = management_letters[i]
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
	if event.is_action_pressed("exitscrambled"):
		exit_confirm_dialog.popup_centered()

func _on_exit_confirm_dialog_confirmed() -> void:
	MusicManager.music.stream = preload("res://sounds/2_Day_1_Master.mp3")
	MusicManager.music.play()
	var scene = load("res://Scenes/officelobby.tscn")
	var new_scene = scene.instantiate()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene
	
	var player = new_scene.get_node("Player")  # Update path if needed
	if player:
		player.position = Vector2(471, 252)
func _on_ShuffleButton_pressed() -> void:
	shuffle_button.disabled = true
	_reset_and_shuffle()
	await get_tree().create_timer(0.5).timeout
	shuffle_button.disabled = false
