extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 1
	texture_normal = load("res://assets/x" + str(speed) + "button.png")

func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_parent().get_node("ShortClick").play()
	if speed != 3:
		speed+=1
	else:
		speed = 1
	texture_normal = load("res://assets/x" + str(speed) + "button.png")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
