extends TextureRect

@export var item_scene:PackedScene = null

@onready var viewport:Viewport = get_viewport()
@onready var px_size_div2:Vector2 = Vector2(texture.get_width(), texture.get_height()) / 2


var held = false
var mouse_hover = false

@onready var arrangement:Control = get_tree().root.get_child(0).find_child("Arrangement")
var inventory:Control = null
var box: VBoxContainer = null
var inventory_bound_right:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = get_tree().root.get_child(0).find_child("Inventory")
	var inv_scr_cont:ScrollContainer = inventory.find_child("ScrollContainer")
	inventory_bound_right = inv_scr_cont.size.x + inv_scr_cont.position.x
	box = inventory.find_child("ScrollContainer").find_child("VBoxContainer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_mouse_button_pressed( MOUSE_BUTTON_LEFT ):
		if mouse_hover:
			held = true
			var parent = get_parent()
			if parent.is_class("VBoxContainer"):
				parent.remove_child(self)
				arrangement.add_child(self)
				
	else:
		held = false
		if position.x < inventory_bound_right:
			arrangement.remove_child(self)
			box.add_child(self)
	
	if held:
		position = viewport.get_mouse_position() - px_size_div2
		

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
