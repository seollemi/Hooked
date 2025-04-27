extends Node2D
@onready var interactable: Area2D = $interactable
var triggered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()

		
func change_scene():
	if Global.transition_scene:
		match Global.next_scene:
			"outside":
				ChangeScene.change_scene_anim("res://Scenes/bridge.tscn")
			"office":
				ChangeScene.change_scene_anim("res://Scenes/office.tscn")
			"computer":
				ChangeScene.change_scene_anim("res://Scenes/pc_game_password.tscn")
		Global.finish_changescenes()


func _on_door_to_office_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "office"
		Global.transition_scene = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not triggered:
		triggered = true
		Dialogic.start("emailphishing")
		
func _on_interact():
	Global.next_scene = "computer"
	Global.transition_scene = true


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if not triggered:
		triggered = true
		Dialogic.start("password")
