extends Camera2D


# Declare member variables here. Examples:
var speed = 60
var settings = ConfigFile.new()
var sound_err = settings.load("user://settings.cfg")


# Called when the node enters the scene tree for the first time.
func _ready():
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_node("Click").play()
	if settings.get_value("Sound", "music_on")==true:
		get_parent().get_node("CreditsMusic").play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.



func _process(delta):
	var velocity = Vector2.DOWN * speed
	
	if (position.y < 3030):
		position += velocity*delta
	
