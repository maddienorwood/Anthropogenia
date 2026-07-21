extends ItemList


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var clock = get_parent().get_parent().get_parent().get_node("MapCamera/Clock")
	var shortages = clock.shortages
	fixed_column_width = 820
	for shortage in shortages:
			add_item(shortage, null, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
