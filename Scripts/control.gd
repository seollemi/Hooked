extends Control




func _on_color_rect_3_mouse_entered() -> void:

	$ColorRect3.color = Color(0.363, 0.363, 0.363)


func _on_color_rect_3_mouse_exited() -> void:

	$ColorRect3.color = Color(0.659, 0.659, 0.659)  


func _on_exit_red_mouse_exited() -> void:
	
	$EXIT_RED.color = Color(0.71, 0, 0)  



func _on_exit_red_mouse_entered() -> void:
	$EXIT_RED.color = Color(0.81, 0.81, 0.81)  
