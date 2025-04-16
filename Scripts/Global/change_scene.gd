extends CanvasLayer


func change_scene_anim(scene_path):
	%AnimationPlayer.play("fade")
	await %AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file(scene_path)
	await get_tree().process_frame  # Wait for 1 frame so the scene is fully ready


	%AnimationPlayer.play_backwards("fade")
