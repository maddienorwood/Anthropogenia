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
	var selected_country1 = get_parent().get_node("CountryScroll1/CountryList1").get_selected_items()[0]
	var selected_country2 = get_parent().get_node("CountryScroll2/CountryList2").get_selected_items()[0]
	var country1 = clock.countries[selected_country1]
	var country2 = clock.countries[selected_country2]
	var node1 = get_parent().get_parent().get_node(country1)
	var node2 = get_parent().get_parent().get_node(country2)
	
	if clock.carbon_points >= get_parent().get_node("WarCostText").cost:
		node1.warring = country2
		node2.warring = country1
		var honker = get_parent().get_parent().get_node("MapCamera/SocialMediaPage/HonkContainer/VHonkContainer")
		honker.new_honk(country1 + " has declared war on " + country2 + ".", 3, "NewsBreak")
		node1.war_ticks = 0
		node2.war_ticks = 0
		clock.carbon_points -= get_parent().get_node("WarCostText").cost
		var camera = get_parent().get_parent().get_node("MapCamera")
		camera.position.x = 3780
		camera.position.y = 3510
	else:
		get_parent().get_node("NotEnoughCP").popup()
		get_parent().get_node("NotEnoughCP").rect_global_position = rect_global_position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
