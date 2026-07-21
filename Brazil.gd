extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "Brazil"
var sprite_name = "brazil"
var borders_open = true
var bordering = ["N South America", "Peru", "Bolivia", "Uruguay", "Argentina", "Paraguay"]
var landlocked = false
var population = 217240060
var growth = 0.0070
var land_area = 8358140
var density = 26.0
var emissions = {1990: 1638.68, 1995: 1724.55, 2000: 1809.18, 2005: 2006.42, 2010: 2109.66, 2015: 1366.89, 2020: 1451.63}
var gdp = 1608981220812.20
var gdp_per_cap = 7406.47
var temp = 76.85
var avg_temp = 76.85
var stability = -0.42
var collapsed = false
var diseased = 0.0
var victims = 0
var disaster = ""
var disaster_total = 0
var sustainable_tech = []
var warring = ""
var war_ticks = 0
var clickpos = 0
signal touched
var next_missile = 3

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
	print("TL: ", str(tl))
	print("BR: ", str(br))
	print("Coord:", coord)
	"""
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
		"""
	return true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
