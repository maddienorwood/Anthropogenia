extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cost = 0
var country_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func calculate_cost(index):
	country_name = get_parent().get_node("CountryScroll/CollapseCountryList").countries[index]
	var country = get_parent().get_parent().get_node(country_name)
	if country.gdp_per_cap < 10000:
		return 1000
	else:
		return round(country.gdp_per_cap/10)


func _on_CountryList_item_selected(index):
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
	country_name = get_parent().get_node("CountryScroll/CollapseCountryList").countries[index]
	cost = calculate_cost(index)
	if country_name == "USA" or country_name == "UK" or country_name == "Phillippines":
		bbcode_text = "[center]collapsing the " + country_name + " will cost " + str(calculate_cost(index)) + " CP[/center]" 
	else:
		bbcode_text = "[center]collapsing " + country_name + " will cost " + str(calculate_cost(index)) + " CP[/center]" 
