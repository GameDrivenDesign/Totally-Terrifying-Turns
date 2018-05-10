extends Node

# create a function to switch between scenes 
func start_scene(scenePath):
	var currentScene = load(scenePath).instance()
	get_tree().get_root().add_child(currentScene)
	self.queue_free()
	return currentScene

func start_game(level):
	var game_scene = start_scene("res://game.tscn")
	game_scene.get_node("level_navigation").add_child(level)

func start_intro():
	start_scene("res://intro/intro.tscn")

func start_gameoverscreen():
	start_scene("res://gameover.tscn")

func start_winscreen():
	start_scene("res://win.tscn")