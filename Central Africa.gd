extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "Central Africa"
var sprite_name = "centralafrica"
var borders_open = true
var bordering = ["Northwest Africa", "Northeast Africa", "Southern Africa"]
var landlocked = false
var population = 489612096
var growth = 2.7495
var land_area = 8186183
var density = 59.8
var emissions = {1990: 939.31, 1995: 1020.62, 2000: 1054.47, 2005: 1160.77, 2010: 1229.39, 2015: 1481.46, 2020: 1513.96}
var gdp = 515177742087.26
var gdp_per_cap = 1052.22
var temp = 73.99
var avg_temp = 73.99
var stability = -1.31
var collapsed = false
var diseased = 0.0
var victims = 0
var disaster = ""
var disaster_total = 0
var sustainable_tech = []
var warring = ""
var war_ticks = 0
var clickpos = 0
var composite_countries = ["Burundi", "Cameroon", "Central African Republic", "Congo (Brazzaville)", "Congo (Kinshasa)", "Djibouti", "Equatorial Guinea", "Eritrea", "Ethiopia", "Gabon", "Kenya", "Rwanda", "Sao Tome and Principe", "Seychelles", "Somalia", "South Sudan", "Tanzania", "Uganda"]
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
	pass

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
