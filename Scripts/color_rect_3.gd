extends ColorRect

func _on_timeline_ended(timeline_name: String):
	if timeline_name == "MailAct1":  # Make sure this matches your timeline's name
		$CanvasLayer/ColorRect3.visible = true
