extends ColorRect

var default_color := Color(0.53, 0.53, 0.53)  # #888888
var hover_color := Color(0.75, 0.75, 0.75)    # lighter

func _ready():
	color = default_color

func _on_mouse_entered():
	color = hover_color

func _on_mouse_exited():
	color = default_color
