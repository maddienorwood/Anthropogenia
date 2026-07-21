extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var config

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	if get_parent().get_node("LoadSaveButton").visible == true:
		get_parent().get_node("OverwriteSavePanel").visible = true
	else:
		config = ConfigFile.new()
		if loadSaveCheck():
			config.clear()
			config.save("user://save.cfg")
			
		get_tree().change_scene("res://WorldMap.tscn")

func loadSaveCheck():
	var err = config.load("user://save.cfg")
	if err != OK:
		return false
	else:
		return true

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
