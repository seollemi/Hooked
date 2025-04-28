extends CanvasLayer

@onready var title_label: RichTextLabel = $TextureRect2/TitleLabel
@onready var hint_text: RichTextLabel = $TextureRect2/HintText
@onready var chosen_word: RichTextLabel = $TextureRect2/ChosenWord
@onready var password_stats: RichTextLabel = $TextureRect2/CurrentPassword
@onready var hack_time_estimate: RichTextLabel = $TextureRect2/HackTimeEstimate
@onready var continue_button: TextureButton = $TextureRect2/ContinueButton
@export var amplitude: float = 5.0
@export var frequency: float = 5.0
@export var speed: float = 5.0

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	char_fx.offset.y = sin((char_fx.absolute_index * frequency + Time.get_ticks_msec() / 100.0 * speed)) * amplitude
	return true

var typing_speed: float = 0.05  # seconds per letter

func _ready() -> void:
	continue_button.hide()
	continue_button.pressed.connect(_on_continue_pressed)
	# Clear all labels BEFORE typing
	title_label.clear()
	hint_text.clear()
	chosen_word.clear()
	password_stats.clear()
	hack_time_estimate.clear()

	_continue_typing_sequence()

func _continue_typing_sequence() -> void:
	await type_text(title_label, "Password Upgrade in Progress...")
	await get_tree().create_timer(2.0).timeout

	await type_text(hint_text, "You think about a letter to capitalise...")
	await get_tree().create_timer(2.0).timeout

	await type_text(chosen_word, "You chosen the letter A: C8rYouAb1An...")
	await get_tree().create_timer(2.0).timeout

	await type_text(password_stats, "Characters: 11 long..., mix of upper,lower and numbers...")
	await get_tree().create_timer(2.0).timeout

	await type_text(hack_time_estimate, "Hackable in: ~2000 years")
	await get_tree().create_timer(2.0).timeout

	continue_button.show()

func type_text(label: RichTextLabel, full_text: String) -> void:
	label.clear()
	label.append_text("")

	for i in range(full_text.length()):
		label.append_text(full_text[i])
		await get_tree().create_timer(typing_speed).timeout

	if label == hack_time_estimate:
		label.parse_bbcode(label.text)
		
func _on_continue_pressed() -> void:
	Global.chosen_password_number += 1
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://MiniGameTscn/cutscene_after_upgrade_2.tscn")
