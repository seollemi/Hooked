extends Label

func _process(delta: float) -> void:
	text = "Points: " + str(Global.player_points)
