extends "res://screen.gd"

func _ready():
	if OS.has_feature('JavaScript'):
		# Maximize game in browsers, because fullscreen
		# requires extra permissions
		OS.window_maximized = true
	elif not OS.is_debug_build():
		# Go fullscreen on desktop, but not when running
		# a debug build.
		OS.window_fullscreen = true

	$start_timer.start()

func _on_intro_player_animation_finished(anim_name):
	if anim_name == "typing":
		get_node("intro_player").play("typing_enter")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_game()

func _on_start_timer_timeout():
	get_node("intro_player").play("typing")