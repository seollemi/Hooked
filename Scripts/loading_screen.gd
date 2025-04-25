extends Control


var scenename = "res://Scenes/outside.tscn"
var progress = [0.0]
var scene_load_status = 0
var resource_ready = false

func _ready():
	ResourceLoader.load_threaded_request(scenename)

func _process(_delta):
	if resource_ready:
		return

	scene_load_status = ResourceLoader.load_threaded_get_status(scenename, progress)
	
	match scene_load_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			%Label.text = str(floor(progress[0] * 100)) + "%"
		
		ResourceLoader.THREAD_LOAD_LOADED:
			%Label.text = "Finishing up..."
			# Load the scene now that it's ready
			Global.outside_scene = ResourceLoader.load_threaded_get(scenename)
			
			ChangeScene.change_scene_anim("res://opening INtro/IntroOpening.tscn")
			#get_tree().change_scene_to_packed(scene_outside)
			#resource_ready = true
		
		ResourceLoader.THREAD_LOAD_FAILED:
			%Label.text = "Failed to load scene."
