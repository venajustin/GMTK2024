extends CharacterBody2D


@export var SPEED = 300.0
var JUMP_VELOCITY = -400.0
@export var spring = -600.0
@onready var _animated_sprite = $AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var pushforce = 50.0
func _ready() :
	velocity = Vector2.ZERO
	_animated_sprite.play("idle")
@export var climbing = false
@export var weight = 1.0;
var cheese:int = 0
var original_position: Vector2 = Vector2(480,490)

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
	if velocity.x > 0:
		_animated_sprite.flip_h = false
	elif velocity.x < 0:
		_animated_sprite.flip_h = true
			
	if is_on_floor():
		if velocity.x > 0:
			_animated_sprite.flip_h = false
			if weight == 1.0:
				_animated_sprite.play("run")
			else:
				_animated_sprite.play("med_run")
		elif velocity.x < 0:
			_animated_sprite.flip_h = true
			if weight == 1.0:
				_animated_sprite.play("run")
			else:
				_animated_sprite.play("med_run")
		else:
			if weight == 1.0:
				_animated_sprite.play("idle")
			else:
				_animated_sprite.play("med_idle")
	else:
		if weight == 1.0:
				_animated_sprite.play("jump")
		else:
				_animated_sprite.play("med_jump")
		
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	

	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D && c.get_collider().name != "drone":
			c.get_collider().apply_central_impulse(Vector2(-c.get_normal().x, -c.get_normal().y * 100))
			if c.get_normal().y > 0:
				var torque = 25 * (c.get_collider().position.x - position.x)
				c.get_collider().apply_torque_impulse(torque)
			if c.get_normal().x < 0:
				c.get_collider().apply_impulse(Vector2(-c.get_normal().x * pushforce, -c.get_normal().y))
			else:
				c.get_collider().apply_impulse(Vector2(-c.get_normal().x * pushforce, -c.get_normal().y))
			


func impulse(dv:Vector2):
	velocity.y += dv.y;

func bounce():
	if weight == 1.0:
		velocity.y = spring
	else: 
		velocity.y = spring + 200

# returns true if last cheese eaten (move to next level)
func gotCheese() -> bool:
	if cheese == 0:
		weight = 2.0
		SPEED = 100
		JUMP_VELOCITY = -200
		position = original_position
		cheese = 1
		return false
	elif cheese == 1:
		return true
	return true
	
	
