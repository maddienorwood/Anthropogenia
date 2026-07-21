extends PopupPanel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func display_info(name, node):
	var camera = get_parent().get_node("MapCamera")
	get_node("CountryInfo").text = name
	#popup(Rect2(camera.position.x-270, camera.position.y-585, 450, 600))
	popup_centered()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
