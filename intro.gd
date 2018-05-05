extends Node

func _ready():
	$start_timer.start()

func _on_intro_player_animation_finished(anim_name):
	if anim_name == "typing":
		get_node("intro_player").play("typing_enter")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_game()

# create a function to switch between scenes 
func start_game():
	var s = ResourceLoader.load("res://game.tscn")
	var currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)
	self.queue_free()

func _on_start_timer_timeout():
	get_node("intro_player").play("typing")