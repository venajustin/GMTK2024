extends Control

signal start_level

@onready var _window := get_window()

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartGame.grab_focus()
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().quit()
	if Input.is_action_just_pressed("fullscreen"):
		if _window.mode == Window.MODE_EXCLUSIVE_FULLSCREEN:
			_window.mode = Window.MODE_WINDOWED
		elif _window.mode == Window.MODE_WINDOWED:
			_window.mode = Window.MODE_EXCLUSIVE_FULLSCREEN

func _on_quit_pressed():
	get_tree().quit()


func _on_levels_pressed():
	$VBoxContainer/notimplementedyet.visible = true


func _on_start_game_pressed():
	
	start_level.emit()
	
