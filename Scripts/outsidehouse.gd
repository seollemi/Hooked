extends Node2D
@onready var quest_hehe: Quest_hehe = $Quest_hehe

func _ready() -> void:
	print(Global.current_scene)
	
	if not MusicManager.music.playing:
		MusicManager.music.stream = preload("res://sounds/2_Day_1_Master.mp3")  # Replace with your file
		MusicManager.music.volume_db = -40  # Start quiet (mute is around -80 dB)
		MusicManager.music.play()

		var tween = get_tree().create_tween()
		tween.tween_property(MusicManager.music, "volume_db", 0, 2.5)  # Fade in to normal volume in 2.5s
	
func _process(delta: float) -> void:
	change_scene()

func _on_door_inside_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "WorldHouse"
		Global.transition_scene = true

func _on_door_to_city_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = "outside"
		Global.transition_scene = true
		if quest_hehe.quest_statuss == quest_hehe.QuestStatus.started:
			quest_hehe.reach_goal()

func change_scene():
	if Global.transition_scene:
		match Global.next_scene:
			"WorldHouse":
				ChangeScene.change_scene_anim("res://Scenes/WorldHouse.tscn")
			"outside":
				ChangeScene.change_scene_anim("res://Scenes/bridge.tscn")
		Global.finish_changescenes()
