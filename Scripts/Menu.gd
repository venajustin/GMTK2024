extends Control

signal start_level

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartGame.grab_focus()


func _on_quit_pressed():
	get_tree().quit()


func _on_levels_pressed():
	$VBoxContainer/notimplementedyet.visible = true


func _on_start_game_pressed():
	
	start_level.emit()
	
