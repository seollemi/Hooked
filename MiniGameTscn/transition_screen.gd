extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var next_scene: String = ""

func _ready() -> void:
		animation_player.play("fade_in")  # Only play fade_in once!

func transition_to_scene(scene_path: String) -> void:
	next_scene = scene_path
	animation_player.play("fade_out")  # Fade out when changing scenes

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene_to_file(next_scene)
