extends RigidBody2D


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		if body.climbing == false:
			body.climbing = true





func _on_area_2d_body_exited(body):
	if body.name == "Player":
		if body.climbing == true:
			body.climbing = false
