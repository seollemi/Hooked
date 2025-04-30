extends Area2D

@export var hint_text: String = "Example: Add numbers to password!"
@export var popup_scene: PackedScene  # 👈 assign the popup per hint in the editor

@onready var interactable: Area2D = $AnimatedSprite2D/interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var already_collected: bool = false

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	if already_collected:
		return
	already_collected = true

	animated_sprite_2d.play("Button_pressed")
	print("🔑 Hint Collected: ", hint_text)

	_show_plus_hint()

	var points_awarded := 0
	match Global.player_points:
		0, 30:
			points_awarded = 30
		60:
			points_awarded = 40
		_:
			points_awarded = 0

	Global.add_points(points_awarded)
	_play_interact_sound()

	if popup_scene:
		var popup = popup_scene.instantiate()
		var popup_layer = get_tree().current_scene.get_node("PopupLayer")
		popup_layer.add_child(popup)

func _play_interact_sound():
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = load("res://sounds/1up 2 - Sound effects Pack 2.mp3")
	audio_player.play()

func _show_plus_hint() -> void:
	var label = Label.new()
	label.text = "+1 Hint"
	label.add_theme_font_size_override("font_size", 24)
	label.modulate = Color(1, 1, 1, 1)
	label.global_position = global_position + Vector2(0, -20)

	get_tree().current_scene.add_child(label)

	var tween = create_tween()
	tween.tween_property(label, "global_position", label.global_position + Vector2(0, -40), 1.0)
	tween.parallel().tween_property(label, "modulate:a", 0.0, 1.0)
	await tween.finished
	label.queue_free()
