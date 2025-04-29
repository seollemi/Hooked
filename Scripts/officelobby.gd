extends Node2D

@onready var interactable: Area2D = $interactable
@onready var infodesk: Area2D = $infodesk

var global_alex = false
var triggered= false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact
	infodesk.interact = _on_interact1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()

#### FUNC FOR TRANSITION TO NEXT SCENE
func change_scene():
	if Global.transition_scene:
		match Global.next_scene:
			"outside":
				ChangeScene.change_scene_anim("res://Scenes/bridge.tscn")
			"office":
				ChangeScene.change_scene_anim("res://Scenes/office.tscn")
			"computer":
				ChangeScene.change_scene_anim("res://Scenes/pc_game_password.tscn")
			"training":
				ChangeScene.change_scene_anim("res://Scenes/training.tscn")
		Global.finish_changescenes()

#### FUNC FOR TRANSITION TO NEXT SCENE
func _on_door_to_office_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "office"
		Global.transition_scene = true

func _on_scene_to_training_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "training"
		Global.transition_scene = true
####




func _on_area_2d_body_entered(body: Node2D) -> void:
	if not Global.global_alex:
		Global.global_alex = true
		Dialogic.start("emailphishing")
		
func _on_interact1():
	Dialogic.start("attackers")
	


func _on_interact():
	Global.set_previous_scene("res://Scenes/officelobby.tscn", $Player.global_position)


	Global.next_scene = "computer"
	Global.transition_scene = true
	
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if not Global.global_triggered:
		Global.global_triggered = true
		Dialogic.start("password")

func _on_interactable_body_entered(body: Node2D) -> void:
	Global.previous_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://Scenes/pc_game_password.tscn")
	
