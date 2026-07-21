extends CheckButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var settings = ConfigFile.new()
var music_err = settings.load("user://settings.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	if settings.get_value("Sound", "music_on")==true:
		pressed = true
	else:
		pressed = false
	
func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
