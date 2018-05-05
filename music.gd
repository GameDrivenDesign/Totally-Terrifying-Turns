extends AudioStreamPlayer

var music = []
var next_music

func _ready():
	var dir = Directory.new()
	dir.open("res://music")
	dir.list_dir_begin(true)
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			music.append("res://music/" + file)
	dir.list_dir_end()
	
	# TODO: I don't think this works yet.
	next_music = randi() % music.size()
	
	play_next()

func _on_music_finished():
	play_next()
	
func play_next():
	self.stream = load(music[next_music])
	self.playing = true
	
	next_music += 1
	if next_music == music.size():
		next_music = 0