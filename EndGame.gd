extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

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
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var highscores = ConfigFile.new()
	var err = highscores.load("user://scores.cfg")
	var score1 = highscores.get_value("Highscores", "score1")
	var score2 = highscores.get_value("Highscores", "score2")
	var score3 = highscores.get_value("Highscores", "score3")
	var place = highscores.get_value("Highscores", "place")
	var new_score = highscores.get_value("Highscores", "new_score")
	var won = highscores.get_value("Highscores", "won")
	var total_victims = highscores.get_value("Highscores", "total_victims")
	
	if won:
		get_node("WinBG").visible = true
		get_node("LoseBG").visible = false
		get_node("WonLostLabel").bbcode_text = "[center]you won![/center]"
		get_node("ScoreLabel").bbcode_text = "[center]score: " + str(new_score) + "[/center]"
		get_node("DeathLabel").bbcode_text = "[center]deaths: " + format_num(total_victims) + "[/center]"
	else:
		get_node("WinBG").visible = false
		get_node("LoseBG").visible = true
		get_node("WonLostLabel").bbcode_text = "[center]you lost[/center]"
		get_node("ScoreLabel").bbcode_text = "[center]score: " + str(new_score) + "[/center]"
		get_node("DeathLabel").bbcode_text = "[center]deaths: " + format_num(total_victims) + "[/center]"
	
	get_node("HighScores").bbcode_text = "[center]1st: " + str(score1) + "\n\n"
	get_node("HighScores").bbcode_text += "2nd: " + str(score2) + "\n\n"
	get_node("HighScores").bbcode_text += "3rd: " + str(score3) + "[/center]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
