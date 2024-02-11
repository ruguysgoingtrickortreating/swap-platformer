extends CharacterBody2D

var anims_normal = load("res://sprites/character.aseprite")
var anims_beast = load("res://sprites/character_beast.aseprite")
var env_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


# CONSTS
const SPEED = 600.0
const MIN_JUMP_VELOCITY = -200.0
const MAX_JUMP_VELOCITY = -650.0
var decaying_jump_strength:float

# INPUT
var last_direction:Vector2
var input_direction = Vector2.RIGHT
var jump
var dash
var can_dash = true
var walljump_cooldown

# STATES
var character = "normal"
var current_state
var last_state
@onready var STATES = $STATES

func _ready():
	for i in STATES.get_children():
		i.states = STATES
		i.player = self
	current_state = STATES.FALL

func _physics_process(delta):
	$StateLabel.text = str(current_state.name)
	$VelocityLabel.text = str(velocity)
	$StaticLabels/StateLabel.text = str(current_state.name)
	$StaticLabels/VelocityLabel.text = str(velocity)
	player_input()
	change_state(current_state.update(delta))
	#default_move(delta)
	move_and_slide()

func gravity(delta):
	if not is_on_floor():
		velocity.y += env_gravity * delta

func check_wall_adjacent():
	for raycast:RayCast2D in $Raycasts.get_children():
		raycast.force_raycast_update()
		if raycast.is_colliding() and raycast.get_collider().is_in_group("walljumpable"):
			if raycast.target_position.x > 0:
				STATES.WALLJUMP.direction = Vector2.RIGHT
				return Vector2.RIGHT
			else:
				STATES.WALLJUMP.direction = Vector2.LEFT
				return Vector2.LEFT
		#print(raycast.is_colliding())
	return null

func change_state(input_state):
	if input_state:
		last_state = current_state
		current_state = input_state
		last_state.exit_state()
		current_state.enter_state()

func player_input():
	input_direction = Vector2.ZERO
	if Input.is_action_pressed("left"):
		input_direction += Vector2(-1,0)
	if Input.is_action_pressed("right"):
		input_direction += Vector2(1,0)
	if Input.is_action_pressed("up"):
		input_direction += Vector2(0,-1)
	if Input.is_action_pressed("down"):
		input_direction += Vector2(0,1)
	
	if Input.is_action_just_pressed("jump"):
		jump = true
	else:
		jump = false
	if Input.is_action_just_pressed("enter"):
		dash = true
	else:
		dash = false
