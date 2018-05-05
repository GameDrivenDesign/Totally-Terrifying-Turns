extends "res://level.gd"

func _ready():
	pass

func _on_goal_area_body_entered(body):
	if body.is_in_group("players"):
		start_winscreen()
