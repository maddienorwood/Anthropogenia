extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 10
var pastPos = 0
var canMove = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventScreenDrag and canMove and not_on_menu(event.position-Vector2(ProjectSettings.get_setting("display/window/size/width")/2,ProjectSettings.get_setting("display/window/size/height")/2)):
		if (position.x+speed*event.get_relative().x)<540:
			position.x = 540
		elif (position.x+speed*event.get_relative().x > 3754):
			position.x = 3754
		else:
			position.x += speed*event.get_relative().x

func not_on_menu(click):
	var bad_y_coords = [[-1125, -1005],[-1125,-1005],[1020,1128],[1026,1126],[1015,1135]]
	var bad_x_coords = [[-495, -375],[375,495],[-510.5,240.5],[-211,361],[390.5,510.5]]
	var clickable = true
	for i in range(5):
		if (click.x >= bad_x_coords[i][0] and click.x <= bad_x_coords[i][1]) and (click.y >= bad_y_coords[i][0] and click.y <= bad_y_coords[i][1]):
			clickable = false
	if clickable:
		return true
	else:
		return false

func scroll():
	if position.x >= 6454:
		position.x -= 4294
	elif position.x <= -2134:
		position.x += 4294

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
