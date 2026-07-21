extends ItemList


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	fixed_column_width = 820
	for country in get_parent().get_parent().get_parent().get_node("MapCamera/Clock").countries:
		add_item(country, null, true)
	select(0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
