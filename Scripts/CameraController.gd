extends Camera2D

@onready var tracking_node:Node2D = $"../Path2D/PathFollow2D";

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if tracking_node != null:
		position = tracking_node.position
