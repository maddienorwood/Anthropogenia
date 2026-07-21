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
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var collapse_messages = ["Will they recover? It remains to be seen.", "Countless civilians will likely soon perish.", "Like dominos, other countries may be soon to follow.", "Make sure to follow @NewsBreak for the latest updates.", "Like and rehonk to show your support!"]
	var honker = get_parent().get_parent().get_node("MapCamera/SocialMediaPage/HonkContainer/VHonkContainer")
	if clock.carbon_points > get_parent().get_node("CollapseCostText").cost:
		clock.carbon_points -= get_parent().get_node("CollapseCostText").cost
		var name = get_parent().get_node("CollapseCostText").country_name
		var node = get_parent().get_parent().get_node(name)
		honker.new_honk(node.name + " has collapsed into anarchy. " + collapse_messages[rng.randi_range(0,4)], 3, "NewsBreak")
		node.collapsed = true
		node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
		var camera = get_parent().get_parent().get_node("MapCamera")
		camera.position.x = 3780
		camera.position.y = 3510
	else:
		get_parent().get_node("NotEnoughCP").popup()
		get_parent().get_node("NotEnoughCP").rect_global_position = rect_global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
