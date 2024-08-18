extends CharacterBody2D


@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() :
	velocity = Vector2.ZERO
@export var climbing = false

func _physics_process(delta):
	# Add the gravity.
	if climbing == false:
		velocity.y += gravity * delta
	elif climbing == true:
		velocity.y = 0
		if Input.is_action_pressed("move_up"):
			velocity.y = -SPEED
		elif Input.is_action_pressed("move_down"):
			velocity.y = SPEED
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if velocity.y > JUMP_VELOCITY:
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	

	move_and_slide()

func impulse(dv:Vector2):
	velocity.y += dv.y;
