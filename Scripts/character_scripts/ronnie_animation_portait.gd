@tool
extends DialogicPortrait

func _ready():
	print("Portrait scene READY!")
	
func _update_portrait(passed_character: DialogicCharacter, passed_portrait: String) -> void:
	print("Updating portrait:", passed_portrait)

	if passed_portrait == "":
		passed_portrait = passed_character['default_portrait']
	
	if passed_portrait == "ronnie_talking":
		if %AnimationPlayer.has_animation("ronnie_talking"):
			print("Playing animation:", "ronnie_talking")
			%AnimationPlayer.play("ronnie_talking")
	elif passed_portrait == "ronnie_no":	
		if %AnimationPlayer.has_animation("ronnie_no"):
			print("Playing animation:", "ronnie_no")
			%AnimationPlayer.play("ronnie_no")

		

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if %AnimationPlayer.has_animation(anim_name):
		%AnimationPlayer.play(anim_name)

func _get_covered_rect() -> Rect2:
	var sprite_node = %ronnie  # Make sure your scene has a Sprite2D node for this to work
	var texture = sprite_node.texture
	if texture:
		return Rect2(sprite_node.position, texture.get_size() * sprite_node.scale)
	return Rect2()
