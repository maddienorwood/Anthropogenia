extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cost = 1000
var clock
var disaster_costs = {"Flood": 500, "Drought": 100, "Tornado": 100, "Hurricane": 1000, "Storm": 500, "Tsunami": 2500, "Earthquake": 2500, "Wildfire": 100, "Landslide": 250, "Heatwave": 1000, "Blizzard": 750}
# Called when the node enters the scene tree for the first time.
func _ready():
	clock = get_parent().get_parent().get_node("MapCamera/Clock")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DisasterList_item_selected(index):
	var disaster = clock.disasters[index]
	bbcode_text = "[center]disaster cost: " + str(disaster_costs[disaster]) + " CP[/center]"
