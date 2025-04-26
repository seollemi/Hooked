extends Control 


@onready var email_button: TextureButton = $EmailNotifButton
@onready var canvas_layer: CanvasLayer = $".."
@onready var node_2d: Node2D = $"../.."


var dialog_started := false
var dialog_started1 := false


func _ready():
	email_button.pressed.connect(_on_email_notif_button_pressed)
	if not dialog_started:
		dialog_started = true
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
	if not dialog_started1:
		dialog_started1 = true
		Dialogic.start("Mail_open")
