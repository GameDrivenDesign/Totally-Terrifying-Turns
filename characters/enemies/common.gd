extends Node

static func calc_angle(vec2):
	if vec2.x < 0:
		return -acos(Vector2(0.0, -1.0).dot(vec2))
	else:
		return acos(Vector2(0.0, -1.0).dot(vec2))
	
static func calc_direction(enemy, player):
	return (player.global_position - enemy.global_position).normalized()