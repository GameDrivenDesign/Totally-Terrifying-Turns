extends KinematicBody2D

const PATH_SPEED = 20.0
const FOLLOW_SPEED = 50.0

var direction = 1.0
var path_length

var followed_player_path = "../../../player"
var followed_player = null
var time_to_follow = 0.0

func _ready():
	set_physics_process(true)
	path_length = get_parent().get_parent().curve.get_baked_length()
	followed_player = get_node(followed_player_path)
	#time_to_follow = 20.0

func on_entered_light(player):
	print("entered")
	
func on_exited_light(player):
	print("exited")

func _physics_process(delta):
	#print(followed_player.position)
	#move_and_collide((followed_player.global_position - global_position).normalized() * FOLLOW_SPEED * delta)
	
	#return
	var offset = get_parent().offset
	offset = offset + direction * PATH_SPEED * delta
	if offset < 0 or offset > path_length:
		direction = -direction
		offset = clamp(offset, 0, path_length)
	get_parent().offset = offset