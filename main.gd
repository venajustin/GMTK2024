extends Node
enum GameState {MENU, BUILD, RUNNING};
var state:GameState = GameState.MENU;
var paused:bool = false

@export var _menu_scene:PackedScene = null
var menu:Control

@export var _pause_scene:PackedScene = null
var pause:Control

var level:Node2D = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	menu = _menu_scene.instantiate()
	add_child(menu)
	menu.connect("start_level", _on_menu_start_level);
	state = GameState.MENU;
	
	pause = _pause_scene.instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if state == GameState.MENU:
			get_tree().quit()
		else:
			pause_game()
		
		
	if state == GameState.BUILD:
		
		if Input.is_action_pressed("play_level"):
			level.process_mode = Node.PROCESS_MODE_INHERIT
			state = GameState.RUNNING
	

func pause_game():
	if paused:
		paused = !paused
		level.process_mode = Node.PROCESS_MODE_INHERIT if state == GameState.RUNNING else Node.PROCESS_MODE_DISABLED
		remove_child(pause)
	else:
		paused = !paused
		level.process_mode = Node.PROCESS_MODE_DISABLED
		add_child(pause)
		pause.focus()
		pause.connect("pause_game", pause_game)



func _on_menu_start_level():
	remove_child(menu)
	level = load("res://Levels/level1.tscn").instantiate()
	get_tree().current_scene.add_child(level)
	level.process_mode = Node.PROCESS_MODE_DISABLED
	state = GameState.BUILD;
	

