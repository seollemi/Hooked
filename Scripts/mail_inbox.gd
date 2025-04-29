extends Control

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var color_rect_3: ColorRect = $CanvasLayer/ColorRect3
@onready var exit_red: ColorRect = $CanvasLayer/EXIT_RED
@onready var mail_act_1: ColorRect = $CanvasLayer/Mail_Act1

func _ready():
	$CanvasLayer/ColorRect3.visible = false

func _on_color_rect_3_mouse_entered() -> void:

	color_rect_3.color = Color(0.363, 0.363, 0.363)


func _on_color_rect_3_mouse_exited() -> void:

	color_rect_3.color = Color(0.659, 0.659, 0.659)  


func _on_exit_red_mouse_exited() -> void:
	
	exit_red.color = Color(0.71, 0, 0)  



func _on_exit_red_mouse_entered() -> void:
	exit_red.color = Color(0.81, 0.81, 0.81)  


func _on_exit_red_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		queue_free()  # Closes the popup
		
		
func _on_mail_act_1_mouse_entered() -> void:
	mail_act_1.color = Color(0.363, 0.363, 0.363)

func _on_mail_act_1_mouse_exited() -> void:
	mail_act_1.color = Color(0.659, 0.659, 0.659)  


func _on_color_rect_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("📬 Email clicked!")
		get_tree().change_scene_to_file("res://MiniGameTscn/MiniMenu.tscn")

func _process(delta: float) -> void:
	if Global.mini_game_enable == true:
		$CanvasLayer/ColorRect3.visible = true

func _on_mail_act_1_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("📬 Email clicked!")
		var mail_scene = preload("res://Scenes/Fake_login.tscn")
		var mail_popup = mail_scene.instantiate()
		canvas_layer.add_child(mail_popup)
