extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
	var clock = get_parent().get_parent().get_node("MapCamera/Clock")
	if clock.carbon_points > get_parent().get_node("ShortageCostText").cost:
		clock.carbon_points -= get_parent().get_node("ShortageCostText").cost
		var shortage_ind = get_parent().get_node("ShortageScroll/ShortageList").get_selected_items()[0]
		var shortage = clock.shortages[shortage_ind]
		clock.new_shortage(shortage, int(get_parent().get_node("ShortageLengthLabel").text) * 12)
		var camera = get_parent().get_parent().get_node("MapCamera")
		camera.position.x = 3780
		camera.position.y = 3510
	else:
		get_parent().get_node("NotEnoughCP").popup()
		get_parent().get_node("NotEnoughCP").rect_global_position = rect_global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
