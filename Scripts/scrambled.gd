extends Control

# --- Full pool of words and questions ---
var word_list: Array = ["CYBERSECURITY", "DATA", "ENCRYPTION", "PASSWORD","PHISHER","CYBERWARFARE",
"CONFIDENTIALITY","INTEGRITY","AVAILABILITY","CHANGEMANAGEMENT","BACKUP","DIGITALSIGNATURE","CERTIFICATE",
"CIA","BLACKHAT","WHITEHAT","GRAYHAT","PERSONAL","FINANCIAL","HEALTH","INTELLECTUAL","OPERATIONAL"]

var question_list: Array = [
	"What is the practice of protecting systems and networks?",
	"Smallest unit of information in computing?",
	"Turning your information into secret code that only the right person can unlock",
	"A secret string used to access accounts?",
	"Tricks people into revealing sensitive info by posing as a trustworthy source, often via fake emails or websites.",
	"Governments use cyberattacks to disable infrastructure, steal secrets, and disrupt communication—cheaper than war and harder to trace.",
	"Means keeping information private, ensuring messages can’t be read by strangers.",
	"Ensures data isn’t altered without permission—so information remains trustworthy.",
	"Ensures you can access data when needed—ransomware makes it unavailable.",
	"It’s a careful process to handle updates and changes safely",
	"If a change fails, we can roll everything back to the way it was",
	"Official stamp that proves the message came from the real sender and wasn't tampered with.",
	"They prove a website or a person is trustworthy.",
	"Stands for Confidentiality, Integrity, and Availability",
	"Break into systems illegally for personal gain — stealing data, spreading malware, or causing damage.",
	"They’re ethical hackers who are hired to find vulnerabilities before black hats do.",
	"They might hack without permission, but they usually don’t intend harm.",
	"Type of data that are names, addresses, phone numbers",
	"Type of data that are credit card details, payroll info, budgets.",
	"Type of data that are medical records, prescriptions, insurance details.",
	"Type of data that are designs, source code, trade secrets.",
	"Type of data that are schedules, supply chain records, system logs."
]

# --- Game variables ---
var paired_list: Array = []        # Holds shuffled word/question pairs
var current_index: int = 0
var correct_word: String = ""
var selected_word: String = ""
var scrambled_letters: Array = []
var letter_buttons: Array = []
var pressed_buttons: Array = []
var score: int = 0
var music_player: AudioStreamPlayer  # Declare the music player

@onready var question_label: Label = $QuestionLabel
@onready var exit_confirm_dialog: AcceptDialog = $ExitConfirmDialog
@onready var output_label: Label = $OutputLabel
@onready var shuffle_button: Button = $ShuffleButton
@onready var incorrect_label: Label = $IncorrectLabel
@onready var quest_hehe: Quest_hehe = $Quest_hehe
@onready var act_done_scene = preload("res://Scenes/Act_done.tscn")

# --- Ready ---
func _ready() -> void:
	#quest_hehe.should_show_quest_ui():
	Qbox.get_node("Questbox").visible = false
	exit_confirm_dialog.dialog_text = "Confirm to exit?"
	exit_confirm_dialog.confirmed.connect(_on_exit_confirmed) # connect OK button

	output_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	output_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	question_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	question_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	# Collect buttons dynamically
	letter_buttons.clear()
	for i in range(1, 20):
		var node_name = "Button%d" % i
		if $HBoxContainer.has_node(node_name):
			letter_buttons.append($HBoxContainer.get_node(node_name) as Button)

	# Shuffle and limit questions to 10
	paired_list.clear()
	for i in range(word_list.size()):
		paired_list.append({"word": word_list[i], "question": question_list[i]})
	paired_list.shuffle()
	paired_list = paired_list.slice(0, 10)

	if shuffle_button:
		shuffle_button.pressed.connect(_on_ShuffleButton_pressed)

	_load_word(current_index)

# --- Load word ---
func _load_word(index: int) -> void:
	if index >= paired_list.size():
		_show_results()
		return

	incorrect_label.visible = false
	correct_word = paired_list[index]["word"]
	scrambled_letters = correct_word.split("")
	scrambled_letters.shuffle()

	selected_word = ""
	output_label.text = ""
	pressed_buttons.clear()
	question_label.text = paired_list[index]["question"]

	for i in range(letter_buttons.size()):
		var btn = letter_buttons[i]
		if i < scrambled_letters.size():
			btn.text = scrambled_letters[i]
			btn.disabled = false
			btn.visible = true
		else:
			btn.visible = false

# --- Handle keyboard input ---
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		var kc = event.keycode
		var letter = OS.get_keycode_string(kc).to_upper()

		# Letter input
		if letter.length() == 1 and letter >= "A" and letter <= "Z":
			if incorrect_label.visible:
				incorrect_label.visible = false

			for btn in letter_buttons:
				if not btn.disabled and btn.text == letter:
					selected_word += letter
					output_label.text = selected_word
					btn.disabled = true
					pressed_buttons.append(btn)
					accept_event()
					return

		# Backspace → undo
		if kc == KEY_BACKSPACE and pressed_buttons.size() > 0:
			var last_btn = pressed_buttons.pop_back()
			last_btn.disabled = false
			if selected_word.length() > 0:
				selected_word = selected_word.substr(0, selected_word.length() - 1)
				output_label.text = selected_word
			accept_event()
			return

		# Enter → submit
		if kc == KEY_ENTER or kc == KEY_KP_ENTER:
			_on_SubmitButton_pressed()
			accept_event()
			return

		# Escape → exit confirm
		if kc == KEY_ESCAPE:
			exit_confirm_dialog.popup_centered()
			accept_event()
			return

		# Space → shuffle
		if kc == KEY_SPACE:
			_on_ShuffleButton_pressed()
			accept_event()
			return

# --- Submit ---
func _on_SubmitButton_pressed() -> void:
	if selected_word.is_empty():
		incorrect_label.visible = false
		return

	if selected_word == correct_word:
		score += 1
		output_label.text = "✅ Correct! Word: " + selected_word
		incorrect_label.visible = false
		current_index += 1
		await get_tree().create_timer(1.0).timeout
		_load_word(current_index)
	else:
		incorrect_label.text = "❌ Incorrect: " + selected_word
		incorrect_label.visible = true
		_reset_and_shuffle()

# --- Show results ---
func _show_results() -> void:
	for btn in letter_buttons:
		btn.visible = false
	incorrect_label.visible = false

	if score >= 8:
		Global.act_1_done=true
		output_label.text = "🎉 You passed! Score: %d/10" % score
		var scene = load("res://Scenes/officelobby.tscn")
		var new_scene = scene.instantiate()
		get_tree().root.add_child(new_scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = new_scene
		MusicManager.music.stream = preload("res://sounds/2_Day_1_Master.mp3")
		MusicManager.music.play()
		# Move the player or object to (601, 391)
		var player = new_scene.get_node("Player")  # Update path if needed
		if player:
			player.position = Vector2(601, 391)
	if Global.act_1_done == true and Global.act_1_seen == false: 
		var act_done_instance = act_done_scene.instantiate()
		add_child(act_done_instance)
		if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe.reach_goal()
			quest_hehe.QuestStatus.reach_goal
			quest_hehe.finish_quest()
	else:
		output_label.text = "❌ You failed. Score: %d/10" % score

# --- Shuffle ---
func _on_ShuffleButton_pressed() -> void:
	if shuffle_button:
		shuffle_button.disabled = true
	_reset_and_shuffle()
	if shuffle_button:
		await get_tree().create_timer(0.25).timeout
		shuffle_button.disabled = false

func _reset_and_shuffle() -> void:
	selected_word = ""
	output_label.text = ""
	pressed_buttons.clear()
	scrambled_letters.shuffle()

	for i in range(letter_buttons.size()):
		var btn = letter_buttons[i]
		if i < scrambled_letters.size():
			btn.text = scrambled_letters[i]    
			btn.disabled = false
			btn.visible = true
		else:
			btn.visible = false

# --- Exit confirm OK pressed ---
func _on_exit_confirmed() -> void:
	var prev_scene = load("res://Scenes/officelobby.tscn") # change if needed
	var new_scene = prev_scene.instantiate()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene
	if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe.reach_goal()

	# Move player to specific vector position
	var player = new_scene.get_node("Player") # adjust node path if needed
	if player:
		player.position = Vector2(601, 391)  # set your desired position here
