extends TextureRect

@export var item_scene:PackedScene = null

@onready var viewport:Viewport = get_viewport()
@onready var _camera:Camera2D = get_tree().root.get_child(0).find_child("Camera2D")
@onready var px_size_div2:Vector2 = Vector2(texture.get_width(), texture.get_height()) / 2
@onready var area2D:Area2D = $Area2D

const no_modulate:Color = Color(1, 1, 1)
@export var invalid_modulate:Color = Color(1, 0.34682476520538, 0.3689894080162)

var held = false
var mouse_hover = false

var valid_loc = true

@onready var arrangement:Control = get_tree().root.get_child(0).find_child("Arrangement")
var inventory:Control = null
var box: VBoxContainer = null
var inventory_bound_right:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = no_modulate
	inventory = get_tree().root.get_child(0).find_child("CanvasLayer").find_child("Inventory")
	var inv_scr_cont:ScrollContainer = inventory.find_child("ScrollContainer")
	inventory_bound_right = inv_scr_cont.size.x + inv_scr_cont.position.x
	box = inventory.find_child("ScrollContainer").find_child("VBoxContainer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_mouse_button_pressed( MOUSE_BUTTON_LEFT ):
		if mouse_hover:
			held = true
			var parent = get_parent()
			if parent.is_class("VBoxContainer"):
				parent.remove_child(self)
				arrangement.add_child(self)
				
	else:
		held = false
		if position.x < inventory_bound_right && get_parent() != box:
			arrangement.remove_child(self)
			box.add_child(self)
			rotation = 0
	
	if held:
		position =  _camera.get_local_mouse_position() + _camera.global_position - px_size_div2
		

	if mouse_hover:
		var scroll_axis = 0
		scroll_axis += -1 if  Input.is_action_just_pressed("rotate_left") else 0
		scroll_axis += 1 if Input.is_action_just_pressed( "rotate_right") else 0
		scroll_axis *= 5 if Input.is_action_pressed("rotate_modifier") else 1
		if scroll_axis != 0:
			rotation += PI * .05 * scroll_axis


func _on_mouse_entered():
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mouse_hover = true;

func _on_mouse_exited():
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mouse_hover = false;



func _on_area_2d_body_entered(_body):
	valid_loc = false
	modulate = invalid_modulate
	

func _on_area_2d_body_exited(_body):
	if area2D.get_overlapping_bodies().size() == 0:
		valid_loc = true
		modulate = no_modulate
	
