extends RichTextLabel


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
		return str(stepify(num, 0.01))
	return formatted

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bbcode_text = "[center]Current CP: " + format_num(get_parent().get_parent().get_node("MapCamera/Clock").carbon_points) + "[/center]"
