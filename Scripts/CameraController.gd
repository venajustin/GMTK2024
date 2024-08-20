extends Camera2D

@onready var tracking_node:Node2D = null;

var panning:bool = false
var pan_point:Vector2 = Vector2.ZERO
var start_point:Vector2 = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if tracking_node != null:
		position_smoothing_enabled = true
		position = tracking_node.position
	
	if tracking_node == null:
		position_smoothing_enabled = false
		if panning:
			position = start_point - (get_local_mouse_position() - pan_point)
	
	if Input.is_action_just_pressed("pan"):
		panning = true
		pan_point = get_local_mouse_position()
		start_point = position
	if Input.is_action_just_released("pan"):
		panning = false
