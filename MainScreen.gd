extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var config = ConfigFile.new()
var existingSave = true

var err = config.load("user://save.cfg")


# Called when the node enters the scene tree for the first time.
func _ready():
	loadSaveCheck()

func loadSaveCheck():
	if err != OK:
		existingSave = false
	if existingSave:
		#get_node("NewGameButton").rect_global_position.y = 1390
		get_node("LoadSaveButton").visible = true
		#get_node("LoadSaveButton").rect_global_position.y = 1640
		#get_node("CreditsButton").rect_global_position.y = 1890
	else:
		get_node("NewGameButton").rect_global_position.y = 1390
		get_node("DonateButton").rect_global_position.y = 1640
		get_node("CreditsButton").rect_global_position.y = 1890


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
