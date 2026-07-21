extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var display_text = "[center]Achievements[/center]"

# Called when the node enters the scene tree for the first time.
func _ready():
	updateTitle()

func updateTitle():
	display_text = "[center]Achievements"
	var total_achievements = len(get_parent().get_node("AchievementsScroll/AchievementsList").achievements_list)
	var earned_achievements = len(get_parent().get_node("AchievementsScroll/AchievementsList").achievements_earned)
	
	display_text += " (" + str(earned_achievements) + "/" + str(total_achievements) + ")[/center]"
	set_bbcode(display_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
