extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_node("ShortClick").play()

func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_node("ShortClick").play()
	var dir = Directory.new()
	dir.remove("user://save.cfg")
	if loadSaveCheck():
		config.clear()
		config.save("user://save.cfg")
	get_tree().change_scene("res://DonationScreen.tscn")

func loadSaveCheck():
	var err = config.load("user://save.cfg")
	if err != OK:
		return false
	else:
		return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
