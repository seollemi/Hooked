extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_area: Area2D = $"../Area2D"

var walk_speed: float = 40.0
var target_position: Vector2 = Vector2(476, 193)  # First move to the player
var moving_to_target: bool = false
var talking: bool = false
var original_position: Vector2
var dialog_started: bool = false  # flag to check if dialog already started

func _ready():
	original_position = global_position
	if not Global.npc_event_done:
		detection_area.body_entered.connect(_on_detection_area_entered)

	if not Dialogic.signal_event.is_connected(_on_dialogic_signal_event):
		Dialogic.signal_event.connect(_on_dialogic_signal_event)

func _on_detection_area_entered(body):
	if body.name == "Player" and not Global.npc_event_done and not moving_to_target and not talking:
		print("👀 Player detected! NPC starting event.")
		Global.npc_event_done = true
		moving_to_target = true
		detection_area.set_deferred("monitoring", false)
		

func _physics_process(delta):
	if moving_to_target and not talking:
		var direction = (target_position - global_position).normalized()
		velocity = direction * walk_speed
		move_and_slide()

		# Play walking animation depending on direction
		if abs(direction.x) > abs(direction.y):
			anim.play("walk_right") if direction.x > 0 else anim.play("walk_left")
		else:
			anim.play("walk_down") if direction.y > 0 else anim.play("walk_up")

		# When close enough to target
		if global_position.distance_to(target_position) < 5:
			moving_to_target = false
			velocity = Vector2.ZERO

			if not dialog_started:
				anim.play("idle_left")
				start_dialog()
			else:
				anim.play("idle_up")  # ✅ Face up after reaching (510, 172)

	elif not moving_to_target:
		velocity = Vector2.ZERO
		move_and_slide()

func start_dialog():
	talking = true
	dialog_started = true	  # Set that dialog already happened
	print("🕒 Waiting before starting conversation...")

	await get_tree().create_timer(0.5).timeout  # ✅ Wait 1.5 seconds
	
	print("🗣️ NPC: Starting conversation...")
	Dialogic.start("NPC_TALK_ACT1")
	
func _on_dialogic_signal_event(event_name: String) -> void:
	if event_name == "Finished_dialogic_1":
		talking = false
		target_position = Vector2(515, 170)  # ✅ New target position
		moving_to_target = true

		if Dialogic.signal_event.is_connected(_on_dialogic_signal_event):
			Dialogic.signal_event.disconnect(_on_dialogic_signal_event)

		if detection_area.body_entered.is_connected(_on_detection_area_entered):
			detection_area.body_entered.disconnect(_on_detection_area_entered)
