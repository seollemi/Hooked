extends CanvasLayer

@export var char_interval := 0.05
@export var wait_before_complete := 5.0


@onready var label = $RichTextLabel

var full_text := ""
var _char_index := 0

func _ready() -> void:

	if Global.act_1_done and not Global.act_1_seen:
		full_text = "ACT 1 DONE....."
		Global.act_1_seen = true
	elif Global.act_2_cut_done and not Global.act_2_seen:
		full_text = "ACT 2 DONE....."
		Global.act_2_seen = true
	elif Global.act3minigame_done == true and not Global.act_3_seen:
		full_text = "ACT 3 DONE....."
		Global.act_3_seen = true
	else:
		queue_free()
		return

	start_restore_typing()

func start_restore_typing():
	_char_index = 0
	label.text = ""
	while _char_index < full_text.length():
		label.text += full_text[_char_index]
		_char_index += 1
		await get_tree().create_timer(char_interval).timeout

	await get_tree().create_timer(wait_before_complete).timeout
	queue_free()
