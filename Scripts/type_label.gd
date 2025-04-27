extends Label

@export var full_text := "Restoring backup..."
@export var complete_text := "Complete"
@export var char_interval := 0.05  # Time between letters
@export var wait_before_complete := 5.0 # Seconds to wait before showing 'Complete'

var _current_text := ""
var _char_index := 0
var _is_complete_shown := false

func _ready():
	_current_text = ""
	_char_index = 0
	_is_complete_shown = false
	text = ""

func _start_typing():
	# Start typing the full_text one letter at a time
	typing()

func start_restore_typing():
	# Start typing the full_text one letter at a time
	_start_typing()

func typing():
	if _char_index < full_text.length():
		_current_text += full_text[_char_index]
		text = _current_text
		_char_index += 1
		await get_tree().create_timer(char_interval).timeout
		typing()
		
