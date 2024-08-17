extends Area2D

@export var spring_power: int = 800

func _on_body_entered(body):
	if body is Player: 
		body.spring(spring_power, rotation + PI/2.0)
		
