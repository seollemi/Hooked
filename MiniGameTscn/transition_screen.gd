extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var next_scene: String = ""

func _ready():
	animation_player.play("fade_in")
	animation_player.animation_finished.connect(_on_animation_finished)

func transition_to_scene(scene_path: String) -> void:
	next_scene = scene_path
	animation_player.play("fade_out")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_out":
		print("🎬 Switching to:", next_scene)
		get_tree().change_scene_to_file(next_scene)
