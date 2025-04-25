extends Area2D


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("player is inside the colision shape")
	if body is Player:
		%AnimationPlayer.play("door_open")
		print("openning")
		


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		%AnimationPlayer.play("door_close")
		print("closing")
