extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var settings = ConfigFile.new()
var sound_err = settings.load("user://settings.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
	get_parent().get_parent().get_node("MapCamera").get_node("Background").visible = true
	get_parent().get_parent().get_node("MapCamera").position.x = get_parent().get_parent().get_node("MapCamera").pastPos
	get_parent().get_parent().interact = get_parent().get_node("InteractivityButton").new_interact
	settings.set_value("Sound", "sound_on", get_parent().get_node("SoundButton").pressed)
	settings.set_value("Sound", "music_on", get_parent().get_node("MusicButton").pressed)
	#settings.set_value("Tutorial", "On", get_parent().get_node("TutorialButton").pressed)
	settings.save("user://settings.cfg")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
