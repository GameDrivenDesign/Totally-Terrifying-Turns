extends KinematicBody2D

export (float, 0, 100, 0.1) var speed = 40

func _ready():
	if (config.no_enemy_collision):
		set_collision_mask_bit(1, false)
		set_collision_layer_bit(1, false)

func _process(delta):
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
		
	var distance = speed * delta * direction
	move_and_collide(distance)

func _on_flashlight_area_body_entered(body):
	if body.is_in_group("enemy_flashlight_collider"):
		body.on_entered_light(self)


func _on_flashlight_area_body_exited(body):
	if body.is_in_group("enemy_flashlight_collider"):
		body.on_exited_light(self)


func _on_neighborhood_area_body_entered(body):
	if body.is_in_group("enemy_neighborhood_collider"):
		body.on_entered_neighborhood(self)


func _on_neighborhood_area_body_exited(body):
	if body.is_in_group("enemy_neighborhood_collider"):
		body.on_exited_neighborhood(self)
