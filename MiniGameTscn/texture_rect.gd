extends TextureRect

@export var scroll_speed: Vector2 = Vector2(0, -100)  # (X, Y) pixels per second
@export var reset_position: Vector2 = Vector2(0, 0)  # Where to reset if moved too far
@export var max_offset: Vector2 = Vector2(0, -512)  # When to reset (depends on your texture size)

func _process(delta: float) -> void:
	position += scroll_speed * delta  # Move the TextureRect

	# Reset when moved past max
	if scroll_speed.y != 0:
		if position.y <= max_offset.y:
			position.y = reset_position.y

	if scroll_speed.x != 0:
		if position.x >= max_offset.x:
			position.x = reset_position.x
