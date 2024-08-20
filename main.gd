extends Node
enum GameState {MENU, BUILD, RUNNING};
var state:GameState = GameState.MENU;
var paused:bool = false

@export var _menu_scene:PackedScene = null
var menu:Control





@export var _pause_scene:PackedScene = null
var pause:Control

@onready var _arrangement:Control = $Arrangement

@onready var _canvas:CanvasLayer = $CanvasLayer
@onready var _camera:Camera2D = $Camera2D
var level:Node2D = null;

@onready var _window := get_window()
@onready var _tree = get_tree()

@onready var _path_follow:PathFollow2D = $Path2D/PathFollow2D

@onready var _inventory:Control = $CanvasLayer/Inventory

var round = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#_world2d = find_child("Camera2D").get_world_2d()
	#
	#_intersect_params.canvas_instance_id = 0
	#_intersect_params.collide_with_areas = true;
	#_intersect_params.collide_with_bodies = true;
	#_intersect_params.collision_mask = 0x7FFFFFFF
	#_intersect_params.exclude = []
	
	_tree.paused = true;

	menu = _menu_scene.instantiate()
	
	_canvas.add_child(menu)
	menu.connect("start_level", _on_menu_start_level);
	state = GameState.MENU;
	
	pause = _pause_scene.instantiate()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("fullscreen"):
		if _window.mode == Window.MODE_EXCLUSIVE_FULLSCREEN:
			_window.mode = Window.MODE_WINDOWED
		elif _window.mode == Window.MODE_WINDOWED:
			_window.mode = Window.MODE_EXCLUSIVE_FULLSCREEN
	
	if Input.is_action_just_pressed("pause"):
		pause_game()
		
		
	if state == GameState.BUILD:
		
		if Input.is_action_pressed("play_level"):
			start_level()
			
	
	if Input.is_action_just_pressed("pgdown"):
		_path_follow.progress_ratio += .1;
	if Input.is_action_just_pressed("pgup"):
		_path_follow.progress_ratio -= .1;
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#var peice = select_piece()
		#if peice:
			#if peice.get_parent().has_method("grabbed"):
				#peice.get_parent().grabbed()
				
		

func start_level():
	level.process_mode = Node.PROCESS_MODE_INHERIT
	state = GameState.RUNNING
	_inventory.close()
	_camera.tracking_node = level.find_child("Player") 
	var props = _arrangement.get_children();
	for prop in props:
		if prop.item_scene:
			var scene:PackedScene = prop.item_scene;
			var item = scene.instantiate()
			item.position = prop.position
			item.rotation = prop.rotation
			level.add_child(item)
			_arrangement.remove_child(prop);


func pause_game():
	if paused:
		paused = !paused
		_tree.paused = false
		#level.process_mode = Node.PROCESS_MODE_INHERIT if state == GameState.RUNNING else Node.PROCESS_MODE_DISABLED
		_canvas.remove_child(pause)
	else:
		paused = !paused
		_tree.paused = true
		#level.process_mode = Node.PROCESS_MODE_DISABLED
		_canvas.add_child(pause)
		pause.focus()
		pause.connect("pause_game", pause_game)



func _on_menu_start_level():
	_tree.paused = false
	_canvas.remove_child(menu)
	level = load("res://Levels/level5.tscn").instantiate()
	get_tree().current_scene.add_child(level)
	level.process_mode = Node.PROCESS_MODE_DISABLED
	state = GameState.BUILD;
	



#func select_piece() -> Area2D:
	#var pos: Vector2
	#var intersects: Array
	#var top_piece: Area2D
	#var top_z: = -1
#
	#pos = _viewport.get_mouse_position()
	#_intersect_params.position = pos
	#intersects = _world2d.get_direct_space_state().intersect_point(_intersect_params, 32)
#
	#for piece in intersects:
		#if piece.collider.z_index > top_z:
			#top_piece = piece.collider
			#top_z = piece.collider.z_index
	#return top_piece


