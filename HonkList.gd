extends ItemList


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var unread_honks = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	unread_honks["HonkerHelp"] = "Welcome to Honker! You'll find important (and unimportant) messages from residents of the world's many countries here."


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SocialMediaButton_pressed():
	for honk in unread_honks:
		add_item(unread_honks[honk])
