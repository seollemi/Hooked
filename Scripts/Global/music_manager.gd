extends Node

@onready var music: AudioStreamPlayer2D = AudioStreamPlayer2D.new()

func _ready():
	add_child(music)
	music.bus = "Master"  # Optional: set this if you use audio buses
	music.autoplay = false
	
