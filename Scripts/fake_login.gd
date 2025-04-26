extends Control
@onready var color_x: ColorRect = $CanvasLayer/COLOR_X



func _on_color_x_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		queue_free()  # Closes the popup


func _on_color_x_mouse_entered() -> void:
	color_x.color = Color(0.81, 0.81, 0.81)  


func _on_color_x_mouse_exited() -> void:
	color_x.color = Color(0.71, 0, 0)  
