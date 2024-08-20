extends Area2D

@export var next_level:PackedScene = null

signal load_next

func _on_body_entered(body):
	if body.name == "Player":
		if body.gotCheese() :
			#time for next level
			load_next.emit(next_level)
		

