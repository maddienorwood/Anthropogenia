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
	var deadliness = 0
	var virus_name = get_parent().get_node("NameEdit").text
	if get_parent().get_node("DeadlinessSlider").value < 25:
		deadliness = 0
	elif get_parent().get_node("DeadlinessSlider").value < 50:
		deadliness = 1
	elif get_parent().get_node("DeadlinessSlider").value < 75:
		deadliness = 2
	else:
		deadliness = 3
	var selected = get_parent().get_node("StartingCountryScroll/CountryList").get_selected_items()[0]
	var country = clock.countries[selected]
	
	clock.new_user_pandemic(virus_name, deadliness, country)
	
	clock.carbon_points -= 100
	get_parent().get_parent().get_node("MapCamera").position.x -= 1080
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
