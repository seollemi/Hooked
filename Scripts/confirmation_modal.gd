class_name ConfirmationModal extends Control


signal confirmed (is_confirmed: bool)

@onready var header_label: Label = %HeaderLabel
@onready var message_label: Label = %MessageLabel
@onready var confirm_button: Button = %Confirm
@onready var cancel_button: Button = %Cancel


var is_open: bool = false

var _should_unpause: bool = false

func _ready() -> void:
	set_process_unhandled_key_input(false)
	
	hide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		cancel()
		
func confirm() -> void:
	_close_modal(true)
	
func cancel() -> void:
	_close_modal(false)

func _close_modal(is_confirmed: bool) -> void:
	set_process_unhandled_key_input(false)
	confirmed.emit(is_confirmed)
	set_deferred("is_open", false)
	hide()
	if _should_unpause:
		get_tree().paused = false
	
func prompt(pause: bool = false) -> bool:
	_should_unpause = (get_tree().paused == false) and pause
	if pause:
		get_tree().paused = true
	show()
	is_open = true
	set_process_unhandled_key_input(true)
	var is_confirmed = await confirmed
	return is_confirmed

func customize(header: String, message: String, confirm_text: String = "Yes", cancel_text: String = "No") -> ConfirmationModal:
	header_label.text = header
	message_label.text = message
	confirm_button.text = confirm_text
	cancel_button.text = cancel_text
	return self


func close(is_confirmed: bool = false) -> void:
	if is_confirmed:
		confirm()
	else:
		cancel()

func _process(delta: float) -> void:
	pass


func _on_confirm_pressed() -> void:
	confirm()
	print("confrim")
	
func _on_cancel_pressed() -> void:
	cancel()
	print("cancel")
