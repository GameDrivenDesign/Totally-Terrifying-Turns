extends "res://level.gd"

func _on_player_hit():
	start_gameoverscreen()


func _on_goal_area_body_entered(body):
	if body.is_in_group("players"):
		start_winscreen()
