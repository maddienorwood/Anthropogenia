extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().get_parent().get_node("MapCamera/Clock").pandemic == "":
		text = "-create virus-"
		get_node("VirusCost").bbcode_text = "[center]-100 CP[/center]"
	else:
		text = "-end " + get_parent().get_parent().get_node("MapCamera/Clock").pandemic + "-"
		get_node("VirusCost").bbcode_text = "[center]+100 CP[/center]"
	
func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_node("ShortClick").play()
	if text == "-create virus-" and get_parent().get_parent().get_node("MapCamera/Clock").carbon_points >= 100:
		get_parent().get_parent().get_node("MapCamera").position.x += 1080
	elif text == "-create virus-":
		get_parent().get_node("NotEnoughCP").popup()
		get_parent().get_node("NotEnoughCP").rect_global_position = rect_global_position
	else:
		var honker = get_parent().get_parent().get_node("MapCamera/SocialMediaPage/HonkContainer/VHonkContainer")
		var rng = RandomNumberGenerator.new()
		var clock = get_parent().get_parent().get_node("MapCamera/Clock")
		rng.randomize()
		honker.new_honk(clock.pandemic + " has ended. " + clock.pandemic_end[clock.virus_deadliness][rng.randi_range(0,2)] + " Cases: " + clock.format_num(round(clock.pandemic_cases)) + " Deaths: " + clock.format_num(round(clock.pandemic_deaths)), 3, "NewsBreak")
		clock.pandemic = ""
		clock.pandemic_length = 0
		clock.virus_deadliness = 0
		clock.carbon_points += 100
		for country in clock.countries:
			var node = get_parent().get_parent().get_node(country)
			node.diseased = 0
		
		
