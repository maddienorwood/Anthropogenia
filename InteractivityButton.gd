extends CheckButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var new_interact = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _toggled(button_pressed):
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
	new_interact = pressed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
