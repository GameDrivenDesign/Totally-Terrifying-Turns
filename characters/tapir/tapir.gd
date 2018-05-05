extends Node2D

var exploded

func _ready():
	exploded = false

func _on_attack_area_body_entered(body):
	if (body.is_in_group("enemy_neighborhood_collider") || body.is_in_group("enemy_flashlight_collider")) && not exploded:
		body.hit_by_explosion()
		explode()

func explode():
	exploded = true
	var explosion = preload("res://characters/tapir/explosion.tscn").instance()
	explosion.position = global_position
	get_parent().add_child(explosion)
	explosion.big_explosion()
	$base/tapir_normal.set_visible(false)
	$base/tapir_exploded.set_visible(true)
