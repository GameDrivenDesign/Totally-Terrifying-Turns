extends "res://screen.gd"

func _ready():
	$CanvasModulate.set_color(config.modulate_color())

func run_level(level_name):
	for child in $level_navigation.get_children():
		child.queue_free()

	var level = load("res://levels/%s.tscn" % level_name).instance()
	$level_navigation.add_child(level)
	level.connect("player_win", self, "_on_player_win")
	level.connect("player_lose", self, "_on_player_lose")
	
func _on_player_lose():
	start_gameoverscreen()

func _on_player_win(level_name):
	if level_name == "level_1":
		run_level("level_2")
	elif level_name == "level_2":
		start_winscreen()
	else:
		print("Invalid level name %s" % level_name)