extends CheckButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var new_unread_on = true
var past_unread_on = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _toggled(button_pressed):
		new_unread_on = pressed
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
