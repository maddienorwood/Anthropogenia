extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var seconds = 0
var display_text = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	updateStats()

func updateStats():
	clear()
	display_text = ""
	var minutes = seconds/60
	var remainder = seconds%60
	display_text += "[center]Run Length: \n" + str(minutes) + " m " + str(remainder) + " s[/center]\n\n"

	set_bbcode(display_text)
	
	get_parent().get_node("AchievementsTitle").updateTitle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StatsTimer_timeout():
	seconds += 1
