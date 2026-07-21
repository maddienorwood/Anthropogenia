extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var country_name = "Australia"
var population = 28856134
var growth = 0.1054
var land_area = 7763562
var density = 3.7
var emissions = {1990: 546.23, 1995: 563.25, 2000: 656.09, 2005: 594.34, 2010: 600.29, 2015: 553.2, 2020: 656.88}
var gdp = 1560970683405.60
var gdp_per_cap = 54124.74
var temp = 70.71
var stability = 0.85
var collapsed = false
var diseased = 0.0
var victims = 0
var disasters = []
var sustainable_tech = []
var warring = []
var composite_countries = ["Australia", "Fiji", "Kiribati", "Nauru", "New Caledonia", "Samoa", "Solomon Islands", "Tonga", "Tuvalu", "Vanuatu", "Wallis and Futuna"]
signal touched

func _input(event):
	if event is InputEventScreenTouch:
		var target = get_canvas_transform().affine_inverse().xform(event.position)
		if event.pressed and getCurrentFrameRect().has_point(to_local(target)):
				var image = self.get_texture().get_data()
				image.lock()
				var pixel = image.get_pixel(200, 200)
				print(pixel)
				var world_map = get_parent()
				world_map.touched = self
				emit_signal("touched")


func getCurrentFrameRect() -> Rect2:
	var size = self.get_texture().get_size()
	var pos = offset
	if centered:
		pos -= 0.5 * size
	return Rect2(pos, size)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
