extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var settings = ConfigFile.new()
var err = settings.load("user://settings.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	if settings.has_section("Sound"):
		var sound_on = settings.get_value("Sound", "sound_on")
		pressed = !sound_on
	else:
		settings.set_value("Sound", "sound_on", true)

func _toggled(button_pressed):
	settings.set_value("Sound", "sound_on", !button_pressed)
	settings.save("user://settings.cfg")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
