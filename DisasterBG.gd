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


func _on_DisasterList_item_selected(index):
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_node("ShortClick").play()


func _on_CountryList_item_selected(index):
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_node("ShortClick").play()
