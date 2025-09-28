class_name SaveModal extends Control

@onready var header: Label = $NinePatchRect/MarginContainer/VBoxContainer/Label
@onready var ok: Button = $NinePatchRect/MarginContainer/VBoxContainer/Ok

var is_open: bool = false
var _auto_close_timer: SceneTreeTimer = null

func _ready() -> void:
	hide()
	ok.pressed.connect(_on_ok_pressed)


func customize(message: String, confirm_text: String = "Ok") -> SaveModal:
	header.text = message
	ok.text = confirm_text
	return self


func notify(message: String, auto_close: float = 0.0) -> void:
	customize(message)
	show()
	is_open = true

	if _auto_close_timer:
		_auto_close_timer.timeout.disconnect(_on_auto_close)
		_auto_close_timer = null

	if auto_close > 0.0:
		_auto_close_timer = get_tree().create_timer(auto_close)
		_auto_close_timer.timeout.connect(_on_auto_close)


func _on_ok_pressed() -> void:
	_close_modal()


func _on_auto_close() -> void:
	_close_modal()


func _close_modal() -> void:
	if _auto_close_timer:
		_auto_close_timer.timeout.disconnect(_on_auto_close)
		_auto_close_timer = null

	hide()
	is_open = false
