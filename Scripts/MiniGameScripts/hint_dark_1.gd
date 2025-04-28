extends TextureButton  # or Control if you prefer

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func set_locked(is_locked: bool) -> void:
	if is_locked:
		anim.play("paper_dark")
		disabled = true
	else:
		anim.play("paper_light")
		disabled = false
		
func _on_interact():
	Global.hints_read += 1  # ✅ Increment hints_read
	print("✅ Hints Read: ", Global.hints_read)
