extends Node2D

var color = Color(0.8, 0.2, 0.2)

var points = [] setget set_points

func set_points(new_points):
	points = new_points
	update() # updates the state of this node, _draw() gets called

func _draw():
	for i in range(0, points.size()):
		draw_circle(points[i], 3.0, color)
		if i > 0:
			draw_line(points[i-1], points[i], color)
