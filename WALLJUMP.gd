extends State

var speed = 50
var friction = 1
var direction = Vector2(-1,0)
@onready var timer = $CooldownTimer

func update(delta):
	wall_slide_movement(delta)
	if player.jump:
		return states.JUMP
	if player.is_on_floor():
		return states.IDLE
	if not player.check_wall_adjacent():
		print("JOE BIDEN JOE BIDEN")
		return states.IDLE
	return null

func wall_slide_movement(delta):
	player.gravity(delta)
	player_movement()
	if not player.input_direction.y > 0:
		player.velocity.y *= friction

func enter_state():
	pass
func exit_state():
	pass
