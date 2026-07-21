extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().visible = false

func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_parent().get_node("ShortClick").play()
	get_parent().visible = false
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
