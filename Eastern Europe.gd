extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "Eastern Europe"
var sprite_name = "easterneurope"
var borders_open = true
var landlocked = false
var bordering = ["West Europe", "Russia", "West Asia"]
var population = 195365626
var growth = -0.4036
var land_area = 2335081
var density = 83.7
var emissions = {1990: 2379.02, 1995: 1704.84, 2000: 1470.28, 2005: 1454.02, 2010: 1376.36, 2015: 1032.93, 2020: 1263.19}
var gdp = 2995804386865.66
var gdp_per_cap = 15334.35
var temp = 47.43
var avg_temp = 47.43
var stability = 0.07
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
var composite_countries = ["Albania", "Austria", "Belarus", "Bosnia and Herzegovina", "Bulgaria", "Croatia", "Czechia", "Estonia", "Greece", "Hungary", "Kosovo", "Latvia", "Lithuania", "Moldova", "Montenegro", "North Macedonia", "Poland", "Romania", "Serbia", "Slovakia", "Slovenia", "Ukraine"]
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
