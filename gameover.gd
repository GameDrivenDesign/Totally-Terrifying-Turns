extends "res://screen.gd"

func _ready():
	$death_scream.play()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_intro()