extends Control

@onready var win_label: Label = $CanvasLayer/WinLabel
@onready var game_over_label: Label = $CanvasLayer/GameOverLabel
@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var weak_button: Button = $CanvasLayer/WeakButton
@onready var strong_button: Button = $CanvasLayer/StrongButton
@onready var current_password_label: Label = $CanvasLayer/CurrentPasswordLabel
@onready var password_spawner: Node2D = $CanvasLayer/PasswordSpawner
@onready var retry_button: Button = $CanvasLayer/RetryButton  # <- Add this!
@onready var exit_button: Button = $CanvasLayer/ExitButton
@onready var win_sound: AudioStreamPlayer = $CanvasLayer/WinSound

var score = 0
var game_over = false
var current_password = null

func _ready():
	exit_button.visible = false
	retry_button.set_anchors_preset(Control.PRESET_CENTER)
	strong_button.pressed.connect(_on_strong_button_pressed)
	weak_button.pressed.connect(_on_weak_button_pressed)
	retry_button.pressed.connect(_on_retry_button_pressed)  # <- Connect the Retry button
	win_label.visible = false
	game_over_label.visible = false
	retry_button.visible = false  # <- Hide it at start
	score_label.text = "Score: %d" % score
	spawn_password()

func spawn_password():
	current_password = password_spawner.create_password()
	current_password_label.text = current_password.text

func _on_strong_button_pressed():
	if not game_over:
		check_password_clicked(true)

func _on_weak_button_pressed():
	if not game_over:
		check_password_clicked(false)

func check_password_clicked(guessed_strong: bool):
	if current_password:
		if current_password.is_strong == guessed_strong:
			score += 1
		else:
			score -= 1
		
		current_password.queue_free()
		score_label.text = "Score: %d" % score

		if score < 0:
			game_over = true
			game_over_label.visible = true
			retry_button.visible = true    # Show Retry only when you LOSE
			exit_button.visible = true     # Show Exit when you LOSE
			strong_button.disabled = true
			weak_button.disabled = true

		elif score >= 10:
			
			game_over = true
			win_label.visible = true
			strong_button.disabled = true
			weak_button.disabled = true
			win_sound.play()

			# Do NOT show retry button if you WIN
			# (no need to touch retry_button here)

		else:
			spawn_password()


func _on_retry_button_pressed():
	# Reloads the current scene to restart the game
	get_tree().reload_current_scene()
