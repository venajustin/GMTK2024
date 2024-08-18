extends Control

signal pause_game


func focus():
	$VBoxContainer/Paused.grab_focus()

func _on_paused_pressed():
	pause_game.emit()



func _on_quit_pressed():
	get_tree().quit()


func _on_main_menu_pressed():
	get_tree().reload_current_scene()
