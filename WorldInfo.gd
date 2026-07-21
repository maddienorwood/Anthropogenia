extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var display_text = ""
var original_pop = 0
var orig_emissions = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	getOrigPop()
	updateWorldInfo()

func getOrigPop():
	var clock = get_parent().get_parent().get_parent().get_node("MapCamera/Clock")
	for country in clock.countries:
		original_pop += get_parent().get_parent().get_parent().get_node(country).population

func toCelsius(temp):
	var celsius1 = 28.0 * (5.0/9.0)
	var celsius2 = ((60.0 + float(temp)) - 32.0) * (5.0/9.0)
	var celsiusInc = celsius2 - celsius1
	return stepify(celsiusInc, 0.01)

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
	
func updateWorldInfo():
	clear()
	display_text = ""
	var clock = get_parent().get_parent().get_parent().get_node("MapCamera/Clock")
	display_text += "[center]"
	display_text += "Temp +: " + format_num(clock.global_temp) + "°F/" + str(toCelsius(clock.global_temp)) + "°C\n\n"
	var total_victims = 0	
	var total_emissions = 0
	var collapsed = 0
	var total_countries = 0
	var total_pop = 0
	
	for country in clock.countries:
		total_victims += get_parent().get_parent().get_parent().get_node(country).victims
		total_emissions += get_parent().get_parent().get_parent().get_node(country).emissions[clock.year]
		total_countries += 1
		total_pop += get_parent().get_parent().get_parent().get_node(country).population
		
		if get_parent().get_parent().get_parent().get_node(country).collapsed:
			collapsed += 1
			
	display_text += "Deaths: " + format_num(round(total_victims)) + "\n\n"
	
	display_text += str(clock.year) + " Emissions: " + format_num(total_emissions) + " metric tons\n\n"
	display_text += "Emissions Change: " + format_num(((float(total_emissions)/float(get_parent().get_parent().get_parent().get_node("MapCamera/Clock").getOrigEmissions()))*100.0)-100.0) + "%\n\n"
	
	if clock.shortage == "":
		display_text += "Shortage: None\n\n"
	else:
		display_text += "Shortage: " + clock.shortage.capitalize() + "\n\n"
		display_text += "Shortage Ends In: " + str(clock.shortage_time) + " months\n\n"
	
	if clock.pandemic == "":
		display_text += "Pandemic: None\n\n"
	else:
		display_text += "Pandemic: " + clock.pandemic + "\n\n"
		display_text += "Pandemic Length: " + str(clock.pandemic_length) + " months\n\n"
		display_text += "Pandemic Cases: " + format_num(round(clock.pandemic_cases)) + "\n\n"
		display_text += "Pandemic Deaths: " + format_num(round(clock.pandemic_deaths)) + "\n\n"
	
	display_text += "Collapsed: " + str(collapsed) + "/" + str(total_countries) + "\n\n"
	display_text += "Population Change: " + format_num(((float(total_pop)/float(original_pop))*100.0)-100.0) + "%\n"

	display_text += "[/center]"
	set_bbcode(display_text)


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
