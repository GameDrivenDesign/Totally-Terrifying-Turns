extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("intro_player").play("typing")

func _on_intro_player_animation_finished(anim_name):
	if anim_name == "typing":
		get_node("intro_player").play("typing_enter")