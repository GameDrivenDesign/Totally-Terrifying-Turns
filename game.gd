extends "res://level.gd"

func start():
	start_intro()


func _on_player_hit():
	start()


func _on_goal_area_body_entered(body):
	if body.is_in_group("players"):
		start_winscreen()
