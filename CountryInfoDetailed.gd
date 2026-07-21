extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var display_text = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func format_num(num):
	var formatted = ""
	num = float(num)
	if num > 1000000000000000000:
		formatted = str(stepify(num/1000000000000000000, 0.01)) + " qntril "
	elif num > 1000000000000000:
		formatted = str(stepify(num/1000000000000000, 0.01)) + " qdril "
	elif num > 1000000000000:
		formatted = str(stepify(num/1000000000000, 0.01)) + " tril "
	elif num > 1000000000:
		formatted = str(stepify(num/1000000000, 0.01)) + " bil "
	elif num > 1000000:
		formatted = str(stepify(num/1000000, 0.01)) + " mil "
	else:
		return str(stepify(num, 0.01))
	return formatted


func _on_CountryList_item_selected(index):
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_parent().get_node("ShortClick").play()
	clear()
	display_text = ""
	var clock = get_parent().get_parent().get_parent().get_node("MapCamera/Clock")
	var country = get_parent().get_parent().get_parent().get_node("MapCamera/Clock").countries[index]
	var node = get_parent().get_parent().get_parent().get_node(country)
	
	display_text += "[center]"
	
	display_text += "\nCollapsed: "
	
	if node.collapsed:
		display_text += "Yes\n\n"
	else:
		display_text += "No\n\n"
		
	if node.borders_open:
		display_text += "Borders Open: Yes\n\n"
	else:
		display_text += "Borders Open: No\n\n"
	
	if len(node.bordering)==0:
		display_text+= "Bordering: None\n\n"
	else:
		display_text += "Bordering:"
		for ind in range(0, len(node.bordering)):
			if ind != (len(node.bordering)-1):
				display_text += " " + node.bordering[ind] + ","
			else:
				display_text += " " + node.bordering[ind] + "\n\n"
	
	if node.landlocked:
		display_text += "Landlocked: Yes\n\n"
	else:
		display_text += "Landlocked: No\n\n"
	
	display_text += "Population: " + format_num(round(node.population)) + "\n\n"
	display_text += "Pop. Growth: " + format_num(node.growth) + "%\n\n"
	display_text += "Land Area: " + format_num(node.land_area) + " sq km\n\n"
	display_text += "Pop. Density: " + format_num(node.density) + "/sq km\n\n"
	display_text += "Emissions (" + str(clock.year) + "): " + format_num(node.emissions[clock.year]) + " mt\n\n"
	display_text += "GDP: $" + format_num(node.gdp) + "\n\n"
	display_text += "GDP/Capita: $" + format_num(node.gdp_per_cap) + "\n\n"
	display_text += "Temp: " + format_num(node.temp) + " °F\n\n"
	display_text += "Avg Temp: " + format_num(node.avg_temp) + " °F\n\n"
	
	display_text += "Stability: "
	if node.stability > 1.5:
		display_text += "Very High\n\n"
	elif node.stability > 0.5:
		display_text += "High\n\n"
	elif node.stability > -.5:
		display_text += "Moderate\n\n"
	elif node.stability > -1.5:
		display_text += "Low\n\n"
	else:
		display_text += "Very Low\n\n"
	
	display_text += "Sick: " + format_num(round(node.diseased)) + "\n\n"
	display_text += "Climate Change Deaths: " + format_num(round(node.victims)) + "\n\n"
	
	if node.disaster!="":
		display_text += "Current Disaster: " + node.disaster + "\n\n"
	display_text += "Total Disasters: " + str(node.disaster_total) + "\n\n"
	display_text += "Current War: "
	
	if node.warring == "":
		display_text += "None\n\n"
	else:
		display_text += node.warring + "\n\n"
		display_text += "War Length: " + str(node.war_ticks) + " mo\n\n"
	
	display_text += "Sustainable Tech Used: "
	
	if len(node.sustainable_tech) == 0:
		display_text += "None\n"
	else:
		for i in range(len(node.sustainable_tech)):
			if i != len(node.sustainable_tech)-1:
				display_text += " " + node.sustainable_tech[i] + ","
			else:
				display_text += " " + node.sustainable_tech[i] + "\n"

	if "composite_countries" in node:
		display_text += "\nCountries:"
		for i in range(len(node.composite_countries)):
			if i==len(node.composite_countries)-1:
				display_text += " " + node.composite_countries[i] + "\n"
			else:
				display_text += " " + node.composite_countries[i] + ","
	
	display_text+= "[/center]"
	
	set_bbcode(display_text)
	
