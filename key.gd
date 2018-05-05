extends Node

func _on_key_area_body_entered(body):
	if body.is_in_group("players"):
		body.pick_up_key()
		queue_free()