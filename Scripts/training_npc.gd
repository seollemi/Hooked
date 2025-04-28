extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D  # adjust path if needed

func _ready() -> void:
	anim.play("idle_right")  # play the idle animation once when scene starts

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO  # no movement at all
	move_and_slide()  # required by CharacterBody2D even if not moving
