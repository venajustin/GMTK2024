extends Control

signal pause_game

@onready var _window := get_window()

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_game.emit()
	if Input.is_action_just_pressed("fullscreen"):
		if _window.mode == Window.MODE_EXCLUSIVE_FULLSCREEN:
			_window.mode = Window.MODE_WINDOWED
		elif _window.mode == Window.MODE_WINDOWED:
			_window.mode = Window.MODE_EXCLUSIVE_FULLSCREEN

func focus():
	$VBoxContainer/Paused.grab_focus()

func _on_paused_pressed():
	pause_game.emit()



func _on_quit_pressed():
	get_tree().quit()


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
