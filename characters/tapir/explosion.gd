extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$audio_player.play()

func big_explosion():
	scale *= 10
	$fire.speed_scale = $fire.get_speed_scale() / 4
	$fire.set_emitting(true)
	$smoke.speed_scale = $smoke.get_speed_scale() / 4
	$smoke.set_emitting(true)
	$white_streaks.speed_scale = $white_streaks.get_speed_scale() / 4
	$white_streaks.set_emitting(true)
	$Timer.wait_time = 4