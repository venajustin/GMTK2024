extends StaticBody2D



func _on_spring_body_entered(body):
	if body.has_method("bounce"):
		body.bounce();
