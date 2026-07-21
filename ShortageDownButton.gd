extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var minimum = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _pressed():
	if get_parent().text == str(minimum):
		visible = false

func _on_ShortageUpButton_pressed():
	visible = true # Replace with function body.
