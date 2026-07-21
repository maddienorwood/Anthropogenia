extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "Argentina"
var sprite_name = "argentina"
var borders_open = true
var bordering = ["Chile", "Bolivia", "Paraguay", "Brazil", "Uruguay"]
var landlocked = false
var population = 46245668
var growth = 0.0082
var land_area = 2736690
var density = 16.9
var emissions = {1990: 292.65, 1995: 308.14, 2000: 337.38, 2005: 418.09, 2010: 434.83, 2015: 435.81, 2020: 398.91}
var gdp = 491492700657.01
var gdp_per_cap = 10627.86
var temp = 57.59
var avg_temp = 57.59
var stability = 0.04
var collapsed = false
var diseased = 0.0
var victims = 0
var disaster = ""
var disaster_total = 0
var war_ticks = 0
var sustainable_tech = []
var warring = ""
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
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
