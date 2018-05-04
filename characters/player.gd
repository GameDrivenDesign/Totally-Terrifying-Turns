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
		move_and_collide(Vector2(-1, 0))
	elif(Input.is_action_pressed("move_right")):
		move_and_collide(Vector2(1, 0))
	elif(Input.is_action_pressed("move_down")):
		move_and_collide(Vector2(0, 1))
	elif(Input.is_action_pressed("move_up")):
		move_and_collide(Vector2(0, -1))
	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

