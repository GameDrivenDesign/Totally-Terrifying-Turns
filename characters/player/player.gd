extends KinematicBody2D

signal hit

const BATTERY_USAGE = 0.032

export (float, 0, 100, 0.1) var speed = 40

const BASESPEED = 5

var enemies_in_flashlight_area = []
var time_till_flashlight_toggleable = 0.2
var keys = 0
var is_in_godmode
var movement_speed

var battery_on = true
var battery_status = 1.0

func _ready():
	is_in_godmode = false
	speed = BASESPEED
	if (config.no_enemy_collision):
		set_collision_mask_bit(1, false)
		set_collision_layer_bit(1, false)
	$flashlight_animation_player.play("flickering")

func _process(delta):
	time_till_flashlight_toggleable -= delta
	
	if battery_on:
		battery_status -= delta * BATTERY_USAGE
		if battery_status <= 0.0:
			battery_status = 0.0
			toggle_battery()
		
	$hud/battery_status_label.text = "power left: " + String(int(battery_status * 10 + 0.5) * 10) + "%"
	
	var direction = Vector2()
	if(Input.is_action_pressed("move_left")):
		rotation_degrees = 180
		direction = Vector2(-speed, 0)
	elif(Input.is_action_pressed("move_right")):
		rotation_degrees = 0
		direction = Vector2(speed, 0)
	elif(Input.is_action_pressed("move_down")):
		rotation_degrees = 90
		direction = Vector2(0, speed)
	elif(Input.is_action_pressed("move_up")):
		rotation_degrees = 270
		direction = Vector2(0, -speed)
	
	if Input.is_action_just_pressed("toggle_godmode"):
		toggle_godmode()
	
	if Input.is_action_just_pressed("toggle_flashlight") and time_till_flashlight_toggleable <= 0:
		#$flashlight/audio_player.play()
		if battery_status > 0.0:
			toggle_battery()
		
	var distance = speed * delta * direction
	if(is_in_godmode):
		translate(distance)
	else:
		move_and_collide(distance)
	
func _physics_process(delta):
	if $flashlight.enabled:
		for enemy in enemies_in_flashlight_area:
			if not is_something_in_between(global_position, enemy.global_position):
				enemy.on_entered_light(self)	
		
	
func is_something_in_between(pos1, pos2):
	var space_state = get_world_2d().direct_space_state
	var intersection = space_state.intersect_ray(pos1, pos2, [self, $flashlight/area/shape, $flashlight/area, $hitbox, $hitbox/CollisionShape2D])
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
	
func pick_up_key():
	keys = keys + 1

func _on_flashlight_area_body_entered(body):
	if body.is_in_group("enemy_flashlight_collider"):
		enemies_in_flashlight_area.push_back(body)


func _on_flashlight_area_body_exited(body):
	if body.is_in_group("enemy_flashlight_collider"):
		enemies_in_flashlight_area.remove(enemies_in_flashlight_area.find(body))
		body.on_exited_light(self)


func _on_neighborhood_area_body_entered(body):
	if body.is_in_group("enemy_neighborhood_collider"):
		body.on_entered_neighborhood(self)


func _on_neighborhood_area_body_exited(body):
	if body.is_in_group("enemy_neighborhood_collider"):
		body.on_exited_neighborhood(self)		


func _on_hitbox_body_entered(body):
	if body.is_in_group("killing_enemies"):
		emit_signal("hit")

func toggle_battery():
	$flashlight/audio_player.play()
	battery_on = !battery_on
	$flashlight.enabled = !$flashlight.enabled
	$flashlight/area/shape.disabled = !$flashlight/area/shape.disabled
	#time_till_flashlight_toggleable = 0.4
	
func recharge_battery(amount):
	battery_status = clamp(battery_status + amount, 0.0, 1.0)
	$flashlight/audio_player.play()
	

func toggle_godmode():
	is_in_godmode = not is_in_godmode
	if(is_in_godmode):
		speed = 15
	else:
		speed = BASESPEED

func hit_by_explosion():
	pass
