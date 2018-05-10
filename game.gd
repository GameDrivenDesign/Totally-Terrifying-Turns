extends "res://screen.gd"

func _ready():
	$CanvasModulate.set_color(config.modulate_color())

func _on_player_lose():
	start_gameoverscreen()

func _on_player_win(level_name):
	if level_name == "level_1":
		start_level("level_2")
	elif level_name == "level_2":
		start_winscreen()
	else:
		print("Invalid level name %s" % level_name)