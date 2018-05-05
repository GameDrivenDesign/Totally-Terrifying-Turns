extends KinematicBody2D

const common = preload("../common.gd")

enum ENEMY_STATE {
	inactive,
	blinded,
	following
}

const FOLLOW_SPEED = 10.0

var enemy_state = ENEMY_STATE.inactive

var followed_player = null

func _ready():
	set_physics_process(true)

func on_entered_light(player):
	followed_player = player
	enemy_state = ENEMY_STATE.blinded
	
func on_exited_light(player):
	if enemy_state != ENEMY_STATE.blinded:
		return
	followed_player = player
	enemy_state = ENEMY_STATE.following
	
func on_entered_neighborhood(player):
	followed_player = player
	enemy_state = ENEMY_STATE.following
	
func on_exited_neighborhood(player):
	followed_player = null
	enemy_state = ENEMY_STATE.inactive

func _physics_process(delta):
	if enemy_state == ENEMY_STATE.following:
		var direction = common.calc_direction(self, followed_player)
		move_and_collide(direction * FOLLOW_SPEED * delta)
		rotation = common.calc_angle(direction)

func hit_by_explosion():
	queue_free()