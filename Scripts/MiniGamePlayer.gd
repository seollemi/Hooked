extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable: Area2D = $"../interactable"

var can_move: bool = true
var speed: float = 100.0
var last_direction: Vector2 = Vector2.DOWN

func _physics_process(delta: float) -> void:
	if not can_move:
		return  # 🔥 STOP all player movement if cinematic playing

	var input_vector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	velocity = input_vector * speed
	move_and_slide()

	# Animation control
	if input_vector != Vector2.ZERO:
		last_direction = input_vector
		if abs(input_vector.x) > abs(input_vector.y):
			anim.play("walk_right")
			anim.flip_h = input_vector.x < 0
		elif input_vector.y > 0:
			anim.play("walk_down")
			anim.flip_h = false
		else:
			anim.play("walk_up")
			anim.flip_h = false
	else:
		if abs(last_direction.x) > abs(last_direction.y):
			anim.play("idle_right")
			anim.flip_h = last_direction.x < 0
		elif last_direction.y > 0:
			anim.play("idle_down")
			anim.flip_h = false
		else:
			anim.play("idle_up")
			anim.flip_h = false
