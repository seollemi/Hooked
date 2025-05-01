extends Control

@onready var color_x: ColorRect = $CanvasLayer/COLOR_X
var dialog_started := false

func _on_color_x_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		queue_free()

func _on_color_x_mouse_entered() -> void:
	color_x.color = Color(0.81, 0.81, 0.81)

func _on_color_x_mouse_exited() -> void:
	color_x.color = Color(0.71, 0, 0)

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if not Global.fakelogin_open_opened:
		Global.fakelogin_open_opened = true  # Mark it permanently
		Dialogic.start("Fake_login")

func _on_dialogic_signal(event_name: String) -> void:
	if event_name == "Game_enable":
		Global.mini_game_enable = true
	if event_name == "return_to_office":
		Global.teleport_back = true
		Global.player_PC_Location = Vector2(464, 75)
		get_tree().change_scene_to_file("res://Scenes/Office.tscn")
	if event_name == "act_1_done":
		Global.act_1_done = true
