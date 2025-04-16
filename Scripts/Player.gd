extends CharacterBody2D

class_name Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var move_speed: float = 100.0
var acceleration: float = 500.0  # Smooth movement
var friction: float = 800.0  # Smooth stopping
var last_direction: Vector2 = Vector2.DOWN  # Default direction when idle


func _physics_process(delta: float) -> void:
	current_camera()
	var direction: Vector2 = Vector2.ZERO
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")

	if direction.length() > 0:
		# Normalize the direction to prevent diagonal speed boost
		direction = direction.normalized()
		
		# Smooth acceleration
		velocity = velocity.move_toward(direction * move_speed, acceleration * delta)

		# Play correct running animation
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				animation_player.play("RIGHT_RUNNING")
				last_direction = Vector2.RIGHT
			else:
				animation_player.play("LEFT_RUNNING")
				last_direction = Vector2.LEFT
		else:
			if direction.y > 0:
				animation_player.play("DOWN_RUNNING")
				last_direction = Vector2.DOWN
			else:
				animation_player.play("UP_RUNNING")
				last_direction = Vector2.UP
	else:
		# Apply friction to smoothly stop movement
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

		# Play idle animation based on last movement direction
		var idle_animation = {
			Vector2.RIGHT: "idle_RIGHT",
			Vector2.LEFT: "idle_LEFT",
			Vector2.UP: "idle_UP",
			Vector2.DOWN: "idle_DOWN"
		}.get(last_direction, "idle_DOWN")

		if animation_player.current_animation != idle_animation:
			animation_player.play(idle_animation)

	move_and_slide()
	
	
func current_camera():
	if Global.current_scene == "WorldHouse":
		$Inside_camera.enabled = true
		
		$Outside_camera.enabled = false

	elif Global.current_scene == "outsidehouse":
		$Inside_camera.enabled = false
		$Outside_camera.enabled = true
		
