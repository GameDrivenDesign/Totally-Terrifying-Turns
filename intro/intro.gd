extends "res://screen.gd"

onready var intro_player = get_node("intro_player")

func _ready():
	if OS.has_feature('JavaScript'):
		# Maximize game in browsers, because fullscreen
		# requires extra permissions
		OS.window_maximized = true
	elif not OS.is_debug_build():
		# Go fullscreen on desktop, but not when running
		# a debug build.
		OS.window_fullscreen = true

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_game(preload("res://levels/level_1.tscn").instance())

func _on_start_timer_timeout():
	intro_player.animation_set_next("typing", "typing_enter")
	intro_player.play("typing")
