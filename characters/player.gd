extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if(Input.is_action_pressed("move_left")):
		rotation_degrees = 180
		move_and_collide(Vector2(-1, 0))
	elif(Input.is_action_pressed("move_right")):
		rotation_degrees = 0
		move_and_collide(Vector2(1, 0))
	elif(Input.is_action_pressed("move_down")):
		rotation_degrees = 90
		move_and_collide(Vector2(0, 1))
	elif(Input.is_action_pressed("move_up")):
		rotation_degrees = 270
		move_and_collide(Vector2(0, -1))
	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	
