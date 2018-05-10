extends CanvasModulate

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_color(config.modulate_color())
