extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 60


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
	#get_tree().change_scene("res://MenuScreen.tscn")
	get_parent().get_node("Background").visible = true
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.

