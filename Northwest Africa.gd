extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "Northwest Africa"
var sprite_name = "northwestafrica"
var borders_open = true
var landlocked = false
var bordering = ["Northeast Africa", "Central Africa"]
var population = 512947652
var growth = 2.3581
var land_area = 9161481
var density = 56.0
var emissions = {1990: 676.56, 1995: 753.78, 2000: 813.48, 2005: 865.88, 2010: 919.63, 2015: 1034.48, 2020: 1098.28}
var gdp = 1045075659404.45
var gdp_per_cap = 2037.39
var temp = 78.57
var avg_temp = 78.57
var stability = -1.25
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
var composite_countries = ["Algeria", "Benin", "Burkina Faso", "Cabo Verde", "Côte d'Ivoire", "The Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Liberia", "Mali", "Mauritania", "Mauritius", "Morocco", "Niger", "Nigeria", "Senegal", "Sierra Leone", "Togo"]
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
