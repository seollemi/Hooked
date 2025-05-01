extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var anim_sprite: AnimatedSprite2D = $background/background/Sprite2D/Node2D/AnimatedSprite2D
@onready var node_2d_2: AnimatedSprite2D = $background/background/Sprite2D/Node2D2/AnimatedSprite2D
@onready var scroll: ScrollContainer = $ScrollContainer
@onready var content: VBoxContainer = $ScrollContainer/VBoxContainer
@onready var The_End: AudioStreamPlayer2D = $AudioStreamPlayer2D

var speed: float = 20.0  # Camera scroll speed
var scroll_speed: float = 50.0  # Credits scroll speed (upward)

func _ready():
	anim_sprite.play("default")
	node_2d_2.play("default")
	The_End.play()
func _process(delta: float) -> void:
	# Move camera slowly to the right
	camera_2d.position.x += speed * delta
	

	scroll.scroll_vertical += int(scroll_speed * delta)
