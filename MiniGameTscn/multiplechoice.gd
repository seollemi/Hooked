extends Control

@onready var button_1: Button = $VBoxContainer/Button1
@onready var button_2: Button = $VBoxContainer/Button2
@onready var button_3: Button = $VBoxContainer/Button3
@onready var button_4: Button = $VBoxContainer/Button4
@onready var button: Button = $Button
#@onready var label: Label = $Label
@onready var confirmation_dialog: ConfirmationDialog = $ConfirmationDialog
@onready var quest_hehe: Quest_hehe = $Quest_hehe


# Master pool (20 questions)
var all_questions = [
	{
		"question": "What is cybersecurity?",
		"answers": ["Connecting devices to the internet", "Protecting systems, networks, and programs from digital attacks", "The study of programming languages", "Creating social media accounts"],
		"correct": 1
	},
	{
		"question": "Why is cybersecurity important?",
		"answers": ["Ensures faster internet speeds", "Prevents cyberbullying", "Protects data, privacy, and critical systems from threats", "Guarantees unlimited storage"],
		"correct": 2
	},
	{
		"question": "Which of the following is considered personal data?",
		"answers": ["A company’s trade secret", "Your email password", "Government defense plans", "An organization’s financial report"],
		"correct": 1
	},
	{
		"question": "What is a strong password?",
		"answers": ["Your birthday", "12345678", "A mix of uppercase, lowercase, numbers, and symbols", "Your pet’s name"],
		"correct": 2
	},
	{
		"question": "Which of these is an example of phishing?",
		"answers": ["Installing antivirus software", "Receiving an email pretending to be your bank asking for your password", "Downloading a software update from the official website", "Browsing social media"],
		"correct": 1
	},
	{
		"question": "What does 'malware' stand for?",
		"answers": ["Managed alert software", "Malicious software", "Machine learning aware", "Memory allocation warning"],
		"correct": 1
	},
	{
		"question": "Which of the following is a common type of malware?",
		"answers": ["Firewall", "Antivirus", "Trojan Horse", "VPN"],
		"correct": 2
	},
	{
		"question": "What does a firewall do?",
		"answers": ["Strengthens Wi-Fi connection", "Blocks unauthorized access while allowing legitimate communication", "Stores backup copies of files", "Increases internet speed"],
		"correct": 1
	},
	{
		"question": "What is two-factor authentication (2FA)?",
		"answers": ["Using two passwords at the same time", "An extra step requiring something you know and something you have", "Changing your password twice a month", "Logging into two accounts"],
		"correct": 1
	},
	{
		"question": "Which one is an example of two-factor authentication?",
		"answers": ["Password + fingerprint scan", "Password + username", "PIN + password", "Email + password"],
		"correct": 0
	},
	{
		"question": "Which of the following is a social engineering attack?",
		"answers": ["Phishing email", "SQL Injection", "DDoS Attack", "Malware infection"],
		"correct": 0
	},
	{
		"question": "Which of the following is a key motivation of a white hat attacker?",
		"answers": ["Taking advantage of vulnerabilities for personal gain", "Improving security by finding weaknesses", "Damaging systems for revenge", "Stealing confidential data"],
		"correct": 1
	},
	{
		"question": "What is ransomware?",
		"answers": ["Software that steals your data silently", "Malware that locks your files until you pay money", "Tool used for secure communication", "Firewall protection service"],
		"correct": 1
	},
	{
		"question": "Which of these is an example of good cyber hygiene?",
		"answers": ["Reusing the same password everywhere", "Clicking unknown links", "Regularly updating software", "Ignoring antivirus alerts"],
		"correct": 2
	},
	{
		"question": "What should you do if you suspect an email is phishing?",
		"answers": ["Reply to confirm", "Click the link quickly", "Ignore and delete it", "Forward to a friend"],
		"correct": 2
	},
	{
		"question": "Which is NOT a good password practice?",
		"answers": ["Using long, complex combinations", "Sharing with friends you trust", "Keeping it private", "Using a password manager"],
		"correct": 1
	},
	{
		"question": "What does VPN stand for?",
		"answers": ["Virtual Private Network", "Verified Public Number", "Virtual Password Node", "Visual Protection Net"],
		"correct": 0
	},
	{
		"question": "How does a VPN help?",
		"answers": ["Makes internet faster", "Encrypts internet connection and hides IP", "Provides free Wi-Fi", "Prevents malware completely"],
		"correct": 1
	},
	{
		"question": "Which is the safest action when using public Wi-Fi?",
		"answers": ["Accessing your bank account", "Logging into work email", "Using a VPN", "Shopping online"],
		"correct": 2
	},
	{
		"question": "What does encryption do?",
		"answers": ["Deletes unnecessary files", "Converts data into a code to prevent unauthorized access", "Makes files smaller", "Speeds up browsing"],
		"correct": 1
	}
]

# Active quiz
var questions = []
var current_question := 0
var score := 0
var current_answers = []

func _ready() -> void:
	# Force buttons to keep a nice size
	Qbox.get_node("Questbox").visible = false
	for b in [button_1, button_2, button_3, button_4]:
		b.custom_minimum_size = Vector2(300, 60)  # width x height
		b.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		b.size_flags_vertical = Control.SIZE_FILL

	# Connect answer buttons
	button_1.pressed.connect(_on_button_pressed.bind(0))
	button_2.pressed.connect(_on_button_pressed.bind(1))
	button_3.pressed.connect(_on_button_pressed.bind(2))
	button_4.pressed.connect(_on_button_pressed.bind(3))

	# Setup dialog
	confirmation_dialog.dialog_text = "Do you want to exit the quiz?"
	confirmation_dialog.confirmed.connect(_on_exit_confirmed)

	restart_quiz()


func restart_quiz() -> void:
	score = 0
	current_question = 0
	current_answers.clear()

	all_questions.shuffle()
	questions = all_questions.slice(0, 10)

	for b in [button_1, button_2, button_3, button_4]:
		b.disabled = false

	show_question()

func show_question() -> void:
	if current_question < questions.size():
		var q = questions[current_question]
		current_answers = []
		for i in range(q["answers"].size()):
			current_answers.append({"text": q["answers"][i], "is_correct": i == q["correct"]})
		current_answers.shuffle()

		button.text = q["question"]
		button_1.text = current_answers[0]["text"]
		button_2.text = current_answers[1]["text"]
		button_3.text = current_answers[2]["text"]
		button_4.text = current_answers[3]["text"]
	else:
		if score >= 8:
			button.text = "🎉 Congratulations! You passed with a score of %d/%d" % [score, questions.size()]
			for b in [button_1, button_2, button_3, button_4]:
				b.disabled = true
			await get_tree().create_timer(5).timeout
			get_tree().change_scene_to_file("res://Scenes/scrambledscene/scrambled_instruction.tscn")
		else:
			button.text = "❌ You scored %d/%d. Try again!" % [score, questions.size()]
			for b in [button_1, button_2, button_3, button_4]:
				b.disabled = true
			await get_tree().create_timer(3).timeout
			restart_quiz()

func _on_button_pressed(answer_index: int) -> void:
	if current_answers[answer_index]["is_correct"]:
		button.text = "✅ Correct!"
		score += 1
	else:
		var correct_text = ""
		for a in current_answers:
			if a["is_correct"]:
				correct_text = a["text"]
				break
		button.text = "❌ Wrong! The answer was: %s" % correct_text

	await get_tree().create_timer(2).timeout
	current_question += 1
	show_question()

# --- Handle keyboard input ---
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			confirmation_dialog.popup_centered()
			accept_event()

# --- When OK in exit dialog is pressed ---
func _on_exit_confirmed() -> void:
	var prev_scene = load("res://Scenes/officelobby.tscn")  # change to your actual previous scene
	var new_scene = prev_scene.instantiate()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene
	if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe.reach_goal()
	

	# Move player to your chosen vector
	var player = new_scene.get_node("Player")  # adjust node path if needed
	if player:
		player.position = Vector2(601, 391)  # <-- your vector position
