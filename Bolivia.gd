extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "Bolivia"
var sprite_name = "bolivia"
var borders_open = true
var landlocked = true
var bordering = ["Chile", "Argentina", "Paraguay", "Brazil", "Peru"]
var population = 12054379
var growth = 0.0112
var land_area = 1083301
var density = 11.1
var emissions = {1990: 112.97, 1995: 111.42, 2000: 111.04, 2005: 102.69, 2010: 125.46, 2015: 119.65, 2020: 138.72}
var gdp = 40408208523.88
var gdp_per_cap = 3352.16
var temp = 69.76
var avg_temp = 69.76
var stability = -0.47
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
