extends Node

@onready var tile_map: TileMap = $TileMap2
@onready var player: CharacterBody2D = $Node2D
@onready var player_camera: Camera2D = $Node2D/PlayerCamera
@onready var marker: Node2D = $Marker
@onready var popup_layer: CanvasLayer = $PopupLayer
@onready var level_music: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var transition_screen: CanvasLayer = $TransitionScreen

var sequence_done: bool = false
var door_position: Vector2
var original_camera_position: Vector2

func _ready() -> void:
	marker.visible = false
	Global.scrolling_background.visible = false
	door_position = tile_map.map_to_local(Vector2i(1, -8))
	Global.reset_points_only()
	level_music.play()

func _process(delta: float) -> void:
	if Global.player_points >= 100 and not sequence_done:
		if popup_layer.get_child_count() > 0:
			return  # ⛔ Wait until all popups are closed

		sequence_done = true
		await _cinematic_door_sequence()

func _cinematic_door_sequence() -> void:
	player.can_move = false  # Freeze player movement

	original_camera_position = player_camera.global_position
	await _move_camera_to(door_position)

	_play_door_sound()
	_remove_tiles()

	await get_tree().create_timer(0.5).timeout
	_show_marker()

	await get_tree().create_timer(1.0).timeout

	await _move_camera_to(original_camera_position)
	player.can_move = true

func _move_camera_to(target_position: Vector2) -> void:
	var tween = create_tween()
	tween.tween_property(player_camera, "global_position", target_position, 2.0)
	await tween.finished

func _remove_tiles() -> void:
	tile_map.set_cell(0, Vector2i(1, -8), -1)
	tile_map.set_cell(0, Vector2i(2, -8), -1)

func _play_door_sound() -> void:
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = load("res://sounds/door-1-open.mp3")  # Adjust sound path
	audio_player.play()
	audio_player.finished.connect(audio_player.queue_free)

func _show_marker() -> void:
	marker.visible = true
	if marker.has_node("AnimatedSprite2D"):
		var anim_sprite = marker.get_node("AnimatedSprite2D")
		anim_sprite.play("marker_1")

# 👇 Level Finish Area2D signal
func _on_level_finish_body_entered(body: Node2D) -> void:
	if body.name == "Node2D":
		level_music.stop()
		print("🎉 Level Complete!")
		player.can_move = false
		await _play_victory_sound()
		# 👉 Instead of changing scenes directly, show password popup
		var popup_scene = preload("res://MiniGameTscn/Password_puzzle_1.tscn")
		var popup = popup_scene.instantiate()
		var popup_layer = get_tree().current_scene.get_node("PopupLayer")
		popup_layer.add_child(popup)

func _play_victory_sound() -> void:
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = preload("res://sounds/level-win-6416.mp3")  # ✅ preload so we are sure
	audio_player.play()
	await get_tree().create_timer(5).timeout
