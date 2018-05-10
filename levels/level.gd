extends Node

signal player_win
signal player_lose

func _on_player_hit():
	emit_signal("player_lose")

func _on_goal_area_body_entered(body):
	if body.is_in_group("players"):
		emit_signal("player_win", self.name)