extends ItemList


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var achievements_list = ["Dictator", "Champion", "Hater", "Speedy Gonzales", "Good Samaritan"]
var achievements_earned = []
var achievement_defs = {"Dictator": "Collapse every country", "Champion": "Win at least 10 times", "Hater": "Receive 100 hate honks", "Speedy Gonzales": "Kill 80% of the population within 5 minutes", "Good Samaritan": "Lose the game but save the planet"}
var achievements_hidden = [0, 1, 2, 3, 4]

func add_achievement(achievement):
	if achievement in achievements_list and not achievement in achievements_earned:
		achievements_earned.append(achievement)
		if achievements_list.find(achievement) in achievements_hidden:
			var pos = achievements_list.find(achievement)
			achievements_hidden.remove(achievements_hidden.find(pos))
		updateList()
		get_parent().get_parent().get_parent().get_node("MapCamera/Achievement/YouveUnlocked").unlockAchievement(achievement)
		if achievement != "Good Samaritan" and achievement != "Champion":
			get_tree().paused = true


# Called when the node enters the scene tree for the first time.
func _ready():
	updateList()

func updateList():
	clear()
	for i in range(len(achievements_list)):
		if !(i in achievements_hidden):
			add_item(achievements_list[i])
		else:
			add_item("?????")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
