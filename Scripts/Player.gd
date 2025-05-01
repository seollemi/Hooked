extends CharacterBody2D

class_name Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interaction_component: Node2D = $InteractionComponent

var move_speed: float = 100
var acceleration: float = 500.0
var friction: float = 800.0
var last_direction: Vector2 = Vector2.DOWN
var can_move: bool = true
var is_cutscene_active: bool = false
var cutscene_move_speed: float = 50


func cutscene_move(path: Array[Vector2]) -> void:
	can_move = false
	is_cutscene_active = true
	_run_cutscene(path)

func _run_cutscene(path: Array[Vector2]) -> void:
	var current_position = global_position

	for target_position in path:
		# Calculate move direction
		var direction = (target_position - current_position).normalized()
		direction.x = round(direction.x)
		direction.y = round(direction.y)

		# Play correct walking animation based on direction
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				if animation_player.current_animation != "RIGHT_RUNNING":
					animation_player.play("RIGHT_RUNNING")
				last_direction = Vector2.RIGHT
			else:
				if animation_player.current_animation != "LEFT_RUNNING":
					animation_player.play("LEFT_RUNNING")
				last_direction = Vector2.LEFT
		else:
			if direction.y > 0:
				if animation_player.current_animation != "DOWN_RUNNING":
					animation_player.play("DOWN_RUNNING")
				last_direction = Vector2.DOWN
			else:
				if animation_player.current_animation != "UP_RUNNING":
					animation_player.play("UP_RUNNING")
				last_direction = Vector2.UP

		# Tween to next point
		var distance = current_position.distance_to(target_position)
		var duration = distance / cutscene_move_speed

		var tween = create_tween()
		tween.tween_property(self, "global_position", target_position, duration)
		
		await tween.finished  # Fully wait for movement to complete
		current_position = target_position

	# After moving through all points
	_on_cutscene_move_finished()

func _on_cutscene_move_finished() -> void:
	can_move = true
	is_cutscene_active = false

	# Play correct idle animation based on last facing direction
	var idle_animation = {
		Vector2.RIGHT: "idle_RIGHT",
		Vector2.LEFT: "idle_LEFT",
		Vector2.UP: "idle_UP",
		Vector2.DOWN: "idle_DOWN"
	}.get(last_direction, "idle_DOWN")

	if animation_player.current_animation != idle_animation:
		animation_player.play(idle_animation)

func _ready() -> void:
	if Global.teleport_back:
		global_position = Global.player_PC_Location
		Global.teleport_back = false

func _physics_process(delta: float) -> void:
	if is_cutscene_active:
		move_and_slide()
		return  # Skip normal movement/animation if in cutscene

	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	current_camera()

	var direction = Vector2.ZERO
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")

	if direction.length() > 0:
		direction = direction.normalized()
		velocity = velocity.move_toward(direction * move_speed, acceleration * delta)

		# Play running animation based on input direction
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				if animation_player.current_animation != "RIGHT_RUNNING":
					animation_player.play("RIGHT_RUNNING")
				last_direction = Vector2.RIGHT
			else:
				if animation_player.current_animation != "LEFT_RUNNING":
					animation_player.play("LEFT_RUNNING")
				last_direction = Vector2.LEFT
		else:
			if direction.y > 0:
				if animation_player.current_animation != "DOWN_RUNNING":
					animation_player.play("DOWN_RUNNING")
				last_direction = Vector2.DOWN
			else:
				if animation_player.current_animation != "UP_RUNNING":
					animation_player.play("UP_RUNNING")
				last_direction = Vector2.UP
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

		# Play idle animation if not moving
		var idle_animation = {
			Vector2.RIGHT: "idle_RIGHT",
			Vector2.LEFT: "idle_LEFT",
			Vector2.UP: "idle_UP",
			Vector2.DOWN: "idle_DOWN"
		}.get(last_direction, "idle_DOWN")

		if animation_player.current_animation != idle_animation:
			animation_player.play(idle_animation)

	move_and_slide()

func current_camera() -> void:
	if Global.current_scene == "WorldHouse":
		#$Inside_camera.enabled = true
		$Outside_camera.enabled = true
	elif Global.current_scene == "outsidehouse":
		#$Inside_camera.enabled = false
		$Outside_camera.enabled = true
