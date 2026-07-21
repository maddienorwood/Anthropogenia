extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var settings = ConfigFile.new()
var err = settings.load("user://settings.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	playing = true
	if settings.get_value("Sound", "sound_on")==true:
		stream_paused = false
	else:
		stream_paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Planet_button_down():
	stream_paused = true


func _on_Planet_button_up():
	if !get_parent().get_node("Sound").pressed:
		stream_paused = false
	else:
		stream_paused = true

func _on_Sound_toggled(button_pressed):
	if button_pressed:
		stream_paused = true
	else:
		stream_paused = false
