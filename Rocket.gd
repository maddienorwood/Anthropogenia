extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var origin = "Australia"
var destination = "Iceland"
var origin_coords
var destination_coords
var speed = 1
var x_move = 0
var y_move = 0
var moving = true
var countdown = 100
var settings = ConfigFile.new()
var sound_err = settings.load("user://settings.cfg")
var pastpos_x = 0
var pastpos_y = 0
var newpos_x = 0
var newpos_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var o_name = origin
	var d_name = destination
	origin = get_parent().get_node(origin)
	destination = get_parent().get_node(destination)
	origin_coords = origin.position + Vector2(rng.randi_range(-origin.get_rect().size.x/2, origin.get_rect().size.x/2), rng.randi_range(-origin.get_rect().size.y/2, origin.get_rect().size.y/2))
	while !check_coords(origin_coords, o_name):
		origin_coords = origin.position + Vector2(rng.randi_range(-origin.get_rect().size.x/2, origin.get_rect().size.x/2), rng.randi_range(-origin.get_rect().size.y/2, origin.get_rect().size.y/2))
		if check_coords(origin_coords, o_name):
			break
	destination_coords = destination.position + Vector2(rng.randi_range(-destination.get_rect().size.x/2, destination.get_rect().size.x/2), rng.randi_range(-destination.get_rect().size.y/2, destination.get_rect().size.y/2))
	while !check_coords(destination_coords, d_name):
		destination_coords = destination.position + Vector2(rng.randi_range(-destination.get_rect().size.x/2, destination.get_rect().size.x/2), rng.randi_range(-destination.get_rect().size.y/2, destination.get_rect().size.y/2))
		if check_coords(destination_coords, d_name):
			break
	position = origin_coords
	x_move = round((destination_coords.x-origin_coords.x)/100)*speed
	y_move = round((destination_coords.y-origin_coords.y)/100)*speed
	if abs(x_move) > 5 or abs(y_move) > 5:
		while abs(x_move) > 5 or abs(y_move) > 5:
			x_move /= 1.2
			y_move /= 1.2

func calculate_rotation(x_diff, y_diff):
	var radians = atan2(y_diff, x_diff)
	return rad2deg(radians)
		
func check_coords(coord, name):
	var node = get_parent().get_node(name)
	var xleft = node.get_global_position().x-(node.get_rect().size.x/2)
	var ytop = node.get_global_position().y-(node.get_rect().size.y/2)
	var tl = Vector2(xleft, ytop)
	var xright= xleft + node.get_rect().size.x
	var ybottom = ytop + node.get_rect().size.y
	var br = Vector2(xright, ybottom)
	

	var image = node.get_texture().get_data()
	image.lock()
	var pixel = image.get_pixelv(coord-tl)
	image.unlock()

	if pixel[3] == 0:
		return false
	else:
		return true

func explode():
	frame = 1
	moving = false
	if settings.get_value("Sound", "sound_on")==true:
		var noise = get_parent().get_node("Bomb").duplicate()
		noise.playing = true
		noise.position = destination_coords
		get_parent().add_child(noise)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if name!="Rocket":
		pastpos_x = position.x
		pastpos_y = position.y
		if position != destination_coords and moving:
			if !get_parent().get_node("MapCamera/Clock/DateTimer").paused:
				speed = get_parent().get_node("MapCamera/Clock/SpeedButton").speed
				rotation_degrees = calculate_rotation(x_move, y_move)
				if destination_coords.x > origin_coords.x and position.x < destination_coords.x:
					if destination_coords.y > origin_coords.y and position.y < destination_coords.y:
						position += Vector2(x_move, y_move)
					elif destination_coords.y < origin_coords.y and position.y > destination_coords.y:
						position += Vector2(x_move, y_move)
					else:
						explode()
				elif destination_coords.x < origin_coords.x and position.x > destination_coords.x:
					if destination_coords.y > origin_coords.y and position.y < destination_coords.y:
						position += Vector2(x_move, y_move)
					elif destination_coords.y < origin_coords.y and position.y > destination_coords.y:
						position += Vector2(x_move, y_move)
					else:
						explode()
				else:
					explode()
		elif position != destination_coords and not moving and frame==0:
			explode()
		else:
			if moving:
				explode()
			if position==destination_coords and frame==0:
				explode()
		if not moving and !get_parent().get_node("MapCamera/Clock/DateTimer").paused:
			countdown -= 1
			if countdown == 0:
				queue_free()
		newpos_x = position.x
		newpos_y = position.y
		if newpos_x == pastpos_x and newpos_y == pastpos_y and frame==0 and !get_parent().get_node("MapCamera/Clock/DateTimer").paused:
			explode()
	else:
		visible = false
