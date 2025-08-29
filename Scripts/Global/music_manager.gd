extends Node

@onready var music: AudioStreamPlayer2D = AudioStreamPlayer2D.new()

func _ready():
	add_child(music)
	music.bus = "MUSIC"  # Optional: set this if you use audio buses
	music.autoplay = false
	
func play_music(path: String, fade_time := 1.0) -> void:
	var stream = load(path)

	if music.stream != stream:
		# Fade out current track if playing
		if music.playing:
			var fade_out = get_tree().create_tween()
			fade_out.tween_property(music, "volume_db", -80, fade_time)
			await fade_out.finished
			music.stop()

		music.stream = stream
		music.volume_db = -40  # Start quietly
		music.play()

		# Fade in new track
		var fade_in = get_tree().create_tween()
		fade_in.tween_property(music, "volume_db", -10, fade_time)
