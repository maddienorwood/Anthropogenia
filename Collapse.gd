extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
	if get_parent().get_parent().get_node("MapCamera/Clock").carbon_points >= 1000:
		get_parent().get_parent().get_node("MapCamera").position += Vector2(-(1080),2340)
	else:
		get_parent().get_node("NotEnoughCP").popup()
		get_parent().get_node("NotEnoughCP").rect_global_position = rect_global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
