extends PathFollow2D

var direction = 1.0
var speed = 0.2

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	unit_offset = unit_offset + direction * speed * delta
	if unit_offset < 0 or unit_offset > 1:
		direction = -direction
		unit_offset = clamp(unit_offset, 0, 1)