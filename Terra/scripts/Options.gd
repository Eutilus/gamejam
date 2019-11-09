extends Control
#Temporary
const SAVE_PATH ="res://save.json"
var settings = {}

var play_Music = 2000
var play_Effects = 1
var new_coise = 1
var song
var menu = true
#saved

var Master_Volume = 2000
var Music_Volume = 2000
var Effects_Volume = 2000
var Master_Mute = false
var Music_Mute = false
var Effects_Mute = false

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()
	choose_music()
	pass 


func _process(delta):
	if(!$music.is_playing()):
		choose_music()
	
	if(Master_Volume > 0 and Music_Volume > 0):
		play_Music = int((Master_Volume/2000)*(Music_Volume/2000)*2000)
	else:
		play_Music = 1
	
	if(Master_Volume > 0 and Effects_Volume > 0):
		play_Effects = int((Master_Volume/2000)*(Effects_Volume/2000)*2000)
	else:
		play_Effects = 1
	$music.set_max_distance(play_Effects)
	pass

func choose_music():
	if(menu == true):
		menu_music()
	else:
		game_music()
	pass

func menu_music():
	randomize()
	
	new_coise = int(rand_range(1,5))
	
	match new_coise:
		1:
			song = load("res://Assets/Music/Essence.wav")
		2:
			song = load("res://Assets/Music/Skyrim.wav")
		3:
			song = load("res://Assets/Music/Horizions.wav")
		4:
			song = load("res://Assets/Music/Pulsefire.wav")
		5:
			song = load("res://Assets/Music/Fallout.wav")
	$music.set_stream(song)
	$music.play(0.0)
	pass

func game_music():
	randomize()
	
	new_coise = int(rand_range(1,5))
	
	match new_coise:
		1:
			song = load("res://Assets/Sound/Alive.wav")
		2:
			song = load("res://Assets/Sound/Asleep.wav")
		3:
			song = load("res://Assets/Sound/Dangerous.wav")
		4:
			song = load("res://Assets/Song/Save.wav")
		5:
			song = load("res://Assets/Song/Shot.wav")
	$music.set_stream(song)
	$music.play(0.0)
	pass

func save_game():
	var settings = {
		Master_Volume = Master_Volume,
		Master_Mute = Master_Mute,
		Music_Volume = Music_Volume,
		Music_Mute = Music_Mute,
		Effects_Volume = Effects_Volume,
		Effects_Mute = Effects_Mute
	}
	
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_line(to_json(settings))
	save_file.close()
	pass

func load_game():
	var save_file = File.new()
	if(not save_file.file_exists(SAVE_PATH)):
		return
	
	save_file.open(SAVE_PATH, File.READ)
	
	var data = {}
	data = parse_json(save_file.get_as_text())
	
	Master_Volume = data['Master_Volume']
	Music_Volume = data['Music_Volume']
	Effects_Volume = data['Effects_Volume']
	Master_Mute = data['Master_Mute']
	Music_Mute = data['Music_Mute']
	Effects_Mute = data['Effects_Mute']
	pass



