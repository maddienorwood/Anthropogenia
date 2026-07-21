extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var touched = self
var config = ConfigFile.new()
var perm_stats = ConfigFile.new()
var existingSave = true
var interact = true
var settings = ConfigFile.new()
var sound_err = settings.load("user://settings.cfg")
var tutorial_on = false

func loadSaveCheck():
	var err = config.load("user://save.cfg")
	var err2 = perm_stats.load("user://perm_stats.cfg")
	if err != OK:
		return false
	else:
		return true

func tutorialCheck():
	if !perm_stats.has_section_key("Tutorial", "Finished"):
		tutorial_on = true

func tutorialDone():
	perm_stats.set_value("Tutorial", "Finished", true)
	perm_stats.save("user://perm_stats.cfg")
	get_node("MapCamera/Clock/DateTimer").paused = false
	get_tree().paused = false

func loadSettings():
	interact = config.get_value("Settings", "Interactivity")
	get_node("SettingsBackground/InteractivityButton").pressed = interact

func loadStats():
	get_node("StatsBG/Stats").seconds = config.get_value("Stats", "Seconds")

func loadPermStats():
	if perm_stats.has_section_key("Stats", "Achievements"):
		get_node("StatsBG/AchievementsScroll/AchievementsList").achievements_earned = perm_stats.get_value("Stats", "Achievements")
		get_node("StatsBG/AchievementsScroll/AchievementsList").achievements_hidden = perm_stats.get_value("Stats", "Achievements_Hidden")
		get_node("StatsBG/AchievementsScroll/AchievementsList").updateList()
	
func loadHonks():
	var saved_honks = config.get_value("Honks", "SavedHonks")
	var honks = config.get_value("Honks", "honks")
	var unread_honks = config.get_value("Honks", "unread_honks")
	var honker = get_node("MapCamera/SocialMediaPage/HonkContainer/VHonkContainer")
	
	for i in range(1,honks):
		var honk = saved_honks[i]
		honker.load_honk(honk[0], honk[1], honk[2], honk[3])
	
	honker.unread_honks = unread_honks
	honker.update_unread()
	honker.honks = honks
	honker.all_honks = saved_honks
	

func loadTime():
	get_node("MapCamera/Clock/Date").text = config.get_value("Clock", "Date")
	get_node("MapCamera/Clock").month_ind = config.get_value("Clock", "Ind")
	get_node("MapCamera/Clock").year = config.get_value("Clock", "Year")

func loadGlobalInfo():
	get_node("MapCamera/Clock").sustainable_tech = config.get_value("GlobalInfo", "sustainable_tech")
	get_node("MapCamera/Clock").global_temp = config.get_value("GlobalInfo", "global_temp")
	get_node("MapCamera/Clock").pandemic = config.get_value("GlobalInfo", "pandemic")
	get_node("MapCamera/Clock").pandemic_length = config.get_value("GlobalInfo", "pandemic_length")
	get_node("MapCamera/Clock").virus_deadliness = config.get_value("GlobalInfo", "virus_deadliness")
	get_node("MapCamera/Clock").carbon_points = config.get_value("GlobalInfo", "carbon_points")
	get_node("MapCamera/Clock").shortage = config.get_value("GlobalInfo", "shortage")
	get_node("MapCamera/Clock").shortage_time = config.get_value("GlobalInfo", "shortage_time")

func loadHouses():
	pass

func loadCountryInfo():
	for country in get_node("MapCamera/Clock").countries:
		get_node(country).borders_open = config.get_value("CountryInfo", country+"_borders_open")
		get_node(country).population = config.get_value("CountryInfo", country+"_population")
		get_node(country).growth = config.get_value("CountryInfo", country+"_growth")
		get_node(country).land_area = config.get_value("CountryInfo", country+"_land_area")
		get_node(country).density = config.get_value("CountryInfo", country+"_density")
		get_node(country).emissions = config.get_value("CountryInfo", country+"_emissions")
		get_node(country).gdp = config.get_value("CountryInfo", country+"_gdp")
		get_node(country).gdp_per_cap = config.get_value("CountryInfo", country+"_gdp_per_cap")
		get_node(country).temp = config.get_value("CountryInfo", country+"_temp")
		get_node(country).avg_temp = config.get_value("CountryInfo", country+"_avg_temp")
		get_node(country).stability = config.get_value("CountryInfo", country+"_stability")
		get_node(country).collapsed = config.get_value("CountryInfo", country+"_collapsed")
		get_node(country).diseased = config.get_value("CountryInfo", country+"_diseased")
		get_node(country).victims = config.get_value("CountryInfo", country+"_victims")
		get_node(country).disaster = config.get_value("CountryInfo", country+"_disaster")
		get_node(country).disaster_total = config.get_value("CountryInfo", country+"_disaster_total")
		get_node(country).war_ticks = config.get_value("CountryInfo", country+"_war_ticks")
		get_node(country).sustainable_tech = config.get_value("CountryInfo", country+"_sustainable_tech")
		get_node(country).warring = config.get_value("CountryInfo", country+"_warring")
		
func placeHouses():
	for country in get_node("MapCamera/Clock").countries:
		var node = get_node(country)
		var rng = RandomNumberGenerator.new()
		var houses = 0
		if node.population < 500000:
			houses = 0
		elif node.population < 1000000:
			houses = 1
		elif node.population < 10000000:
			houses = 3
		elif node.population < 25000000:
			houses = 5
		elif node.population < 50000000:
			houses = 8
		elif node.population < 100000000:
			houses = 10
		elif node.population < 250000000:
			houses = 15
		elif node.population < 500000000:
			houses = 20
		elif node.population < 750000000:
			houses = 25
		else:
			houses = 30
			
		for i in range(houses):
			rng.randomize()
			var new_house = get_node("House").duplicate()
			var house_color = 0
			if rng.randi_range(1,10) != 10:
				house_color = rng.randi_range(1,7)
			else:
				house_color = rng.randi_range(8,9)
			new_house.texture = load("res://assets/houses/" + str(house_color) + ".png")
			var placed = false
			var xleft = 0
			var ytop = 0
			var xright = round(node.get_rect().size.x)
			var ybottom = round(node.get_rect().size.y)
			if xright-new_house.rect_size.x > 0 and ybottom-new_house.rect_size.y > 0:
				while not placed:
					var x = rng.randi_range(0, xright-new_house.rect_size.x)
					var y = rng.randi_range(0, ybottom-new_house.rect_size.y)
					new_house.rect_position.x = x
					new_house.rect_position.y = y
					var image = node.get_texture().get_data()
					image.lock()
					var loc = Vector2(x,y)
					var locs = [loc, loc + Vector2(0,50), loc + Vector2(50,0), loc + Vector2(50,50)]
					var on_image = true
					for l in locs:
						image.lock()
						var pixel = image.get_pixelv(l)
						image.unlock()
						if pixel[3] == 0 or (pixel[0]>0.36 and pixel[0]<0.38) or (pixel[0]> .14 and pixel[0]<.16):
							on_image = false
						
					if on_image:
						new_house.rect_position -= Vector2(node.get_rect().size.x/2 + 10, node.get_rect().size.y/2 + 10)
						placed = true
						node.add_child(new_house)
						new_house.visible = true
# Called when the node enters the scene tree for the first time.
func _ready():
	if settings.get_value("Sound", "sound_on")==true:
		get_node("Click").play()
	if settings.get_value("Sound", "music_on")==true:
		get_node("BGMusic").play()
	var existingSave = loadSaveCheck()
	if existingSave and config.has_section("Clock"):
		loadTime()
	if existingSave and config.has_section("GlobalInfo"):
		loadGlobalInfo()
	if existingSave and config.has_section("CountryInfo"):	
		loadCountryInfo()
	if existingSave and config.has_section("Stats"):	
		loadStats()
	if existingSave and config.has_section("Honks"):
		loadHonks()
	if existingSave and config.has_section("Houses"):	
		loadHouses()
	#else:
	#	placeHouses()
	if existingSave and config.has_section("Settings"):	
		loadSettings()
	else:
		get_node("SettingsBackground/InteractivityButton").pressed = true
		interact = true

	
	loadPermStats()
	tutorialCheck()
	
	var argentina = get_node("Argentina")
	argentina.connect("touched", self, "_on_country_touched")
	var australia = get_node("Australia")
	australia.connect("touched", self, "_on_country_touched")
	var bolivia = get_node("Bolivia")
	bolivia.connect("touched", self, "_on_country_touched")
	var brazil = get_node("Brazil")
	brazil.connect("touched", self, "_on_country_touched")
	var canada = get_node("Canada")
	canada.connect("touched", self, "_on_country_touched")
	var central_africa = get_node("Central Africa")
	central_africa.connect("touched", self, "_on_country_touched")
	var central_america = get_node("Central America")
	central_america.connect("touched", self, "_on_country_touched")
	var central_asia = get_node("Central Asia")
	central_asia.connect("touched", self, "_on_country_touched")
	var chile = get_node("Chile")
	chile.connect("touched", self, "_on_country_touched")
	var china = get_node("China")
	china.connect("touched", self, "_on_country_touched")
	var eastern_europe = get_node("Eastern Europe")
	eastern_europe.connect("touched", self, "_on_country_touched")
	var finland = get_node("Finland")
	finland.connect("touched", self, "_on_country_touched")
	var greenland = get_node("Greenland")
	greenland.connect("touched", self, "_on_country_touched")
	var iceland = get_node("Iceland")
	iceland.connect("touched", self, "_on_country_touched")
	var india = get_node("India")
	india.connect("touched", self, "_on_country_touched")
	var indonesia = get_node("Indonesia")
	indonesia.connect("touched", self, "_on_country_touched")
	var iran = get_node("Iran")
	iran.connect("touched", self, "_on_country_touched")
	var ireland = get_node("Ireland")
	ireland.connect("touched", self, "_on_country_touched")
	var japan = get_node("Japan")
	japan.connect("touched", self, "_on_country_touched")
	var kazakhstan = get_node("Kazakhstan")
	kazakhstan.connect("touched", self, "_on_country_touched")
	var korea = get_node("Korea")
	korea.connect("touched", self, "_on_country_touched")
	var madagascar = get_node("Madagascar")
	madagascar.connect("touched", self, "_on_country_touched")
	var malaysia = get_node("Malaysia")
	malaysia.connect("touched", self, "_on_country_touched")
	var mexico = get_node("Mexico")
	mexico.connect("touched", self, "_on_country_touched")
	var mongolia = get_node("Mongolia")
	mongolia.connect("touched", self, "_on_country_touched")
	var new_zealand = get_node("New Zealand")
	new_zealand.connect("touched", self, "_on_country_touched")
	var northeast_africa = get_node("Northeast Africa")
	northeast_africa.connect("touched", self, "_on_country_touched")
	var northern_south_america = get_node("N South America")
	northern_south_america.connect("touched", self, "_on_country_touched")
	var northwest_africa = get_node("Northwest Africa")
	northwest_africa.connect("touched", self, "_on_country_touched")
	var norway = get_node("Norway")
	norway.connect("touched", self, "_on_country_touched")
	var papua_new_guinea = get_node("Papua New Guinea")
	papua_new_guinea.connect("touched", self, "_on_country_touched")
	var paraguay = get_node("Paraguay")
	paraguay.connect("touched", self, "_on_country_touched")
	var peru = get_node("Peru")
	peru.connect("touched", self, "_on_country_touched")
	var phillippines = get_node("Phillippines")
	phillippines.connect("touched", self, "_on_country_touched")
	var russia = get_node("Russia")
	russia.connect("touched", self, "_on_country_touched")
	var south_asia = get_node("South Asia")
	south_asia.connect("touched", self, "_on_country_touched")
	var southern_africa = get_node("Southern Africa")
	southern_africa.connect("touched", self, "_on_country_touched")
	var sweden = get_node("Sweden")
	sweden.connect("touched", self, "_on_country_touched")
	var uk = get_node("UK")
	uk.connect("touched", self, "_on_country_touched")
	var uruguay = get_node("Uruguay")
	uruguay.connect("touched", self, "_on_country_touched")
	var usa = get_node("USA")
	usa.connect("touched", self, "_on_country_touched")
	var west_asia = get_node("West Asia")
	west_asia.connect("touched", self, "_on_country_touched")
	var west_europe = get_node("West Europe")
	west_europe.connect("touched", self, "_on_country_touched")
	
	var clock = get_node("MapCamera/Clock")
	for country in clock.countries:
		var node = get_node(country)
		if node.diseased > 0:
			node.texture = load("res://assets/countries/" + node.sprite_name + "_sick.png")
		if node.collapsed:
			node.texture = load("res://assets/countries/" + node.sprite_name + "_collapsed.png")
	
	if !existingSave:
		get_node("MapCamera/WelcomeMessage").visible = true
		get_node("MapCamera/Clock/DateTimer").paused = true
		get_tree().paused = true
	
func _on_country_touched():
	var country_name = touched.name
	var node = touched
	var info = get_node("InfoPop")
	info.display_info(country_name, node)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CountryList_nothing_selected():
	pass # Replace with function body.
