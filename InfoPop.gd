extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func display_info(name, node):
	visible = true
	var camera = get_parent().get_node("MapCamera")
	rect_global_position = Vector2(camera.position.x - 230, camera.position.y - 300)
	#rect_global_position = Vector2(node.position.x - 585, node.position.y - 1170)
	get_node("CountryInfo").display_info(name, node)
	#popup(Rect2(camera.position.x-270, camera.position.y-585, 450, 600))

func _input(event):
	if event is InputEventScreenTouch:
		var target = get_canvas_transform().affine_inverse().xform(event.position)
		if event.pressed and !get_global_rect().has_point(target):
				visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
