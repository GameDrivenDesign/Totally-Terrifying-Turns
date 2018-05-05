extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const see_all = false
const no_enemy_collision = false

const settings_path = "user://settings.cfg"
const general_section = "general"
const modulate_color_section_key = "modulate_color"

const default_values = {[general_section, modulate_color_section_key] : Color(0, 0, 0)}

var config_file

func set_defaults():
	for key in default_values:
		config_file.set_value(key[0], key[1], default_values[key])
	
func reset_to_defaults():
	config_file = ConfigFile.new()
	set_defaults()
	config_file.save(settings_path)

func _ready():
	
	# Called every time the node is added to the scene.
	# Initialization here
	print("Settings file dir: " + var2str(OS.get_user_data_dir()))
	if (not Directory.new().file_exists(settings_path)):
		reset_to_defaults()
	else:
		config_file = ConfigFile.new()
		if (config_file.load(settings_path) != OK):
			get_tree().quit()
			return

func modulate_color():
	return Color(1, 1, 1) if see_all else config_file.get_value(general_section, modulate_color_section_key)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
