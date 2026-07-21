extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var prevPos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
	prevPos = get_parent().position
	get_parent().canMove = false
	var timer = get_parent().get_node("Clock/DateTimer")
	if !timer.paused:
		timer.paused = true
	get_parent().position = Vector2(3780, 3510)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().get_parent().interact:
		visible = true
	else:
		visible = false
