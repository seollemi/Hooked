extends Control

var current_password = ""
var score = 0
var dictionary_words = []

const DIGITS = "0123456789"
const SYMBOLS = "!@#$%^&*()-_=+[]{}|;:,.<>?/"
const TIME_LIMIT = 5.0 # seconds to answer
const WIN_SCORE = 10
const LOSE_SCORE = -5
var time_left = TIME_LIMIT

func _ready():
	randomize()
	load_dictionary()
	update_score()
	show_new_password()
	$Timer.start()

func load_dictionary():
	var file = FileAccess.open("res://dictionary.txt", FileAccess.READ)
	if file:
		while not file.eof_reached():
			var word = file.get_line().strip_edges()
			if word.length() > 2:
				dictionary_words.append(word)
		file.close()
	else:
		push_error("Failed to load dictionary file!")
		
	if dictionary_words.is_empty():
		push_error("The dictionary is empty!")

func show_new_password():
	current_password = generate_random_password()
	$PasswordLabel.text = current_password
	reset_timer()



func check_answer(player_thinks_strong: bool):
	if $Timer.is_stopped():
		return
	$Timer.stop()
	if is_strong(current_password) == player_thinks_strong:
		$ResultLabel.text = "✅ Correct!"
		score += 1
	else:
		$ResultLabel.text = "❌ Wrong!"
		score -= 1
	update_score()
	check_game_end()

func generate_random_password() -> String:
	var password = ""
	
	var num_words = randi() % 3 + 1
	for i in range(num_words):
		var word = dictionary_words[randi() % dictionary_words.size()]
		if randi() % 2 == 0:
			word = random_capitalize(word)
		password += word
	
	if randi() % 2 == 0:
		password += DIGITS[randi() % DIGITS.length()]
	if randi() % 2 == 0:
		password += SYMBOLS[randi() % SYMBOLS.length()]
	
	return shuffle_string(password)

func random_capitalize(word: String) -> String:
	var chars = word.split("")
	for i in range(chars.size()):
		if randi() % 2 == 0:
			chars[i] = chars[i].to_upper()
	return "".join(chars)

func shuffle_string(text: String) -> String:
	var chars = text.split("")  # This creates a PackedStringArray
	var array_chars = Array(chars)  # Convert PackedStringArray to Array
	array_chars.shuffle()  # Shuffle the array
	return "".join(array_chars)  # Join back to string

func is_strong(password: String) -> bool:
	if password.length() < 8:
		return false
	var has_upper = false
	var has_lower = false
	var has_digit = false
	var has_symbol = false
	
	for i in range(password.length()):
		var c = password[i]
		if c.is_upper():
			has_upper = true
		elif c.is_lower():
			has_lower = true
		elif c.is_digit():
			has_digit = true
		elif c.is_alphanumeric():  # Check for symbols
			has_symbol = true
	
	return has_upper and has_lower and has_digit and has_symbol


func update_score():
	$ScoreLabel.text = "Score: %d" % score

func reset_timer():
	time_left = TIME_LIMIT
	$Timer.start()

func _on_Timer_timeout():
	$ResultLabel.text = "⌛ Time's up! -1 point!"
	score -= 1
	update_score()
	check_game_end()

func _process(delta):
	if $Timer.is_stopped():
		return
	time_left -= delta
	$TimerLabel.text = "Time left: %.1f" % time_left

func check_game_end():
	if score >= WIN_SCORE:
		game_win()
	elif score <= LOSE_SCORE:
		game_over()
	else:
		show_new_password()

func game_over():
	$ResultLabel.text = "💀 Game Over! Your score: %d" % score
	disable_buttons()
	$Timer.stop()

func game_win():
	$ResultLabel.text = "🏆 You Win! Your score: %d" % score
	disable_buttons()
	$Timer.stop()

func disable_buttons():
	$StrongButton.disabled = true
	$WeakButton.disabled = true


func _on_weak_button_pressed() -> void:
	print("Strong button pressed!")
	check_answer(true)


func _on_strong_button_pressed() -> void:
	print("Weak button pressed!")
	check_answer(false)
