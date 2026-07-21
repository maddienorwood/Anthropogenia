extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "Australia"
var sprite_name = "australia"
var borders_open = true
var landlocked = false
var bordering = []
var population = 28856134
var growth = 0.1054
var land_area = 7763562
var density = 3.7
var emissions = {1990: 546.23, 1995: 563.25, 2000: 656.09, 2005: 594.34, 2010: 600.29, 2015: 553.2, 2020: 656.88}
var gdp = 1560970683405.60
var gdp_per_cap = 54124.74
var temp = 70.71
var avg_temp = 70.71
var stability = 0.85
var collapsed = false
var diseased = 0.0
var victims = 0
var disaster = ""
var disaster_total = 0
var sustainable_tech = []
var warring = ""
var war_ticks = 0
var clickpos = 0
var composite_countries = ["Australia", "Fiji", "Kiribati", "Nauru", "New Caledonia", "Samoa", "Solomon Islands", "Tonga", "Tuvalu", "Vanuatu", "Wallis and Futuna"]
var next_missile = 3

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
		#print(position, " ", world_position, " ", to_global(tl), " ", to_global(br))
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
