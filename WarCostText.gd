extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cost = 1000
var clock
# Called when the node enters the scene tree for the first time.
func _ready():
	clock = get_parent().get_parent().get_node("MapCamera/Clock")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func calc_cost(node1, node2):
	cost = 1000
	cost += floor(node1.gdp_per_cap/12500)*1000
	cost += floor(node2.gdp_per_cap/12500)*1000
	return cost

func _on_CountryList1_item_selected(index):
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
	var selected_country1 = get_parent().get_node("CountryScroll1/CountryList1").get_selected_items()[0]
	var selected_country2 = get_parent().get_node("CountryScroll2/CountryList2").get_selected_items()[0]
	var country1 = clock.countries[selected_country1]
	var country2 = clock.countries[selected_country2]
	var node1 = get_parent().get_parent().get_node(country1)
	var node2 = get_parent().get_parent().get_node(country2)
	
	if country1==country2:
		bbcode_text = "[center]error: country can't fight itself[/center]"
		set("custom_colors/default_color", Color("#ff0000"))
	else:
		bbcode_text = "[center]war cost: " + str(calc_cost(node1, node2)) + " CP[/center]"
		set("custom_colors/default_color", Color("#ffffff"))
		
func _on_CountryList2_item_selected(index):
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
	var selected_country1 = get_parent().get_node("CountryScroll1/CountryList1").get_selected_items()[0]
	var selected_country2 = get_parent().get_node("CountryScroll2/CountryList2").get_selected_items()[0]
	var country1 = clock.countries[selected_country1]
	var country2 = clock.countries[selected_country2]
	var node1 = get_parent().get_parent().get_node(country1)
	var node2 = get_parent().get_parent().get_node(country2)
	
	if country1==country2:
		bbcode_text = "[center]error: country can't fight itself[/center]"
		set("custom_colors/default_color", Color("#ff0000"))
	else:
		bbcode_text = "[center]war cost: " + str(calc_cost(node1, node2)) + " CP[/center]"
		set("custom_colors/default_color", Color("#ffffff"))
