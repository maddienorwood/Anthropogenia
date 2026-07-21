extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "Central America"
var sprite_name = "centralamerica"
var borders_open = true
var landlocked = false
var bordering = ["Mexico", "N South America"]
var population = 78942174
var growth = 0.8751
var land_area = 676821
var density = 116.6
var emissions = {1990: 181.21, 1995: 177.64, 2000: 190.15, 2005: 193.45, 2010: 202.14, 2015: 199.35, 2020: 222.24}
var gdp = 561021062250.00
var gdp_per_cap = 7110.21
var temp = 75.43
var avg_temp = 75.43
var stability = -0.18
var collapsed = false
var diseased = 0.0
var victims = 0
var disaster = ""
var disaster_total = 0
var sustainable_tech = []
var warring = ""
var war_ticks = 0
var clickpos = 0
var composite_countries = ["The Bahamas", "Belize", "Bermuda", "Cayman Islands", "Costa Rica", "Cuba", "El Salvador", "Guatemala", "Haiti", "Honduras", "Jamaica", "Nicaragua", "Panama", "Puerto Rico", "Turks and Caicos Islands", "British Virgin Islands", "U.S. Virgin Islands"]
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
