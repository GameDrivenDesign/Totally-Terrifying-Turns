extends "res://screen.gd"

func _ready():
	pass

func load_level(levelscene_path):
	start_scene(levelscene_path)

func start_winscreen():
	start_scene("res://win.tscn")