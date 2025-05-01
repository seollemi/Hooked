extends Control

@onready var Q = [
	$Q_1, $Q_2, $Q_3, $Q_4, $Q_5, $Q_6, $Q_7, $Q_8, $Q_9, $Q_10
]
@onready var U = [
	$U_1, $U_2, $U_3, $U_4, $U_5, $U_6, $U_7, $U_8, $U_9, $U_10
]

@onready var B1: RichTextLabel = $B1
@onready var B2: RichTextLabel = $B2
@onready var B3: RichTextLabel = $B3
@onready var B4: RichTextLabel = $B4

@onready var earth_sprite: AnimatedSprite2D = $Earth/AnimatedSprite2D
@onready var galaxy_sprite: AnimatedSprite2D = $Galaxy/AnimatedSprite2D
@onready var star_sprite: AnimatedSprite2D = $Star/AnimatedSprite2D
@onready var audio_correct: AudioStreamPlayer2D = $AudioPlayerCorrect
@onready var audio_wrong: AudioStreamPlayer2D = $AudioPlayerWrong
@onready var on_start: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var BL = ["passwords", "scams", "ghost", "youtube"]
var correct_answer = "scams"
var current_question = 0

func _ready():
	earth_sprite.play("default")
	galaxy_sprite.play("default")
	star_sprite.play("default")
	on_start.play()
	for q in Q:
		q.bbcode_enabled = true
		q.set_size(Vector2(6540, 1550))
		q.position = Vector2(217, 117)

	$Q_1.text = "[color=white]I know I should use my detective skills to avoid[/color] [color=green]__________[/color][color=white]. If something sounds too good to be true, it probably is.[/color]"
	$Q_2.text = "[color=white]When someone tries to trick me into sharing my password or personal information, that's called[/color] [color=green]__________[/color]"
	$Q_3.text = "[color=white]Which type of attack allows an attacker to use a brute force approach?[/color] [color=green]__________[/color]"
	$Q_4.text = "[color=white]Which of the statements correctly describes cybersecurity?[/color] [color=green]__________[/color]"
	$Q_5.text = "[color=white]What can the skills developed by cybersecurity professionals be used for?[/color] [color=green]__________[/color]"
	$Q_6.text = "[color=white]What should you do in order to make sure that people you live with do not have access to your secure data?[/color] [color=green]__________[/color]"
	$Q_7.text = "[color=white]You have stored your data on a local hard disk. Which method would secure this data from unauthorized access?[/color] [color=green]__________[/color]"
	$Q_8.text = "[color=white]An individual user profile on a social network site is an example of an ….. identity.[/color] [color=green]__________[/color]"
	$Q_9.text = "[color=white]Which of the following passwords would most likely take the longest for an attacker to guess or break?[/color] [color=green]__________[/color]"
	$Q_10.text = "[color=white]Which of the following is a requirement of a strong password?[/color] [color=green]__________[/color]"

	for i in range(1, Q.size()):
		Q[i].visible = false
		U[i].visible = false
	Q[0].visible = true
	U[0].visible = true

	_update_button_texts()

	for b in [B1, B2, B3, B4]:
		b.bbcode_enabled = true
		b.meta_clicked.connect(_on_answer_pressed)

func _update_button_texts():
	B1.text = "[color=black][bgcolor=green][url=" + BL[0] + "]" + BL[0] + "[/url][/bgcolor][/color]"
	B2.text = "[color=black][bgcolor=green][url=" + BL[1] + "]" + BL[1] + "[/url][/bgcolor][/color]"
	B3.text = "[color=black][bgcolor=green][url=" + BL[2] + "]" + BL[2] + "[/url][/bgcolor][/color]"
	B4.text = "[color=black][bgcolor=green][url=" + BL[3] + "]" + BL[3] + "[/url][/bgcolor][/color]"

func _on_answer_pressed(answer: String):
	_disable_all_buttons()  # prevent spam clicks immediately

	var base_text: String = Q[current_question].text
	if answer == correct_answer:
		audio_correct.play()
		var new_text: String = base_text.replace("__________", "[color=green]" + answer + "[/color]")
		Q[current_question].text = new_text
		U[current_question].text = ""
		await get_tree().create_timer(1.0).timeout
		await get_tree().create_timer(4.0).timeout
		_next_question()
	else:
		audio_wrong.play()
		var temp_text: String = base_text.replace("__________", "[color=red]wrong answer[/color]")
		Q[current_question].text = temp_text
		await get_tree().create_timer(1.0).timeout
		Q[current_question].text = base_text
		if answer == BL[0]: B1.visible = false
		elif answer == BL[1]: B2.visible = false
		elif answer == BL[2]: B3.visible = false
		elif answer == BL[3]: B4.visible = false
		_enable_all_buttons()  # allow another guess after 1s

func _disable_all_buttons():
	for b in [B1, B2, B3, B4]:
		b.visible = false

func _enable_all_buttons():
	for b in [B1, B2, B3, B4]:
		b.visible = true

func _next_question():
	Q[current_question].visible = false
	U[current_question].visible = false
	current_question += 1
	if current_question >= Q.size():
		return

	Q[current_question].visible = true
	U[current_question].visible = true

	match current_question:
		1:
			BL = ["phishing", "cyberbullying", "password", "encryption"]
			correct_answer = "phishing"
		2:
			BL = ["phishing", "encryption", "password cracking", "ransomware"]
			correct_answer = "password cracking"
		3:
			BL = ["Cybersecurity is the ongoing effort to protect individuals, organizations and governments from digital attacks", "Cybersecurity is the ongoing effort to protect individuals, organizations and governments from crimes that happen only in cyberspace", "Cybersecurity is the ongoing effort to protect computers, networks and data from malicious attacks", "Cybersecurity is only needed for government systems"]
			correct_answer = "Cybersecurity is the ongoing effort to protect individuals, organizations and governments from digital attacks"
		4:
			BL = ["Cybersecurity professionals develop many skills that can be only be used for good", "Cybersecurity professionals develop many skills that can only be used for evil", "Cybersecurity professionals develop many skills that cannot be used for evil", "Cybersecurity professionals develop many skills that can be used for good or evil"]
			correct_answer = "Cybersecurity professionals develop many skills that can be used for good or evil"
		5:
			BL = ["Turn on a firewall", "Increase the privacy settings on your browser", "Install antivirus software", "Set up password protection"]
			correct_answer = "Set up password protection"
		6:
			BL = ["Data encryption", "Duplication of the hard drive", "Deletion of sensitive files", "Two factor authentication"]
			correct_answer = "Data encryption"
		7:
			BL = ["online", "offline", "website", "People"]
			correct_answer = "online"
		8:
			BL = ["drninjaphd", "super3secret2password1", "mk$$cittykat104#", "10characters"]
			correct_answer = "mk$$cittykat104#"
		9:
			BL = ["Use special characters such as ! @ or $", "Use at least six characters", "Use a dictionary word or a common statement that you’ll remember", "Use a favorite word"]
			correct_answer = "Use special characters such as ! @ or $"

	_update_button_texts()
	_enable_all_buttons()
