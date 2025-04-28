@tool
extends DialogicPortrait

func _ready():
	print("Portrait scene READY!")
	
func _update_portrait(passed_character: DialogicCharacter, passed_portrait: String) -> void:
	print("Updating portrait:", passed_portrait)

	if passed_portrait == "":
		passed_portrait = passed_character['default_portrait']
	
	if passed_portrait == "ronnie_talking":
		if $AnimatedSprite2D.sprite_frames.has_animation("ronnie_talking"):
			print("Playing animation:", "ronnie_talking")
			$AnimatedSprite2D.play("ronnie_talking")
	elif passed_portrait == "ronnie_no":	
		if $AnimatedSprite2D.sprite_frames.has_animation("ronnie_no"):
			print("Playing animation:", "ronnie_no")
			$AnimatedSprite2D.play("ronnie_no")

		

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if $AnimatedSprite2D.has_animation(anim_name):
		$AnimatedSprite2D.play(anim_name)

func _get_covered_rect() -> Rect2:
	var anim_sprite = $AnimatedSprite2D
	var current_anim = anim_sprite.animation
	var frame_idx = anim_sprite.frame
	var texture = anim_sprite.sprite_frames.get_frame_texture(current_anim, frame_idx)

	if texture:
		return Rect2(anim_sprite.position, texture.get_size() * anim_sprite.scale)
	return Rect2()
