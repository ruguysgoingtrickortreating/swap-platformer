extends State

var speed = 50
var friction = 1
var direction = Vector2(-1,0)
@onready var timer = $CooldownTimer

func update(delta):
	sprite.flip_h = direction.x > 0
	wall_slide_movement(delta)
	if player.jump:
		return states.JUMP
	if player.is_on_floor():
		return states.IDLE
	if not player.check_wall_adjacent():
		return states.IDLE
	return null

func wall_slide_movement(delta):
	player.gravity(delta)
	player_movement()
	if player.input_direction.y > 0:
		player.velocity.y = clamp(player.velocity.y, -600, 1000)
	else:
		player.velocity.y = clamp(player.velocity.y,-600,600)
		player.velocity.y *= friction

func enter_state():
	sprite.play("walljump")
	if player.bufferjump:
		player.bufferjump = false
		player.bufferjump_timer.stop()
		return states.JUMP
