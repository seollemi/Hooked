extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var anim_sprite: AnimatedSprite2D = $background/background/Sprite2D/Node2D/AnimatedSprite2D
@onready var node_2d_2: AnimatedSprite2D = $background/background/Sprite2D/Node2D2/AnimatedSprite2D
@onready var scroll: ScrollContainer = $ScrollContainer
@onready var content: VBoxContainer = $ScrollContainer/VBoxContainer
@onready var The_End: AudioStreamPlayer = $AudioStreamPlayer
@onready var transition_screen: CanvasLayer = $TransitionScreen

var scene_switched := false
var base_speed: float = 20.0
var boosted_speed: float = 120.0
var speed: float = base_speed
var scroll_speed: float = 50.0
func _ready():
	anim_sprite.play("default")
	node_2d_2.play("default")
	The_End.play()
	

func _process(delta: float) -> void:
	# Adjust speed if Escape is held
	if Input.is_action_pressed("ui_cancel"):
		speed = boosted_speed
	else:
		speed = base_speed

	camera_2d.position.x += speed * delta
	scroll.scroll_vertical += int(scroll_speed * delta)

	# Check camera position and switch scene if needed
	if not scene_switched and camera_2d.position.x >= 3387:
		scene_switched = true
		transition_screen.transition_to_scene("res://Scenes/Menu.tscn")  # ✅ CORRECT
