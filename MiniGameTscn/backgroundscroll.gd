extends Node2D

@export var scroll_speed: Vector2 = Vector2(0, -100)  # Move up

@onready var background1: TextureRect = $background
@onready var background2: TextureRect = $background2

func _ready() -> void:
	Global.scrolling_background = self
	visible = false  # ✅ Start invisible
	var texture_size = background1.texture.get_size()

	if scroll_speed.y != 0:
		background1.position = Vector2(0, 0)
		background2.position = Vector2(0, -texture_size.y)

	if scroll_speed.x != 0:
		background1.position = Vector2(0, 0)
		background2.position = Vector2(texture_size.x, 0)

func _process(delta: float) -> void:
	background1.position += scroll_speed * delta
	background2.position += scroll_speed * delta

	var texture_size = background1.texture.get_size()

	# Scroll upward
	if scroll_speed.y != 0:
		if background1.position.y <= -texture_size.y:
			background1.position.y = background2.position.y + texture_size.y
		if background2.position.y <= -texture_size.y:
			background2.position.y = background1.position.y + texture_size.y

	# Scroll sideways
	if scroll_speed.x != 0:
		if background1.position.x >= texture_size.x:
			background1.position.x = background2.position.x - texture_size.x
		if background2.position.x >= texture_size.x:
			background2.position.x = background1.position.x - texture_size.x
