extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

# create a function to switch between scenes 
func start_scene(scenePath):
	var s = ResourceLoader.load(scenePath)
	var currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)
	self.queue_free()

func start_game():
	start_scene("res://game.tscn")

func start_intro():
	start_scene("res://intro.tscn")

func start_gameoverscreen():
	start_scene("res://gameover.tscn")

func start_winscreen():
	start_scene("res://win.tscn")