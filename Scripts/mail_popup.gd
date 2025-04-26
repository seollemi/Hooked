extends Control

@onready var title_label = $Panel/VBoxContainer/Title
@onready var body_label = $Panel/VBoxContainer/Body
@onready var option_button = $Panel/VBoxContainer/OptionButton
@onready var submit_button: Button = $Panel/Submit
@onready var exit_red: ColorRect = $Panel/EXIT_RED
@onready var color_rect_2: ColorRect = $Panel/ColorRect2

var current_question = 0
var score = 0

var questions = [
	{
		"question": "What's the protocol for suspicious emails?",
		"options": ["Ignore", "Report to IT", "Forward to friends"],
		"answer": 1
	},
	{
		"question": "Your password should be...",
		"options": ["1234", "your birthday", "a complex phrase"],
		"answer": 2
	},
	{
		"question": "Best place to store sensitive data?",
		"options": ["Sticky note", "Cloud vault", "Public folder"],
		"answer": 1
	},
	{
		"question": "When should you update software?",
		"options": ["Never", "Only when it breaks", "Regularly"],
		"answer": 2
	},
	{
		"question": "What’s phishing?",
		"options": ["Fishing game", "Scam email", "New app"],
		"answer": 1
	},
	{
		"question": "If your PC acts weird, you...",
		"options": ["Smash it", "Call IT", "Ignore it"],
		"answer": 1
	},
	{
		"question": "Which link is safe?",
		"options": ["http://clickme.com", "https://bank.com", "bit.ly/offer"],
		"answer": 1
	},
	{
		"question": "A coworker asks for your login. You...",
		"options": ["Share it", "Say no", "Change it"],
		"answer": 1
	},
	{
		"question": "USB from the ground?",
		"options": ["Plug it in", "Scan first", "Throw it"],
		"answer": 2
	},
	{
		"question": "Secure communication?",
		"options": ["Post-it note", "Encrypted chat", "SMS"],
		"answer": 1
	}
]

func _ready():
	load_question()
	submit_button.pressed.connect(_on_submit_pressed)

func load_question():
	if current_question >= questions.size():
		finish_quiz()
		return

	var q = questions[current_question]
	title_label.text = "Question %d" % (current_question + 1)
	body_label.text = q["question"]

	option_button.clear()
	for option in q["options"]:
		option_button.add_item(option)

func _on_submit_pressed():
	var selected = option_button.selected
	var correct = questions[current_question]["answer"]
	if selected == correct:
		score += 1

	current_question += 1
	load_question()

func finish_quiz():
	hide()
	if score >= 9:
		print("✅ Quiz passed with %d/10! Proceeding..." % score)
		# Signal to continue story can be emitted here
	else:
		print("❌ Quiz failed with %d/10. Try again!" % score)
		# Optionally reset or retry



func _on_color_rect_2_mouse_entered() -> void:
	color_rect_2.color = Color(0.71, 0, 0)  


func _on_color_rect_2_mouse_exited() -> void:
	color_rect_2.color = Color(0.81, 0.81, 0.81)


func _on_color_rect_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		queue_free()  # Closes the popup
		
