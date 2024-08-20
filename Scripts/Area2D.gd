extends Area2D




func _on_body_entered(body):
	if body.name == "Player":
		queue_free()
		#this is where you would increment the hud to say the mouse got the cheese
