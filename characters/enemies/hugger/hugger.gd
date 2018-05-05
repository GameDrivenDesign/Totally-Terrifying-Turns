extends KinematicBody2D

const common = preload("../common.gd")

enum ENEMY_STATE {
	patrolling,
	following_in_light,
	following_out_of_light
}

const PATH_SPEED = 20.0
const FOLLOW_SPEED = 50.0

const MAX_TIME_TO_FOLLOW = 2.5

var enemy_state = ENEMY_STATE.patrolling

var direction = 1.0
var path_length

var followed_player = null
var time_to_follow = 0.0

func _ready():
	set_physics_process(true)
	path_length = get_parent().get_parent().curve.get_baked_length()

func on_entered_light(player):
	followed_player = player
	enemy_state = ENEMY_STATE.following_in_light
	
func on_exited_light(player):
	if enemy_state != ENEMY_STATE.following_in_light:
		return
	followed_player = player
	enemy_state = ENEMY_STATE.following_out_of_light
	time_to_follow = MAX_TIME_TO_FOLLOW

func _physics_process(delta):
	time_to_follow -= delta
	
	if enemy_state == ENEMY_STATE.patrolling:
		var offset = get_parent().offset
		offset = offset + direction * PATH_SPEED * delta
		if offset < 0 or offset > path_length:
			direction = -direction
			offset = clamp(offset, 0, path_length)
		get_parent().offset = offset
		
		if direction < 0:
			rotation_degrees = 270
		else:
			rotation_degrees = 90
		return
		
	if enemy_state == ENEMY_STATE.following_in_light or (enemy_state == ENEMY_STATE.following_out_of_light and time_to_follow > 0.0):
		var direction = common.calc_direction(self, followed_player)
		move_and_collide(direction * FOLLOW_SPEED * delta)
		get_parent().rotation = 0
		rotation = common.calc_angle(direction)

func hit_by_explosion():
	pass