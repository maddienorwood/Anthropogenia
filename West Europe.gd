extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "West Europe"
var sprite_name = "westeurope"
var borders_open = true
var landlocked = false
var bordering = ["Eastern Europe"]
var population = 316748567
var growth = 0.0010
var land_area = 2029877
var density = 156.0
var emissions = {1990: 2753.57, 1995: 2726.4, 2000: 2752.62, 2005: 2824.42, 2010: 2569.4, 2015: 2352.25, 2020: 2186.55}
var gdp = 13901733710811.90
var gdp_per_cap = 43916.48
var temp = 50.68
var avg_temp = 50.68
var stability = 0.55
var collapsed = false
var diseased = 0.0
var victims = 0
var disaster = ""
var disaster_total = 0
var sustainable_tech = []
var warring = ""
var war_ticks = 0
var clickpos = 0
var next_missile = 3
var composite_countries = ["Andorra", "Belgium", "Denmark", "Faroe Islands", "France", "French Polynesia", "Germany", "Gibraltar", "Guernsey", "Isle of Man", "Italy", "Jersey", "Liechtenstein", "Luxembourg", "Malta", "Monaco", "Netherlands", "Portugal", "San Marino", "Spain", "Switzerland"]
signal touched

func _input(event):
	if event is InputEventScreenTouch:
		var xleft = get_rect().position.x
		var ytop = get_rect().position.y
		var tl = Vector2(xleft, ytop)
		var xright= xleft + get_rect().size.x
		var ybottom = ytop + get_rect().size.y
		var br = Vector2(xright, ybottom)
		var world_position = get_canvas_transform().xform_inv(event.position)
		clickpos = world_position
		if event.pressed and within_shape(to_global(tl), to_global(br), world_position):
				var image = get_texture().get_data()
				image.lock()
				var click = Vector2(world_position-to_global(tl))
				var pixel = image.get_pixelv(click)
				image.unlock()
				if pixel[2] == 0:
					pass
				else:
					var world_map = get_parent()
					world_map.touched = self
					emit_signal("touched")

func within_shape(tl, br, coord):
	if coord.x >= tl.x and coord.x <= br.x:
		if coord.y >= tl.y and coord.y <= br.y:
			return true
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func check_coords(coord):
	var xleft = get_rect().position.x
	var ytop = get_rect().position.y
	var tl = Vector2(xleft, ytop)
	var xright= xleft + get_rect().size.x
	var ybottom = ytop + get_rect().size.y
	var br = Vector2(xright, ybottom)
	if coord.x >= tl.x and coord.x <= br.x:
		if coord.y >= tl.y and coord.y <= br.y:
			var image = get_texture().get_data()
			image.lock()
			var click = Vector2(coord-to_global(tl))
			var pixel = image.get_pixelv(click)
			image.unlock()
			if pixel[2] == 0:
				return false
			else:
				return true
		else:
			return false
	else:
		return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
