extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var disaster_deathrates = {"Flood": .0001, "Drought": .00001, "Tornado": .00001, "Hurricane": .0005, "Storm": .0001, "Tsunami": .001, "Earthquake": .001, "Wildfire": .00001, "Landslide": .00005, "Heatwave": .0005, "Blizzard": .0003}
var disaster_costs = {"Flood": 500, "Drought": 100, "Tornado": 100, "Hurricane": 1000, "Storm": 500, "Tsunami": 2500, "Earthquake": 2500, "Wildfire": 100, "Landslide": 250, "Heatwave": 1000, "Blizzard": 750}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
	var clock = get_parent().get_parent().get_node("MapCamera/Clock")
	var selected_country = get_parent().get_node("CountryScroll/CountryList").get_selected_items()[0]
	var country = clock.countries[selected_country]
	var selected_disaster = get_parent().get_node("DisasterScroll/DisasterList").get_selected_items()[0]
	var disaster = clock.disasters[selected_disaster]
	var node = get_parent().get_parent().get_node(country)
	var honker = get_parent().get_parent().get_node("MapCamera/SocialMediaPage/HonkContainer/VHonkContainer")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	node.disaster = disaster
	node.disaster_total += 1
	var old_pop = node.population
	node.population *= 1-disaster_deathrates[node.disaster]
	var deaths = old_pop - node.population
	node.victims += deaths
	honker.new_honk("The nation will remember the " + clock.format_num(round(deaths)) + " people who lost their lives in the recent " + disaster.to_lower() + ". Stay strong, " + country + ".", rng.randi_range(4,63), honker.pres_handles[country])
	if clock.carbon_points >= disaster_costs[disaster]:
		clock.carbon_points -= disaster_costs[disaster]
		var camera = get_parent().get_parent().get_node("MapCamera")
		camera.position.x = 3780
		camera.position.y = 3510
	else:
		get_parent().get_node("NotEnoughCP").popup()
		get_parent().get_node("NotEnoughCP").rect_global_position = rect_global_position
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
