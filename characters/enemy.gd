extends KinematicBody2D

var direction = 1.0
var speed = 0.2

var followed_player_path = "../../../player"
var followed_player = null
var time_to_follow = 0.0

func _ready():
	set_physics_process(true)
	
	followed_player = get_node(followed_player_path)

	time_to_follow = 20.0


func _physics_process(delta):
	
	
	#return
	var unit_offset = get_parent().unit_offset
	unit_offset = unit_offset + direction * speed * delta
	if unit_offset < 0 or unit_offset > 1:
		direction = -direction
		unit_offset = clamp(unit_offset, 0, 1)
	get_parent().unit_offset = unit_offset