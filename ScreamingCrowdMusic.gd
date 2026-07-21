extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var settings = ConfigFile.new()
var err = settings.load("user://settings.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	playing = true
	stream_paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Planet_button_down():
	if !get_parent().get_node("Sound").pressed:
		stream_paused = false


func _on_Planet_button_up():
	stream_paused = true
