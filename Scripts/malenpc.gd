extends CharacterBody2D




const speed= 30
var current_state = IDLE
var dir = Vector2.RIGHT

var start_pos

enum {
	
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready( ):
	randomize( )
	start_pos=position


func _process(delta):
	match current_state:
		IDLE:
			pass
		NEW_DIR:
			var directions = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]
			dir = directions[randi() % directions.size()]
			current_state = MOVE  # Switch to MOVE after choosing direction
		MOVE:
			move(delta)

func move(delta):
	position += dir * speed * delta  # Fixed typo here
