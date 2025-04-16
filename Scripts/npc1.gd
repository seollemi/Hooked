extends CharacterBody2D

@export var move_speed: float = 50.0
@export var change_direction_interval: float = 2.0

var direction: Vector2 = Vector2.ZERO
var time_until_change: float = 0.0

func _ready():
	randomize()
	_pick_new_direction()

func _process(delta):
	time_until_change -= delta
	if time_until_change <= 0:
		_pick_new_direction()

func _physics_process(delta):
	velocity = direction * move_speed
	move_and_slide()
	_update_animation()

func _pick_new_direction():
	# Pick a random direction (including idle)
	var dirs = [
		Vector2.LEFT,
		Vector2.RIGHT,
		Vector2.UP,
		Vector2.DOWN,
		Vector2.ZERO  # Idle sometimes
	]
	direction = dirs[randi() % dirs.size()]
	time_until_change = change_direction_interval

func _update_animation():
	var sprite = $AnimatedSprite2D
	if direction == Vector2.ZERO:
		sprite.play("idle")
	else:
		if direction == Vector2.LEFT:
			sprite.play("walk_left")
		elif direction == Vector2.RIGHT:
			sprite.play("walk_right")
		elif direction == Vector2.UP:
			sprite.play("walk_up")
		elif direction == Vector2.DOWN:
			sprite.play("walk_down")
