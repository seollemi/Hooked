extends Control

@onready var talk_1: RichTextLabel = $Talk1
@onready var talk_2: RichTextLabel = $Talk2
@onready var talk_3: RichTextLabel = $Talk3

@export var amplitude: float = 5.0
@export var frequency: float = 5.0
@export var speed: float = 5.0

var typing_speed: float = 0.05

func _ready() -> void:
	_continue_typing_sequence()
	Global.chosen_password_number += 1
	Global.scrolling_background.visible = false
func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	char_fx.offset.y = sin((char_fx.absolute_index * frequency + Time.get_ticks_msec() / 100.0 * speed)) * amplitude
	return true

func _continue_typing_sequence() -> void:
	await type_text(talk_1, "We now have a long & strong password with a little complexity!")
	await get_tree().create_timer(2.0).timeout

	await type_text(talk_2, "However... the tools used by hacker are getting better everdyday. The next thing we could add is...")
	await get_tree().create_timer(2.0).timeout

	await type_text(talk_3, "Special characters! Lets go!")
	await get_tree().create_timer(2.0).timeout

	await get_tree().create_timer(2.0).timeout  
	
	get_tree().change_scene_to_file("res://MiniGameTscn/Hints_page.tscn")

func type_text(label: RichTextLabel, full_text: String) -> void:
	label.clear()
	label.append_text("")
	for i in range(full_text.length()):
		label.append_text(full_text[i])
		await get_tree().create_timer(typing_speed).timeout
