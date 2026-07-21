extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cost = 2000


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateText():
	bbcode_text = "[center]shortage cost: " + str(cost) + " CP[/center]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ShortageUpButton_pressed():
	cost+=1500 
	updateText()
	
func _on_ShortageDownButton_pressed():
	cost-=1500
	updateText()
