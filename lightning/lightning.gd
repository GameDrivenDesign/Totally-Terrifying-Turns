extends Light2D

const MAX_LIGHT_PROGRESS = 2.0

var light_progress = 0.0

func _ready():
	set_process(true)
	
func _process(delta):
	light_progress -= delta
	light_progress = max(light_progress, 0.0)
	energy = light_progress / MAX_LIGHT_PROGRESS
	
func thunder():
	$timer.wait_time = randi()%11+4
	$timer.start()
	$audio_player.play()
	light_progress = MAX_LIGHT_PROGRESS

func _on_timer_timeout():
	thunder()
