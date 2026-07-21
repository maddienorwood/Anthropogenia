extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_wait_time(1.5)
	start()
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SpeedButton_pressed():
	var default_time = 1.5
	var speed = get_parent().get_node("SpeedButton").speed
	set_wait_time(default_time/speed)
