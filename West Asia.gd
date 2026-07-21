extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "West Asia"
var sprite_name = "westasia"
var borders_open = true
var landlocked = false
var bordering = ["Northeast Africa", "Eastern Europe", "Russia", "Iran"]
var population = 282002573
var growth = 1.5659
var land_area = 4810110
var density = 58.6
var emissions = {1990: 1000.06, 1995: 1121.68, 2000: 1344.77, 2005: 1537.15, 2010: 1941.57, 2015: 2289.09, 2020: 2475.53}
var gdp = 3346202369972.69
var gdp_per_cap = 11865.86
var temp = 64.17
var avg_temp = 64.17
var stability = -1.41
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
var composite_countries = ["Armenia", "Azerbaijan", "Bahrain", "Cyprus", "Gaza Strip", "Georgia", "Iraq", "Israel", "Jordan", "Kuwait", "Lebanon", "Oman", "Qatar", "Saudi Arabia", "Syria", "Turkey", "United Arab Emirates", "West Bank", "Yemen"]
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
