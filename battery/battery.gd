extends Sprite

const CAPACITY = 0.5

func _on_area_body_entered(body):
	if body.is_in_group("players"):
		body.recharge_battery(CAPACITY)
		queue_free()