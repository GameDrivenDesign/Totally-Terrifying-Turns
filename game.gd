extends Node2D

func _ready():
	if OS.has_feature('JavaScript'):
		# Maximize game in browsers
		OS.set_window_maximized(true)