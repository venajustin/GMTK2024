extends Camera2D

@onready var tracking_node:Node2D = $"../Player";


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	position = tracking_node.position
