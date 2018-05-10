extends Node2D

func _on_timer_timeout():
	thunder()

func thunder():
	$audio_player.play()
	$animation_player.play("lightning")
	
	$timer.wait_time = randi() % 11 + 4
	$timer.start()
