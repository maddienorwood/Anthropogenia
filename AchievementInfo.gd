extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AchievementsList_item_selected(index):
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_parent().get_node("ShortClick").play()
	var node = get_parent().get_parent().get_node("AchievementsScroll/AchievementsList")
	var check = load("res://assets/green_check.png")
	var question = load("res://assets/gray_question.png")
	var x = load("res://assets/red_x.png")
	if node.achievements_list[index] in node.achievements_earned:
		get_parent().get_node("AchievementIcon").texture = check
	elif index in node.achievements_hidden:
		get_parent().get_node("AchievementIcon").texture = question
	else:
		get_parent().get_node("AchievementIcon").texture = x
	
	if !index in node.achievements_hidden:
		get_node("AchievementDetails").bbcode_text = "[center]" + node.achievements_list[index] + ": \n\n" + node.achievement_defs[node.achievements_list[index]] + "[/center]"
	else:
		get_node("AchievementDetails").bbcode_text = "[center]???: \n\n" + "Hidden Achievement[/center]"
