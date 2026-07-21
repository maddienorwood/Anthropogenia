extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "0"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if int(text) == 0:
		get_parent().visible = false
	else:
		get_parent().visible = true
	
	if int(text) > 99:
		text = "99"


func _on_SocialMediaButton_pressed():
	if int(text) > 0:
		text = "0"
		get_parent().visible = false
