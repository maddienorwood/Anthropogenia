extends ItemList


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	fixed_column_width = 820
	var clock = get_parent().get_parent().get_parent().get_node("MapCamera/Clock")
	for disaster in clock.disasters:
		add_item(disaster, null, true)# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
