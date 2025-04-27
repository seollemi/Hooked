extends Area2D

@export var hint_text: String = "Example: Add numbers to password!"
@onready var interactable: Area2D = $AnimatedSprite2D/interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	animated_sprite_2d.play("Button_pressed")  # Play your interaction animation
	print("🔑 Hint Collected: ", hint_text)
	Global.collected_hints += 1
