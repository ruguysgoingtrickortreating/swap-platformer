extends CharacterBody2D

var anims_normal = load("res://sprites/character.aseprite")
var anims_beast = load("res://sprites/character_beast.aseprite")
var env_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


# CONSTS
const SPEED = 400.0
const MIN_JUMP_VELOCITY = -200.0
const MAX_JUMP_VELOCITY = -550.0
var decaying_jump_strength:float

# INPUT
var last_direction:Vector2
var input_direction = Vector2.RIGHT
var jump
var bufferjump
var dash
var can_dash = false
var walljump_cooldown

# STATES
var character = "normal"
var current_state
var last_state
@onready var states = $STATES
@onready var bufferjump_timer = $BufferJumpTimer

func _ready():
	for i in states.get_children():
		i.states = states
		i.player = self
		i.sprite = $Sprite
	current_state = states.FALL

func _physics_process(delta):
	$StateLabel.text = str(current_state.name)
	$VelocityLabel.text = str(velocity)
	$StaticLabels/StateLabel.text = str(current_state.name)
	$StaticLabels/LastStateLabel.text = str(last_state.name if last_state else "no last state")
	$StaticLabels/VelocityLabel.text = str(velocity)
	if $STATES/FALL.coyote_jump:
		$StaticLabels/CoyJumpLabel.text = "coyotejump: ON"
		$StaticLabels/CoyJumpLabel.set("theme_override_colors/font_color", Color(0,1,0,1))
	else:
		$StaticLabels/CoyJumpLabel.text = "coyotejump: OFF"
		$StaticLabels/CoyJumpLabel.set("theme_override_colors/font_color", Color(1,0,0,1))
	if bufferjump:
		$StaticLabels/BufferJumpLabel.text = "bufferjump: ON"
		$StaticLabels/BufferJumpLabel.set("theme_override_colors/font_color", Color(0,1,0,1))
	else:
		$StaticLabels/BufferJumpLabel.text = "bufferjump: OFF"
		$StaticLabels/BufferJumpLabel.set("theme_override_colors/font_color", Color(1,0,0,1))
	
	player_input()
	change_state(current_state.update(delta))
	
	move_and_slide()

func gravity(delta):
	if not is_on_floor():
		velocity.y += clamp(env_gravity * delta,-800,400)

func check_wall_adjacent():
	for raycast:RayCast2D in $Raycasts.get_children():
		raycast.force_raycast_update()
		if raycast.is_colliding() and raycast.get_collider().is_in_group("walljumpable"):
			if raycast.target_position.x > 0:
				states.WALLJUMP.direction = Vector2.RIGHT
				return Vector2.RIGHT
			else:
				states.WALLJUMP.direction = Vector2.LEFT
				return Vector2.LEFT
		#print(raycast.is_colliding())
	return null

func change_state(input_state):
	if input_state:
		last_state = current_state
		current_state = input_state
		last_state.exit_state()
		change_state(current_state.enter_state()) #keep in mind even if it doesnt return anything it will still run enter_state()

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

func buffer_jump():
	bufferjump = true
	bufferjump_timer.start(0.08)

func _on_buffer_jump_timer_timeout():
	bufferjump = false
