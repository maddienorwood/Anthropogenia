extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var textbox = ''
var line = 0
var col = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _pressed():
	var settings = ConfigFile.new()
	var err = settings.load("user://settings.cfg")
	if settings.get_value("Sound", "sound_on")==true:
		get_parent().get_parent().get_parent().get_node("ShortClick").play()
	var edit = get_parent().get_node("HonkEdit")
	var honker = get_parent().get_node("HonkContainer/VHonkContainer")
	honker.new_honk(edit.text, 2, "Cl1m4te")
	edit.text = ""
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	honker.new_honk(honker.hater_honks[rng.randi_range(0,9)], rng.randi_range(64,73), honker.hater_handles[rng.randi_range(0,2)]+str(rng.randi_range(1,99)))
	

func _on_HonkEdit_text_changed():
	var edit = get_parent().get_node("HonkEdit")
	if len(edit.text) == 140:
		textbox = edit.text
		line = edit.cursor_get_line()
		col = edit.cursor_get_column()
	elif len(edit.text) > 140:
		edit.text = textbox
		edit.cursor_set_line(line)
		edit.cursor_set_column(col)
		



