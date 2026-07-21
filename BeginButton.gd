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
		get_parent().get_parent().get_parent().get_node("ShortClick").play()
	if get_parent().get_parent().get_parent().tutorial_on:
		get_parent().visible = false
		var tutorial = get_parent().get_parent().get_node("Tutorial")
		tutorial.visible = true
		tutorial.begin_tutorial()
	else:
		get_parent().visible = false
		get_tree().paused = false
		get_parent().get_parent().get_node("Clock/DateTimer").paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
