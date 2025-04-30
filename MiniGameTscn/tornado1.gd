extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D  # correct name

var game_over_ui: PackedScene = preload("res://MiniGameTscn/GameoverUI3.tscn")
var player_dead: bool = false

func _ready() -> void:
	connect("body_entered", _on_body_entered)

	animated_sprite_2d.play("default")  # Replace with actual animation name
	move_left_and_return()

func _on_body_entered(body: Node) -> void:
	if body.name == "Node2D" and not player_dead:
		player_dead = true
		print("💀 Player touched the tornado!")

		audio_stream_player_2d.play()  # ✅ Play death sound

		body.die()
		await get_tree().create_timer(1.0).timeout
		show_restart_ui()  # ✅ fixed missing parenthesis

func show_restart_ui():
	var ui = game_over_ui.instantiate()
	get_tree().current_scene.add_child(ui)

func move_left_and_return() -> void:
	var start_pos = global_position
	var left_pos = start_pos + Vector2(1000, 0)

	while true:
		var tween = create_tween()
		tween.tween_property(self, "global_position", left_pos, 7.0)
		await tween.finished

		await get_tree().create_timer(7.0).timeout

		var return_tween = create_tween()
		return_tween.tween_property(self, "global_position", start_pos, 7.0)
		await return_tween.finished

		await get_tree().create_timer(7.0).timeout
