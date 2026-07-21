extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var calledSettings = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	calledSettings = true
	get_tree().change_scene("res://SettingsMainScreen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
