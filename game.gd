extends "res://screen.gd"

func _ready():
	$CanvasModulate.set_color(config.modulate_color())

func _on_player_lose():
	start_gameoverscreen()

func _on_player_win():
	start_winscreen()