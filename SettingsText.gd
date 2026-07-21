extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var black = Color( 0, 0, 0, 1 )
var bb_text = "[center][color=#"+black.to_html(false)+"]settings[/color][/center]"
# Called when the node enters the scene tree for the first time.
func _ready():
	set_bbcode(bb_text) # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
