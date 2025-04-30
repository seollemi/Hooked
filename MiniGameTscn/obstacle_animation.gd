extends Area2D

var game_over_ui: PackedScene = preload("res://MiniGameTscn/GameoverUI3.tscn")

@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var animated_sprite_2d_3: AnimatedSprite2D = $AnimatedSprite2D3
@onready var animated_sprite_2d_4: AnimatedSprite2D = $AnimatedSprite2D4
@onready var animated_sprite_2d_5: AnimatedSprite2D = $AnimatedSprite2D5
@onready var animated_sprite_2d_6: AnimatedSprite2D = $AnimatedSprite2D6
@onready var collision_shape: CollisionShape2D = $CollisionShape2D  
@onready var death_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

var player_dead: bool = false

func _ready() -> void:
	connect("body_entered", _on_body_entered)

	# Start thunder animations
	animated_sprite_2d_2.play("thunder")
	animated_sprite_2d_3.play("thunder")
	animated_sprite_2d_4.play("thunder")
	animated_sprite_2d_5.play("thunder")
	animated_sprite_2d_6.play("thunder")

	# Start trap cycle
	thunder_toggle_loop()

func _on_body_entered(body: Node) -> void:
	if body.name == "Node2D" and not player_dead:
		player_dead = true
		print("💀 Player touched the hazard!")

		death_sound.play()  # ✅ Play death sound

		body.die()
		await get_tree().create_timer(1.0).timeout
		show_restart_ui()

func show_restart_ui():
	var ui = game_over_ui.instantiate()
	get_tree().current_scene.add_child(ui)

func thunder_toggle_loop() -> void:
	await get_tree().create_timer(3.0).timeout

	while true:
		# 🔕 Hide thunder and disable hitbox
		for sprite in [
			animated_sprite_2d_2,
			animated_sprite_2d_3,
			animated_sprite_2d_4,
			animated_sprite_2d_5,
			animated_sprite_2d_6
		]:
			sprite.visible = false

		collision_shape.disabled = true
		await get_tree().create_timer(5.0).timeout

		if player_dead:
			break

		# 🔔 Reappear and play animation
		for sprite in [
			animated_sprite_2d_2,
			animated_sprite_2d_3,
			animated_sprite_2d_4,
			animated_sprite_2d_5,
			animated_sprite_2d_6
		]:
			sprite.visible = true
			sprite.play("thunder")

		collision_shape.disabled = false
		await get_tree().create_timer(2.0).timeout
