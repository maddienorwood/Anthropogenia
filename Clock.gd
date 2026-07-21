extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var config = ConfigFile.new()
var perm_stats = ConfigFile.new()
var pausebutton = load("res://assets/pausebutton.png")
var continuebutton = load("res://assets/continuebutton.png")
var tog = 1
var year = 2020
var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
var month_ind = 1
var top_temps = [-24, -16, -8, 0, 8, 16, 24, 16, 8, 0, -8, -16]
var med_temps = [-12, -8, -4, 0, 4, 8, 12, 8, 4, 0, -4, -8]
var bot_temps = [24, 16, 8, 0, -8, -16, -24, -16, -8, 0, 8, 16]
var countries = ["Argentina", "Australia", "Bolivia", "Brazil", "Canada", "Central Africa", "Central America", "Central Asia", "Chile", "China", "Eastern Europe", "Finland", "Greenland", "Iceland", "India", "Indonesia", "Iran", "Ireland", "Japan", "Kazakhstan", "Korea", "Madagascar", "Malaysia", "Mexico", "Mongolia", "New Zealand", "Northeast Africa", "Northwest Africa", "Norway", "Papua New Guinea", "Paraguay", "Peru", "Phillippines", "Russia", "N South America", "South Asia", "Southern Africa", "Sweden", "UK", "USA", "Uruguay", "West Asia", "West Europe"]
var sustainable_tech_opts = ["Solar panels", "Carbon tax", "Wind farm"]
var sustainable_tech = []
var disasters = ["Flood", "Drought", "Tornado", "Hurricane", "Storm", "Tsunami", "Earthquake", "Wildfire", "Landslide", "Heatwave", "Blizzard"]
var disaster_deathrates = {"Flood": .0001, "Drought": .00001, "Tornado": .00001, "Hurricane": .0005, "Storm": .0001, "Tsunami": .001, "Earthquake": .001, "Wildfire": .00001, "Landslide": .00005, "Heatwave": .0005, "Blizzard": .0003}
var global_temp = 1.8
var temp_inc = 0
var pandemic = ""
var pandemic_length = 0
var pandemic_deaths = 0
var pandemic_cases = 0
var virus_names = ["Pandapox", "Squirrelpox", "Squidpox", "Giraffepox", "Lionpox", "Catpox", "Tunapox", "Leopardpox", "Goldfishpox", "Spiderpox", "Pigpox"]
var virus_deadliness = 0
var carbon_points = 0
var shortage = ""
var shortage_time = 0
var shortages = ["grain", "toilet paper", "fruits", "vegetables", "chicken", "beef", "fish", "soda", "fast fashion", "graphics cards"]
var shortage_begin_messages = {"grain": ". A significant portion of the world perishes as many food products can't be produced.", "toilet paper": ". Many people die as diseases spread due to poor hygiene. TP hoarders become local overlords.", "fruits": ". Many people die. Pie manufacturers close their doors.", "vegetables": ". Massive numbers of people perish and obesity rates triple.", "chicken": ". Many people die, but most switch to other forms of sustenance. The vegetarian population rises.", "beef": ". Small numbers of people die, as other meats are still regularly available. Fast food restaurants close.", "fish": ". Countless people die, including many on island nations.", "soda": ". A very small number of people addicted to soda die. The rest of the world becomes more healthy.", "fast fashion": ". A few people die in demolition accidents at factories. Nations turn to locally-produced clothing.", "graphics cards": ". Robots kill a few people because they want new GPUs. Technological development stalls."}
var shortage_death_rate = {"grain": .01, "toilet paper": .001, "fruits": .01, "vegetables": .02, "chicken": .02, "beef": .005, "fish": .01, "soda": .0001, "fast fashion": .00001, "graphics cards": .00001}
var shortage_begin_message = "The world is running low on "
var shortage_end_message_1 = "Supplies of "
var shortage_end_message_2 = " have returned to normal."
var pandemic_end = {0: ["While annoying, the virus was little more than a cold.", "The days of sore throats and stuffy noses have come to an end.", "Tissue manufacturers will be displeased."], 1: ["Few perished, but the virus still killed many of the most vulnerable.", "The virus took over the globe, but was far from deadly for most.", "Many still claim the virus was just a cold, despite the many deaths."], 2: ["The devastation caused by the virus will be felt for years.", "The global impact of this virus will be forever written in the history books.", "Is this the last great pandemic of the 21st century?"], 3: ["While extremely fatal, the virus luckily affected few.", "Almost all who came into contact with the virus died, limiting its spread.", "The world breathes a sigh of relief."]}
var total_victims = 0
var rocket_num = 0
var origpops = {"Argentina": 46245668, "Australia": 28856134, "Bolivia": 12054379, "Brazil": 217240060, "Canada": 38237850, "Central Africa": 489612096, "Central America": 78942174, "Central Asia": 333202610, "Chile": 18430408, "China": 1410539758, "Eastern Europe": 195365626, "Finland": 5601547, "Greenland": 57792, "Iceland": 357603, "India": 1389637446, "Indonesia": 277329163, "Iran": 86758304, "Ireland": 5275004, "Japan": 124214766, "Kazakhstan": 19398331, "Korea": 77799972, "Madagascar": 28172462, "Malaysia": 33871431, "Mexico": 129150971, "Mongolia": 3227863, "New Zealand": 5061132, "Northeast Africa": 192727494, "Northwest Africa": 512947652, "Norway": 5553840, "Papua New Guinea": 9593498, "Paraguay": 7356409, "Peru": 32275736, "Phillippines": 114597229, "Russia": 142021981, "N South America": 110959213, "South Asia": 515798992, "Southern Africa": 188874419, "Sweden": 10483647, "UK": 67791400, "USA": 337556483, "Uruguay": 3407213, "West Asia": 282002573, "West Europe": 316748567}

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
		return str(num)
	return formatted

func end_pandemic():
	pandemic_deaths = 0
	pandemic_cases = 0
	for country in countries:
		var node = get_parent().get_parent().get_node(country)
		if not node.collapsed:
			node.texture = load("res://assets/countries/" + node.sprite_name + "1.png")
		else:
			node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
		node.diseased = 0

func update_pandemic():
	if pandemic_length == 3:
		var honker = get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer")
		honker.new_honk("Scientists have identified " + format_num(round(pandemic_cases)) + " cases of a new virus they've coined " + pandemic + ". Little is known about it so far. Stay tuned for further updates.", 3, "NewsBreak")
	for country in countries:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var node = get_parent().get_parent().get_node(country)
		if node.diseased>1:
			if !node.collapsed:
				node.texture = load("res://assets/countries/" + node.sprite_name + "_sick.png")
			else:
				node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
			for bordering_country in node.bordering:
				var border_node = get_parent().get_parent().get_node(bordering_country)
				if border_node.diseased == 0 and border_node.borders_open and rng.randi_range(1,4)==1:
					border_node.diseased = 1
					pandemic_cases += 1
				elif border_node.diseased == 0 and rng.randi_range(1,15)==1:
					border_node.diseased = 1
					pandemic_cases += 1
			if virus_deadliness == 3:
				var virus_deaths = node.diseased * (1/(2*rng.randf_range(.8,1.2)))
				var old_diseased = node.diseased
				node.diseased *= 2 + rng.randf_range(-.2,.2)
				pandemic_cases += (node.diseased - old_diseased)
				node.diseased -= virus_deaths
				pandemic_deaths += virus_deaths
			elif virus_deadliness == 2:
				var virus_deaths = node.diseased * (1/(6*rng.randf_range(.8,1.2)))
				var old_diseased = node.diseased
				node.diseased *= 3 + rng.randf_range(-.2,.2) 
				pandemic_cases += (node.diseased - old_diseased)
				node.diseased -= virus_deaths
				pandemic_deaths += virus_deaths
			elif virus_deadliness == 1:
				var virus_deaths = node.diseased * (1/(24*rng.randf_range(.8,1.2)))
				var old_diseased = node.diseased
				node.diseased *= 4 + rng.randf_range(-.2,.2) 
				pandemic_cases += (node.diseased - old_diseased)
				node.diseased -= virus_deaths
				pandemic_deaths += virus_deaths
			elif virus_deadliness == 0:
				var virus_deaths = node.diseased * (1/(250*rng.randf_range(.8,1.2)))
				var old_diseased = node.diseased
				node.diseased *= 5 + rng.randf_range(-.2,.2)
				pandemic_cases += (node.diseased - old_diseased)
				node.diseased -= virus_deaths
				pandemic_deaths += virus_deaths
			
			node.diseased *= .9
			node.diseased = round(node.diseased)
			
			if node.diseased/node.population>=.2:
				node.borders_open = false
			else:
				node.borders_open = true
		elif node.diseased == 1:
			if !node.collapsed:
				node.texture = load("res://assets/countries/" + node.sprite_name + "_sick.png")
			else:
				node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
			if virus_deadliness == 3:
				var old_diseased = node.diseased
				node.diseased *= 2 + rng.randf_range(-.2,.2)
				pandemic_cases += (node.diseased - old_diseased)
				var virus_deaths = node.diseased * (1/(2*rng.randf_range(.8,1.2)))
				node.population -= virus_deaths
				node.victims += virus_deaths
				pandemic_deaths += virus_deaths
			elif virus_deadliness == 2:
				var old_diseased = node.diseased
				node.diseased *= 3 + rng.randf_range(-.2,.2) 
				pandemic_cases += (node.diseased - old_diseased)
				var virus_deaths = node.diseased * (1/(6*rng.randf_range(.8,1.2)))
				node.population -= virus_deaths
				node.victims += virus_deaths
				pandemic_deaths += virus_deaths
			elif virus_deadliness == 1:
				var old_diseased = node.diseased
				node.diseased *= 4 + rng.randf_range(-.2,.2) 
				pandemic_cases += (node.diseased - old_diseased)
				var virus_deaths = node.diseased * (1/(24*rng.randf_range(.8,1.2)))
				node.population -= virus_deaths
				node.victims += virus_deaths
				pandemic_deaths += virus_deaths
			elif virus_deadliness == 0:
				var old_diseased = node.diseased
				node.diseased *= 5 + rng.randf_range(-.2,.2) 
				pandemic_cases += (node.diseased - old_diseased)
				var virus_deaths = node.diseased * (1/(250*rng.randf_range(.8,1.2)))
				node.population -= virus_deaths
				node.victims += virus_deaths
				pandemic_deaths += virus_deaths
			
			if node.diseased/node.population>=.2:
				node.borders_open = false
		else:
			if virus_deadliness == 3:
				if rng.randi_range(1,25)==1:
					node.diseased = 1
					if !node.collapsed:
						node.texture = load("res://assets/countries/" + node.sprite_name + "_sick.png")
					else:
						node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
					pandemic_cases += 1
			elif virus_deadliness == 2:
				if rng.randi_range(1,20)==1:
					node.diseased = 1
					if !node.collapsed:
						node.texture = load("res://assets/countries/" + node.sprite_name + "_sick.png")
					else:
						node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
					pandemic_cases += 1
			elif virus_deadliness == 1:
				if rng.randi_range(1,15)==1:
					node.diseased = 1
					if !node.collapsed:
						node.texture = load("res://assets/countries/" + node.sprite_name + "_sick.png")
					else:
						node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
					pandemic_cases += 1
			else:
				if rng.randi_range(1,10)==1:
					node.diseased = 1
					if !node.collapsed:
						node.texture = load("res://assets/countries/" + node.sprite_name + "_sick.png")
					else:
						node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
					pandemic_cases += 1

func new_pandemic(country):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	pandemic = virus_names[rng.randi_range(0,len(virus_names)-1)]
	var node = get_parent().get_parent().get_node(country)
	node.diseased = 1
	if !node.collapsed:
		node.texture = load("res://assets/countries/" + node.sprite_name + "_sick.png")
	else:
		node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
	pandemic_cases = 1
	virus_deadliness = rng.randi_range(0,3)

func new_user_pandemic(name, deadliness, country):
	pandemic = name
	var node = get_parent().get_parent().get_node(country)
	node.diseased = 1
	if !node.collapsed:
		node.texture = load("res://assets/countries/" + node.sprite_name + "_sick.png")
	else:
		node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
	pandemic_cases = 1
	virus_deadliness = deadliness
	
func getOrigEmissions():
	var orig_emissions = 0
	for country in countries:
		orig_emissions += get_parent().get_parent().get_node(country).emissions[2020]
	return orig_emissions

func getTotalEmissions():
	var total_emissions = 0
	for country in countries:
		total_emissions += get_parent().get_parent().get_node(country).emissions[year]
	return total_emissions
	
func updateGlobalTemp():
	var orig_emissions = getOrigEmissions()
	var total_emissions = getTotalEmissions()
	var percent = total_emissions/orig_emissions
	var orig_temp = global_temp
	var base_inc = .32/10/12
	if percent > 2:
		global_temp += base_inc*2
	elif percent > 1.5:
		global_temp += base_inc*1.5
	elif percent > 1.2:
		global_temp += base_inc*1.2
	elif percent > 1:
		global_temp += base_inc*1
	elif percent > .75:
		global_temp += base_inc*.5
	elif percent > .5:
		global_temp += base_inc*.25
	elif percent > .25:
		global_temp -= base_inc*.25
	else:
		global_temp -= base_inc*.5
		
	temp_inc = global_temp - orig_temp
	
	updateAvgs(temp_inc)

func new_war(country, node):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var honker = get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer")
	var warring = node.bordering[rng.randi_range(0,len(node.bordering)-1)]
	var war_node = get_parent().get_parent().get_node(warring)
	if war_node.warring=="":
		node.warring = warring
		honker.new_honk(country + " has declared war on " + warring + ".", 3, "NewsBreak")
		war_node.warring = node.name

func updateAvgs(inc):
	for country in countries:
		var node = get_parent().get_parent().get_node(country)
		node.avg_temp += inc

func updateCountries():
	var honker = get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer")
	for country in countries:
		var node = get_parent().get_parent().get_node(country)
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var oldpop = node.population
		
		#1/200 chance or higher for wealthy countries to create new sustainable tech
		if (len(node.sustainable_tech) < len(sustainable_tech_opts)) and node.gdp_per_cap >= 25000 and rng.randi_range(1,(200-round((node.gdp_per_cap-25000)/5000))):
			var tech = sustainable_tech_opts[rng.randi_range(0,len(sustainable_tech_opts)-1)]
			node.sustainable_tech.append(tech)
		#Gives poor countries a 1/200 chance to adopt sustainable tech
		elif node.gdp_per_cap < 25000 and rng.randi_range(1,200)==1:
			if len(node.sustainable_tech) < len(sustainable_tech) and len(sustainable_tech)>0:
				node.sustainable_tech.append(sustainable_tech[rng.randi_range(0,len(sustainable_tech)-1)])
				node.gdp *= 0.98
		
		#Resets disasters then adds a new disaster depending on RNG
		node.disaster = ""
		var new_disaster = false
		rng.randomize()
		
		if !get_parent().get_parent().interact:
			if global_temp < 2:
				if rng.randi_range(1,300)==1:
					new_disaster = true
			elif global_temp <4:
				if rng.randi_range(1,100)==1:
					new_disaster = true
			else:
				if rng.randi_range(1,50)==1:
					new_disaster = true
		else:
			if global_temp < 2:
				if rng.randi_range(1,900)==1:
					new_disaster = true
			elif global_temp <4:
				if rng.randi_range(1,300)==1:
					new_disaster = true
			else:
				if rng.randi_range(1,150)==1:
					new_disaster = true
		
		if new_disaster:
			if node.temp >= 90:
				if rng.randi_range(1,3)==1:
					node.disaster = "Heatwave"
				elif rng.randi_range(1,3)==1:
					node.disaster = "Drought"
				elif rng.randi_range(1,3)==1:
					node.disaster = "Wildfire"
			elif node.temp <=40:
				if rng.randi_range(1,2)==1:
					node.disaster = "Blizzard"
			elif not node.landlocked:
				if rng.randi_range(1,10)==1:
					node.disaster = "Tsunami"
			if node.disaster=="":
				var switch = rng.randi_range(1,6)
				if switch==1:
					node.disaster = "Flood"
				elif switch==2:
					node.disaster = "Tornado"
				elif switch==3:
					node.disaster = "Earthquake"
				elif switch==4:
					node.disaster = "Landslide"
				else:
					node.disaster = "Storm"
			if node.disaster!="":
				var old_pop = node.population
				node.population *= 1-disaster_deathrates[node.disaster]
				rng.randomize()
				var deaths = old_pop - node.population
				node.victims += deaths
				if deaths > 50000:
					honker.new_honk("The nation will remember the " + format_num(round(deaths)) + " people who lost their lives in the recent " + node.disaster.to_lower() + ". Stay strong, " + country + ".", rng.randi_range(4,63), honker.pres_handles[country])
		
		if pandemic_length == 0 and pandemic=="" and node.density>100 and node.gdp_per_cap<15000:
			if rng.randi_range(1,500)<=global_temp and !get_parent().get_parent().interact:
				new_pandemic(node.country_name)
		
		
		#Handles wars
		
		if node.warring=="" and node.gdp_per_cap < 10000:
			if get_parent().get_parent().interact:
				if rng.randi_range(1,2500)==1:
					if len(node.bordering)>0:
						new_war(country, node)
			else:
				if rng.randi_range(1,1000)==1:
					if len(node.bordering)>0:
						new_war(country, node)
					else:
						var fight_country = countries[rng.randi_range(0, len(countries)-1)]
						var fight_node = get_parent().get_parent().get_node(fight_country)
						if fight_node.warring=="":
							node.warring = fight_country
							honker.new_honk(country + " has declared war on " + fight_country + ".", 3, "NewsBreak")
							fight_node.warring = node.name
		elif node.warring=="" and node.gdp_per_cap < 50000 and node.gdp_per_cap >= 10000:
			if get_parent().get_parent().interact:
				if rng.randi_range(1,5000)==1:
					if len(node.bordering)>0:
						new_war(country, node)
			else:
				if rng.randi_range(1,2500)==1:
					if len(node.bordering)>0:
						new_war(country, node)
					else:
						var fight_country = countries[rng.randi_range(0, len(countries)-1)]
						var fight_node = get_parent().get_parent().get_node(fight_country)
						if fight_node.warring=="":
							node.warring = fight_country
							honker.new_honk(country + " has declared war on " + fight_country + ".", 3, "NewsBreak")
							fight_node.warring = node.name
		elif node.warring=="" and node.gdp_per_cap >= 50000:
			if get_parent().get_parent().interact:
				if rng.randi_range(1,10000)==1:
					if len(node.bordering)>0:
						new_war(country, node)
			else:
				if rng.randi_range(1,5000)==1:
					if len(node.bordering)>0:
						new_war(country, node)
					else:
						var fight_country = countries[rng.randi_range(0, len(countries)-1)]
						var fight_node = get_parent().get_parent().get_node(fight_country)
						if fight_node.warring=="":
							node.warring = fight_country
							honker.new_honk(country + " has declared war on " + fight_country + ".", 3, "NewsBreak")
							fight_node.warring = node.name
		elif node.warring!="":
			if node.next_missile > 0:
				node.next_missile -= 1
			else:
				var new_missile = get_parent().get_parent().get_node("Rocket").duplicate()
				new_missile.name = "Rocket_" + str(rocket_num)
				new_missile.origin = node.name
				new_missile.destination = node.warring
				get_parent().get_parent().add_child(new_missile)
				get_parent().get_parent().move_child(new_missile, 45)
				get_parent().get_parent().get_node(new_missile.name).visible = true
				node.next_missile = 3
				rocket_num += 1
			
			node.war_ticks+=1
			if node.war_ticks < 48:
				var origpop = node.population
				node.population *= .995 * rng.randf_range(.98,1.0)
				node.victims += origpop - node.population
				node.gdp *= .997 * rng.randf_range(.98,1.0)
			else:
				honker.new_honk("The war between " + node.name + " and " + node.warring + " has ended.", 3, "NewsBreak")
				var warring = get_parent().get_parent().get_node(node.warring)
				warring.warring = ""
				warring.war_ticks = 0
				node.warring = ""
				node.war_ticks = 0
		
		#Handles country stability
		if !node.collapsed:
			if node.warring!="":
				node.stability -= .02
			else:
				node.stability += .01
			if node.disaster != "":
				node.stability -= .02
			if node.population/origpops[node.name] > 1.8 or node.population/origpops[node.name] < 0.2:
				node.stability -= .05
			elif node.population/origpops[node.name] > 1.6 or node.population/origpops[node.name] < 0.4:
				node.stability -= .03
			elif node.population/origpops[node.name] > 1.4 or node.population/origpops[node.name] < 0.6:
				node.stability -= .02
			elif node.population/origpops[node.name] > 1.2 or node.population/origpops[node.name] < 0.8:
				node.stability -= .01
		elif node.collapsed and node.stability > -2.5:
			node.stability = -2.5

		
		if node.position.y<780:
			node.temp = node.avg_temp + top_temps[month_ind]
		elif node.position.y > 1560:
			node.temp = node.avg_temp + bot_temps[month_ind]
		else:
			node.temp = node.avg_temp + med_temps[month_ind]
		
		#Collapses countries
		if !node.collapsed and node.stability < 0 and rng.randf_range(-2.5, -0.01)>node.stability:
			if rng.randi_range(1,500)==1:
				rng.randomize()
				var collapse_messages = ["Countless civilians will likely soon perish.", "Stock prices have dropped as a result of the news.", "Like dominos, other countries may be soon to follow.", "Make sure to follow @NewsBreak for the latest updates.", "Like and rehonk to show your support!"]
				honker.new_honk(node.name + " has collapsed into anarchy. " + collapse_messages[rng.randi_range(0,4)], 3, "NewsBreak")
				node.collapsed = true
				node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")

				
		#Handles GDP
		if node.disaster=="" and node.warring=="" and node.diseased==0 and !node.collapsed:
			node.gdp = node.gdp*(1+((node.growth/1200)*rng.randf_range(1.00,1.02)))
		elif !node.collapsed:
			node.gdp = node.gdp*(1+(node.growth/1200))
		else:
			node.gdp = node.gdp*(.99*rng.randf_range(.97,1.00))
		
		#Handles growth
		if node.collapsed:
			node.growth = -.2
		elif node.gdp_per_cap < 50000:
			node.growth = 0
		else:
			node.growth = -.01
		
		if node.population >0:
			var origpop = node.population
			if !node.collapsed:
				node.population *= 1+(node.growth/1200)
				node.population = round(node.population)
			else:
				node.population *= 1+(node.growth/120)
				node.population = round(node.population)
			if node.population < 0:
				node.population = 0
			if origpop-node.population > 0:
				node.victims += origpop - node.population
			node.density = round(node.population/node.land_area)
			node.gdp_per_cap = node.gdp/node.population
		else:
			node.population = 0
			node.collapsed = true
			node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
			node.density = 0
			node.gdp_per_cap = 0
	

func _on_PauseButton_pressed():
	var pause_button = get_node("PauseButton")
	var timer = get_node("DateTimer")
	
	if tog == 1:
		timer.paused = true
		pause_button.texture_pressed = pausebutton
		pause_button.texture_normal = continuebutton
		tog = 2
	else:
		timer.paused = false
		pause_button.texture_pressed = continuebutton
		pause_button.texture_normal = pausebutton
		tog = 1

func new_shortage(item, length):
	shortage = item
	shortage_time = length
	var honker = get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer")
	honker.new_honk(shortage_begin_message + shortage + shortage_begin_messages[shortage], 3, "NewsBreak")
	update_shortage()

func update_shortage():
	if shortage_time > 0:
		for country in countries:
			var node = get_parent().get_parent().get_node(country)
			var origpop = node.population
			node.population *= 1-shortage_death_rate[shortage]
			node.victims += origpop - node.population
		shortage_time -= 1
	if shortage_time==0 and shortage!="":
		var honker = get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer")
		honker.new_honk(shortage_end_message_1 + shortage + shortage_end_message_2, 3, "NewsBreak")
		shortage = ""

func update_emissions(year):
	for country in countries:
		var node = get_parent().get_parent().get_node(country)
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		#Handles emissions increases/decreases
		if len(node.sustainable_tech) == 0:
			node.emissions[year] = node.emissions[year-1]*rng.randf_range(1.00,1.02)
		else:
			node.emissions[year] = node.emissions[year-1]*(1-(.005*len(node.sustainable_tech)))

func getTotalVictims():
	var total_victims = 0
	for country in countries:
		total_victims += get_parent().get_parent().get_node(country).victims
	return total_victims

func updateCP(diff):
	if diff < 50000:
		carbon_points += 5
	elif diff < 500000:
		carbon_points += 20
	elif diff < 1000000:
		carbon_points += 50
	elif diff < 10000000:
		carbon_points += 100
	elif diff < 50000000:
		carbon_points += 150
	else:
		carbon_points += 200

func checkPopChange():
	var original_pop = get_parent().get_parent().get_node("WorldBG/ScrollContainer/WorldInfo").original_pop
	var total_pop = 0
	var final_total_vics = 0
	var total_emissions = 0
	for country in countries:
		var node = get_parent().get_parent().get_node(country)
		final_total_vics += node.victims
		total_emissions += node.emissions[year]
		total_pop += node.population
	var score = floor((1-(float(total_pop)/float(original_pop)))*100000.0)
	return score

func getFinalScore():
	var original_pop = get_parent().get_parent().get_node("WorldBG/ScrollContainer/WorldInfo").original_pop
	var final_total_vics = 0
	var total_emissions = 0
	var total_pop = 0
	for country in countries:
		var node = get_parent().get_parent().get_node(country)
		final_total_vics += node.victims
		total_emissions += node.emissions[year]
		total_pop += node.population
	var score = floor((1-(float(total_pop)/float(original_pop)))*100000.0)
	#if score < 0:
	#	score = 0
	return score

func checkWin():
	var highscores = ConfigFile.new()
	var err = highscores.load("user://scores.cfg")
	var existingScores = true
	var score = getFinalScore()
	var achievement_node = get_parent().get_parent().get_node("StatsBG/AchievementsScroll/AchievementsList")
	if err != OK:
		existingScores = false
	if existingScores and highscores.has_section("Highscores"):
		var num_games = 0
		var score1 = highscores.get_value("Highscores", "score1")
		var score2 = highscores.get_value("Highscores", "score2")
		var score3 = highscores.get_value("Highscores", "score3")
		if highscores.has_section_key("Highscores", "num_games"):
			num_games = highscores.get_value("Highscores", "num_games")
		highscores.set_value("Highscores", "place", 4)

		if score > score1:
			highscores.set_value("Highscores", "score1", score)
			highscores.set_value("Highscores", "score2", score1)
			highscores.set_value("Highscores", "score3", score2)
			highscores.set_value("Highscores", "place", 1)
		elif score > score2:
			highscores.set_value("Highscores", "score2", score)
			highscores.set_value("Highscores", "score3", score2)
			highscores.set_value("Highscores", "place", 2)
		elif score > score3:
			highscores.set_value("Highscores", "score3", score)
			highscores.set_value("Highscores", "place", 3)
		highscores.set_value("Highscores", "new_score", score)
		
		highscores.set_value("Highscores", "total_victims", getTotalVictims())
		num_games += 1
		highscores.set_value("Highscores", "num_games", num_games)
		
	else:
		highscores.set_value("Highscores", "score1", score)
		highscores.set_value("Highscores", "score2", 0)
		highscores.set_value("Highscores", "score3", 0)
		highscores.set_value("Highscores", "new_score", score)
		highscores.set_value("Highscores", "num_games", 1)
		highscores.set_value("Highscores", "place", 1)
		highscores.set_value("Highscores", "total_victims", total_victims)
	
	if score > 80000:
		highscores.set_value("Highscores", "won", true)
		
		if existingScores and highscores.has_section_key("Highscores", "num_games_won"):
			var num_games_won = highscores.get_value("Highscores", "num_games_won")
			num_games_won += 1
			highscores.set_value("Highscores", "num_games_won", num_games_won)
			
			if num_games_won == 10:
				achievement_node.add_achievement("Champion")
		else:
			highscores.set_value("Highscores", "num_games_won", 1)
	else:
		highscores.set_value("Highscores", "won", false)
		achievement_node.add_achievement("Good Samaritan")
	
		if existingScores and highscores.has_section_key("Highscores", "num_games_won"):
			pass
		else:
			highscores.set_value("Highscores", "num_games_won", 0)

	highscores.save("user://scores.cfg")
	

func _on_DateTimer_timeout():
	var orig_vics = getTotalVictims()
	var date = get_node("Date")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	if date.text == "Dec 2099":
		checkWin()
		get_tree().change_scene("res://EndGame.tscn")
	
	#Handles random shortages
		
	if !get_parent().get_parent().interact:
		if rng.randi_range(1,250)==1:
			new_shortage(shortages[rng.randi_range(0,9)], rng.randi_range(6,24))
	else:
		if rng.randi_range(1,2500)==1:
			new_shortage(shortages[rng.randi_range(0,9)], rng.randi_range(6,24))
	
	if month_ind!=11:
		date.text = months[month_ind] + " " + str(year)
		month_ind+=1
		updateCountries()
		if pandemic!="":
			pandemic_length+=1
			update_pandemic()
		if pandemic_length>=12:
			var honker = get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer")
			
			if rng.randi_range(1,3)==1:
				honker.new_honk(pandemic + " has ended. " + pandemic_end[virus_deadliness][rng.randi_range(0,2)] + " Cases: " + format_num(round(pandemic_cases)) + " Deaths: " + format_num(round(pandemic_deaths)), 3, "NewsBreak")
				pandemic=""
				pandemic_length = 0
				end_pandemic()
	else:
		date.text = months[month_ind] + " " + str(year)
		month_ind = 0
		year+=1
		update_emissions(year)
		updateCountries()
		if pandemic!="":
			pandemic_length+=1
			update_pandemic()
		if pandemic_length==12:
			var honker = get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer")
			rng.randomize()
			honker.new_honk(pandemic + " has ended. " + pandemic_end[virus_deadliness][rng.randi_range(0,2)] + " Cases: " + format_num(round(pandemic_cases)) + " Deaths: " + format_num(round(pandemic_deaths)), 3, "NewsBreak")
			pandemic=""
			pandemic_length = 0
			end_pandemic()
	var new_vics = getTotalVictims()
	updateCP(new_vics-orig_vics)
	update_shortage()
	updateGlobalTemp()
	saveTime()
	saveHonks()
	saveGlobalInfo()
	saveCountryInfo()
	saveStats()
	savePermStats()
	saveSettings()
	checkAchievements()
	config.save("user://save.cfg")
	perm_stats.save("user://perm_stats.cfg")
	
	var permstats = ConfigFile.new()
	

func checkAchievements():
	var achievement_node = get_parent().get_parent().get_node("StatsBG/AchievementsScroll/AchievementsList")
	
	#Check Dictator
	var total = 0
	var collapsed = 0
	for country in countries:
		var node = get_parent().get_parent().get_node(country)
		if node.collapsed:
			collapsed += 1
		total += 1
		
	if collapsed == total and total != 0:
		achievement_node.add_achievement("Dictator")
	
	#Check Hater
	var honker = get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer")
	var hate_honks = 0
	for honk in honker.all_honks:
		if honker.all_honks[honk][0] in honker.hater_honks:
			hate_honks += 1
	if hate_honks >= 100:
		achievement_node.add_achievement("Hater")
	
	#Check Speedy Gonzales
	var original_pop = get_parent().get_parent().get_node("WorldBG/ScrollContainer/WorldInfo").original_pop
	var current_total_vics = 0
	var total_emissions = 0
	var total_pop = 0
	for country in countries:
		var node = get_parent().get_parent().get_node(country)
		current_total_vics += node.victims
		total_emissions += node.emissions[year]
		total_pop += node.population
	var score = floor((1-(float(total_pop)/float(original_pop)))*100000.0)
	if score >= 80000 and get_parent().get_parent().get_node("StatsBG/Stats").seconds <= 300:
		achievement_node.add_achievement("Speedy Gonzales")

			
func saveStats():
	config.set_value("Stats", "Seconds", get_parent().get_parent().get_node("StatsBG/Stats").seconds)

func savePermStats():
	perm_stats.set_value("Stats", "Achievements", get_parent().get_parent().get_node("StatsBG/AchievementsScroll/AchievementsList").achievements_earned)
	perm_stats.set_value("Stats", "Achievements_Hidden", get_parent().get_parent().get_node("StatsBG/AchievementsScroll/AchievementsList").achievements_hidden)
	perm_stats.set_value("Tutorial", "Finished", true)

func saveTime():
	config.set_value("Clock", "Date", get_node("Date").text)
	config.set_value("Clock", "Ind", month_ind)
	config.set_value("Clock", "Year", year)

func saveHonks():
	config.set_value("Honks", "SavedHonks", get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer").all_honks)
	config.set_value("Honks", "unread_honks", get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer").unread_honks)
	config.set_value("Honks", "honks", get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer").honks)

func saveGlobalInfo():
	config.set_value("GlobalInfo", "sustainable_tech", sustainable_tech)
	config.set_value("GlobalInfo", "global_temp", global_temp)
	config.set_value("GlobalInfo", "pandemic", pandemic)
	config.set_value("GlobalInfo", "pandemic_length", pandemic_length)
	config.set_value("GlobalInfo", "virus_deadliness", virus_deadliness)
	config.set_value("GlobalInfo", "carbon_points", carbon_points)
	config.set_value("GlobalInfo", "shortage", shortage)
	config.set_value("GlobalInfo", "shortage_time", shortage_time)

func saveSettings():
	config.set_value("Settings", "Interactivity", get_parent().get_parent().interact)

func saveCountryInfo():
	for country in countries:
		config.set_value("CountryInfo", country+"_borders_open", get_parent().get_parent().get_node(country).borders_open)
		config.set_value("CountryInfo", country+"_population", get_parent().get_parent().get_node(country).population)
		config.set_value("CountryInfo", country+"_growth", get_parent().get_parent().get_node(country).growth)
		config.set_value("CountryInfo", country+"_land_area", get_parent().get_parent().get_node(country).land_area)
		config.set_value("CountryInfo", country+"_density", get_parent().get_parent().get_node(country).density)
		config.set_value("CountryInfo", country+"_emissions", get_parent().get_parent().get_node(country).emissions)
		config.set_value("CountryInfo", country+"_gdp", get_parent().get_parent().get_node(country).gdp)
		config.set_value("CountryInfo", country+"_gdp_per_cap", get_parent().get_parent().get_node(country).gdp_per_cap)
		config.set_value("CountryInfo", country+"_temp", get_parent().get_parent().get_node(country).temp)
		config.set_value("CountryInfo", country+"_avg_temp", get_parent().get_parent().get_node(country).avg_temp)
		config.set_value("CountryInfo", country+"_stability", get_parent().get_parent().get_node(country).stability)
		config.set_value("CountryInfo", country+"_collapsed", get_parent().get_parent().get_node(country).collapsed)
		config.set_value("CountryInfo", country+"_diseased", get_parent().get_parent().get_node(country).diseased)
		config.set_value("CountryInfo", country+"_victims", get_parent().get_parent().get_node(country).victims)
		config.set_value("CountryInfo", country+"_disaster", get_parent().get_parent().get_node(country).disaster)
		config.set_value("CountryInfo", country+"_disaster_total", get_parent().get_parent().get_node(country).disaster_total)
		config.set_value("CountryInfo", country+"_war_ticks", get_parent().get_parent().get_node(country).war_ticks)
		config.set_value("CountryInfo", country+"_sustainable_tech", get_parent().get_parent().get_node(country).sustainable_tech)
		config.set_value("CountryInfo", country+"_warring", get_parent().get_parent().get_node(country).warring)


		
# Called when the node enters the scene tree for the first time.
func _ready():
	var pause_button = get_node("PauseButton")
	var timer = get_node("DateTimer")
	pause_button.connect("pressed", self, "_on_PauseButton_pressed")
	timer.connect("timeout", self, "_on_DateTimer_timeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
