extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "Norway"
var sprite_name = "norway"
var borders_open = true
var landlocked = false
var bordering = ["Sweden", "Finland", "Russia"]
var population = 5553840
var growth = 0.7960
var land_area = 304282
var density = 18.3
var emissions = {1990: 31.08, 1995: 33.06, 2000: 32.63, 2005: 25.84, 2010: 28.59, 2015: 30.33, 2020: 26.98}
var gdp = 482437019790.45
var gdp_per_cap = 86865.49
var temp = 33.36
var avg_temp = 33.36
var stability = 1.25
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
