extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
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
		

func display_info(name, node):
	var display_text = ""
	var red = Color(1, 0, 0, 1)
	var green = Color( 0, 1, 0, 1 )
	if !node.collapsed:
		display_text = "[center][color=#"+green.to_html(false)+"]" + name + "[/color]"
	else:
		display_text = "[center][color=#"+red.to_html(false)+"]" + name + "[/color]"
	var date = get_parent().get_parent().get_node("MapCamera/Clock")
	var year = date.year
	display_text += "\nPop: " + format_num(node.population)
	display_text += "\nTemp: " + str(round(node.temp)) + " F"
	display_text += "\nEmissions: " + format_num(round(node.emissions[year])) + " mt"
	display_text += "\nGDP: $" + format_num(round(node.gdp_per_cap)) + " pp"

	set_bbcode(display_text)
	
	get_parent().rect_global_position = node.clickpos
	get_parent().rect_global_position.x -= 250
	get_parent().rect_global_position.y -= 180
	
	if get_parent().rect_global_position.y < 170:
		get_parent().rect_global_position.y = 170
	elif get_parent().rect_global_position.y > 1825:
		get_parent().rect_global_position.y = 1825

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
