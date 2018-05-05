extends Node2D

export (float, 0, 100, 0.1) var speed = 40

var enemies_in_flashlight_area = []
var time_till_flashlight_toggleable = 0.2

func _ready():
	$flashlight_animation_player.play("flickering")

func _process(delta):
	time_till_flashlight_toggleable -= delta
	
	var direction = Vector2()
	if(Input.is_action_pressed("move_left")):
		rotation_degrees = 180
		direction = Vector2(-1, 0)
	elif(Input.is_action_pressed("move_right")):
		rotation_degrees = 0
		direction = Vector2(1, 0)
	elif(Input.is_action_pressed("move_down")):
		rotation_degrees = 90
		direction = Vector2(0, 1)
	elif(Input.is_action_pressed("move_up")):
		rotation_degrees = 270
		direction = Vector2(0, -1)
		
	if Input.is_action_just_pressed("toggle_flashlight") and time_till_flashlight_toggleable <= 0:
		$flashlight.enabled = !$flashlight.enabled
		
	var distance = speed * delta * direction
	move_and_collide(distance)
	
func _physics_process(delta):
	if $flashlight.enabled:
		for enemy in enemies_in_flashlight_area:
			if not is_something_in_between(global_position, enemy.global_position):
				enemy.on_entered_light(self)	
		
	
func is_something_in_between(pos1, pos2):
	var space_state = get_world_2d().direct_space_state
	var intersection = space_state.intersect_ray(pos1, pos2, [self, $flashlight/area/CollisionShape2D, $flashlight/area])
	#Debug code for ray casting, shows ray cast intersection point
	#var s = Sprite.new()
	#s.texture = preload("res://characters/player/lightcircle01.png")
	#s.position = intersection.position
	#s.scale = Vector2(0.01, 0.01)
	#get_parent().add_child(s)
	var distance = intersection.position.distance_to(pos2)
	# Magic value to take area of collision objects into account
	distance -= 8
	return distance > 1

func _on_flashlight_area_body_entered(body):
	if $flashlight.enabled and body.is_in_group("enemy_flashlight_collider"):
		enemies_in_flashlight_area.push_back(body)


func _on_flashlight_area_body_exited(body):
	if $flashlight.enabled and body.is_in_group("enemy_flashlight_collider"):
		enemies_in_flashlight_area.remove(enemies_in_flashlight_area.find(body))
		body.on_exited_light(self)


func _on_neighborhood_area_body_entered(body):
	if body.is_in_group("enemy_neighborhood_collider"):
		body.on_entered_neighborhood(self)


func _on_neighborhood_area_body_exited(body):
	if body.is_in_group("enemy_neighborhood_collider"):
		body.on_exited_neighborhood(self)		
