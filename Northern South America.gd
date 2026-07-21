extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "N South America"
var sprite_name = "northernsouthamerica"
var borders_open = true
var landlocked = false
var bordering = ["Central America", "Peru", "Brazil"]
var population = 110959213
var growth = 1.1925
var land_area = 2608042
var density = 42.5
var emissions = {1990: 737.68, 1995: 809.39, 2000: 861.6, 2005: 837.11, 2010: 881.72, 2015: 913.68, 2020: 779.74}
var gdp = 1047381086586.66
var gdp_per_cap = 9441.99
var temp = 75.49
var avg_temp = 75.49
var stability = -0.73
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
var composite_countries = ["Anguilla", "Antigua and Barbuda", "Aruba", "Barbados", "Colombia", "Curaçao", "Dominica", "Dominican Republic", "Ecuador", "Grenada", "Guyana", "Montserrat", "Saint Barthelemy", "Saint Kitts and Nevis", "Saint Lucia", "Saint Martin", "Saint Vincent and the Grenadines", "Sint Maarten", "Suriname", "Trinidad and Tobago", "Venezuela"]
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
