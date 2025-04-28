extends Area2D

@export var hint_text: String = "Example: Add numbers to password!"
@onready var interactable: Area2D = $AnimatedSprite2D/interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var already_collected: bool = false

func _ready() -> void:
	interactable.interact = _on_interact

func _play_interact_sound():
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = load("res://sounds/1up 2 - Sound effects Pack 2.mp3")
	audio_player.play()
	
func _on_interact():
	if already_collected:
		return  

	already_collected = true

	# 🚨 Don't increase collected_hints if already 3
	if Global.collected_hints < 3:
		Global.collected_hints += 1

	animated_sprite_2d.play("Button_pressed")
	print("🔑 Hint Collected: ", hint_text)

	# ✨ Points logic based on current score
	match Global.player_points:
		0:
			Global.add_points(30)
		30:
			Global.add_points(30)
		60:
			Global.add_points(40)
		_:
			Global.add_points(0)  # Optional if points are other than 0,30

	_play_interact_sound()
