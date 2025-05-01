extends Control 


@onready var email_button: TextureButton = $EmailNotifButton
@onready var canvas_layer: CanvasLayer = $".."
@onready var node_2d: Node2D = $"../.."

\


func _ready():
	email_button.pressed.connect(_on_email_notif_button_pressed)
	if not Global.pc_start_opened:
		Global.pc_start_opened = true  # Mark it permanently
		Dialogic.start("pc_start")

func _on_email_notif_button_pressed() -> void:
	pass # Replace with function body.
	print("📬 Email clicked!")
	var mail_scene = preload("res://Scenes/MailInbox.tscn")  # Update path
	var mail_popup = mail_scene.instantiate()
	canvas_layer.add_child(mail_popup)

	if mail_popup is Control:
		mail_popup.position = Vector2(320, 180)  # Put it wherever looks centered

	# 🔽 Trigger Dialogic only once
	if not Global.mail_open_opened:
		Global.mail_open_opened = true  # Mark it permanently
		Dialogic.start("Mail_open")

func _unhandled_input(event: InputEvent) -> void:
	Global.teleport_back = true  
	if event.is_action_pressed("exitscrambled"):  # Make sure "BACK" is defined in InputMap as Escape
		get_tree().change_scene_to_file("res://Scenes/Office.tscn")  # Replace with actual path
