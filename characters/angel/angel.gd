extends KinematicBody2D

enum ENEMY_STATE {
	inactive,
	blinded,
	following
}

const FOLLOW_SPEED = 10.0

var enemy_state = ENEMY_STATE.inactive

var followed_player = null

func calc_angle(vec2):
	return acos(Vector2(0.0, -1.0).dot(vec2))
	
func calc_direction(player):
	return (followed_player.global_position - global_position).normalized()

func _ready():
	set_physics_process(true)

func on_entered_light(player):
	followed_player = player
	enemy_state = ENEMY_STATE.blinded
	
func on_exited_light(player):
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
		var direction = calc_direction(followed_player)
		print(calc_angle(direction))
		move_and_collide(direction * FOLLOW_SPEED * delta)
		rotation = calc_angle(direction)