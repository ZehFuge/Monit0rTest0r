extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var window_size = OS.get_real_window_size()
	self.rect_size = window_size
