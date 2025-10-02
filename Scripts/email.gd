extends Control

@onready var win_label: Label = $CanvasLayer/WinLabel
@onready var game_over_label: Label = $CanvasLayer/GameOverLabel
@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var weak_button: Button = $CanvasLayer/WeakButton
@onready var strong_button: Button = $CanvasLayer/StrongButton
@onready var current_password_label: Label = $CanvasLayer/CurrentPasswordLabel
@onready var password_spawner: Node2D = $CanvasLayer/PasswordSpawner
@onready var retry_button: Button = $CanvasLayer/RetryButton
@onready var win_sound: AudioStreamPlayer = $CanvasLayer/WinSound
@onready var correct_sound: AudioStreamPlayer = $CanvasLayer/CorrectSound
@onready var wrong_sound: AudioStreamPlayer = $CanvasLayer/WrongSound
@onready var office_lobby_scene = preload("res://Scenes/officelobby.tscn")
@onready var exit_button: Button = $CanvasLayer/ExitButton
@onready var player: Player = $Player
@onready var win_timer: Timer = $CanvasLayer/WinTimer
@onready var audio_stream_player: AudioStreamPlayer = $CanvasLayer/AudioStreamPlayer
@onready var defeatsound: AudioStreamPlayer = $defeatsound


var score = 0
var game_over = false
var current_password = null

func _ready():

	$CanvasLayer/CurrentPasswordLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$CanvasLayer/CurrentPasswordLabel.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	$CanvasLayer/ScoreLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$CanvasLayer/ScoreLabel.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	MusicManager.music.stop()
	exit_button.visible = false
	retry_button.set_anchors_preset(Control.PRESET_CENTER)
	strong_button.pressed.connect(_on_strong_button_pressed)
	weak_button.pressed.connect(_on_weak_button_pressed)
	retry_button.pressed.connect(_on_retry_button_pressed)  # Retry button connection
	exit_button.pressed.connect(_on_exit_button_pressed)  # Exit button connection
	win_label.visible = false
	game_over_label.visible = false
	retry_button.visible = false  # Hide retry button at the start
	exit_button.visible = false  # Hide exit button at the start
	score_label.text = "Score: %d" % score
	spawn_password()
	audio_stream_player.play()
	if Global.teleport_back:
		var player = $Player  # Adjust node path as needed
		if player:
			player.position = Global.player_PC_Location
			Global.teleport_back = false  # Reset the flag
			
	
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
			correct_sound.play()  # Play correct sound
		else:
			score -= 1
			wrong_sound.play()  # Play wrong sound
		
		current_password.queue_free()
		score_label.text = "Score: %d" % score

		if score < 0:
			defeatsound.play()
			game_over = true
			game_over_label.visible = true
			retry_button.visible = true  # Show retry button on game over
			exit_button.visible = true   # Show exit button on game over
			strong_button.disabled = true
			weak_button.disabled = true
			current_password_label.visible = false
			audio_stream_player.stop()

		elif score >= 10:
			game_over = true
			win_label.visible = true
			strong_button.disabled = true
			weak_button.disabled = true
			win_sound.play()
			Global.minigame_done = true
			win_timer.start()
			current_password_label.visible = false  # Hide the password label on win
			audio_stream_player.stop()
		else:
			spawn_password()

func _on_retry_button_pressed():
	# Reloads the current scene to restart the game
	get_tree().reload_current_scene()


func _on_exit_button_pressed() -> void:
	Global.teleport_back = true
	Global.player_PC_Location = Vector2(631, 363)

	MusicManager.music.play()
	get_tree().change_scene_to_file("res://Scenes/officelobby.tscn")
	
	
func _on_win_timer_timeout() -> void:
	Global.teleport_back = true
	Global.player_PC_Location = Vector2(631, 363)
	get_tree().change_scene_to_file("res://Scenes/officelobby.tscn")
	MusicManager.music.play()
