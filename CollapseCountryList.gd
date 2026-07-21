extends ItemList


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var countries = []

# Called when the node enters the scene tree for the first time.

func _ready():
	fixed_column_width = 820
	countries = []
	for country in get_parent().get_parent().get_parent().get_node("MapCamera/Clock").countries:
		if get_parent().get_parent().get_parent().get_node(country).collapsed != true:
			add_item(country, null, true)
			countries.append(country)
		
func _on_Collapse_pressed():
	clear()
	countries = []
	fixed_column_width = 820
	for country in get_parent().get_parent().get_parent().get_node("MapCamera/Clock").countries:
		if get_parent().get_parent().get_parent().get_node(country).collapsed != true:
			add_item(country, null, true)
			countries.append(country) 
