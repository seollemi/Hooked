extends Node2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	anim_sprite.play("marker_1")  # 🔥 Start playing the "loop" animation
