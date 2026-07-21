extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var config = ConfigFile.new()
var perm_stats = ConfigFile.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	loadSaveCheck()

func loadSaveCheck():
	var existingSave = true
	var err = config.load("user://save.cfg")
	if err != OK:
		existingSave = false

func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_parent().get_node("ShortClick").play()
	get_tree().paused = false
	saveTime()
	saveHonks()
	saveGlobalInfo()
	saveCountryInfo()
	saveStats()
	saveSettings()
	savePermStats()
	config.save("user://save.cfg")
	perm_stats.save("user://perm_stats.cfg")
	get_tree().change_scene("res://MainScreen.tscn")

func saveStats():
	config.set_value("Stats", "Seconds", get_parent().get_parent().get_parent().get_node("StatsBG/Stats").seconds)

func savePermStats():	
	perm_stats.set_value("Stats", "Achievements", get_parent().get_parent().get_parent().get_node("StatsBG/AchievementsScroll/AchievementsList").achievements_earned)
	perm_stats.set_value("Stats", "Achievements_Hidden", get_parent().get_parent().get_parent().get_node("StatsBG/AchievementsScroll/AchievementsList").achievements_hidden)
	perm_stats.set_value("Tutorial", "Finished", true)

func saveSettings():
	config.set_value("Settings", "Interactivity", get_parent().get_parent().get_parent().interact)

func saveHonks():
	config.set_value("Honks", "SavedHonks", get_parent().get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer").all_honks)
	config.set_value("Honks", "unread_honks", get_parent().get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer").unread_honks)
	config.set_value("Honks", "honks", get_parent().get_parent().get_node("SocialMediaPage/HonkContainer/VHonkContainer").honks)
	
func saveTime():
	config.set_value("Clock", "Date", get_parent().get_parent().get_node("Clock/Date").text)
	config.set_value("Clock", "Ind", get_parent().get_parent().get_node("Clock").month_ind)
	config.set_value("Clock", "Year", get_parent().get_parent().get_node("Clock").year)

func saveGlobalInfo():
	config.set_value("GlobalInfo", "sustainable_tech", get_parent().get_parent().get_node("Clock").sustainable_tech)
	config.set_value("GlobalInfo", "global_temp", get_parent().get_parent().get_node("Clock").global_temp)
	config.set_value("GlobalInfo", "pandemic", get_parent().get_parent().get_node("Clock").pandemic)
	config.set_value("GlobalInfo", "pandemic_length", get_parent().get_parent().get_node("Clock").pandemic_length)
	config.set_value("GlobalInfo", "virus_deadliness", get_parent().get_parent().get_node("Clock").virus_deadliness)
	config.set_value("GlobalInfo", "carbon_points", get_parent().get_parent().get_node("Clock").carbon_points)
	config.set_value("GlobalInfo", "shortage", get_parent().get_parent().get_node("Clock").shortage)
	config.set_value("GlobalInfo", "shortage_time", get_parent().get_parent().get_node("Clock").shortage_time)

func saveCountryInfo():
	for country in get_parent().get_parent().get_node("Clock").countries:
		config.set_value("CountryInfo", country+"_borders_open", get_parent().get_parent().get_parent().get_node(country).borders_open)
		config.set_value("CountryInfo", country+"_population", get_parent().get_parent().get_parent().get_node(country).population)
		config.set_value("CountryInfo", country+"_growth", get_parent().get_parent().get_parent().get_node(country).growth)
		config.set_value("CountryInfo", country+"_land_area", get_parent().get_parent().get_parent().get_node(country).land_area)
		config.set_value("CountryInfo", country+"_density", get_parent().get_parent().get_parent().get_node(country).density)
		config.set_value("CountryInfo", country+"_emissions", get_parent().get_parent().get_parent().get_node(country).emissions)
		config.set_value("CountryInfo", country+"_gdp", get_parent().get_parent().get_parent().get_node(country).gdp)
		config.set_value("CountryInfo", country+"_gdp_per_cap", get_parent().get_parent().get_parent().get_node(country).gdp_per_cap)
		config.set_value("CountryInfo", country+"_temp", get_parent().get_parent().get_parent().get_node(country).temp)
		config.set_value("CountryInfo", country+"_avg_temp", get_parent().get_parent().get_parent().get_node(country).avg_temp)
		config.set_value("CountryInfo", country+"_stability", get_parent().get_parent().get_parent().get_node(country).stability)
		config.set_value("CountryInfo", country+"_collapsed", get_parent().get_parent().get_parent().get_node(country).collapsed)
		config.set_value("CountryInfo", country+"_diseased", get_parent().get_parent().get_parent().get_node(country).diseased)
		config.set_value("CountryInfo", country+"_victims", get_parent().get_parent().get_parent().get_node(country).victims)
		config.set_value("CountryInfo", country+"_disaster", get_parent().get_parent().get_parent().get_node(country).disaster)
		config.set_value("CountryInfo", country+"_disaster_total", get_parent().get_parent().get_parent().get_node(country).disaster_total)
		config.set_value("CountryInfo", country+"_war_ticks", get_parent().get_parent().get_parent().get_node(country).war_ticks)
		config.set_value("CountryInfo", country+"_sustainable_tech", get_parent().get_parent().get_parent().get_node(country).sustainable_tech)
		config.set_value("CountryInfo", country+"_warring", get_parent().get_parent().get_parent().get_node(country).warring)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
