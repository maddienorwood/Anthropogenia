extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "South Asia"
var sprite_name = "southasia"
var borders_open = true
var landlocked = false
var bordering = ["India", "China", "Malaysia"]
var population = 515798992
var growth = 0.7654
var land_area = 2314649
var density = 222.8
var emissions = {1990: 625.48, 1995: 772.95, 2000: 844.29, 2005: 1028.24, 2010: 1204.59, 2015: 1424.84, 2020: 1637.78}
var gdp = 2336842490932.91
var gdp_per_cap = 4747.57
var temp = 75.57
var avg_temp = 75.57
var stability = -0.51
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
var composite_countries = ["Bangladesh", "Bhutan", "Brunei", "Burma", "Cambodia", "Hong Kong", "Laos", "Macau", "Maldives", "Marshall Islands", "Micronesia", "Nepal", "Northern Mariana Islands", "Palau", "Singapore", "Sri Lanka", "Taiwan", "Thailand", "Timor-Leste", "Vietnam"]
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
