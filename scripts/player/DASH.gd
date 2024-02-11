extends State

var dashing
var dash_direction = Vector2.ZERO
var speed = 2000
var end_speed = 400
var duration = 0.1
@onready var timer = $DashTimer

func update(delta):
	if dashing:
		player.velocity = dash_direction.normalized() * speed
	else:
		return exit_dash()
func enter_state():
	if not player.can_dash: return null
	dashing = true
	timer.start(duration)
	dash_direction = player.input_direction if player.input_direction else player.last_direction

func exit_state():
	dashing = false
	return exit_dash()

func exit_dash():
	player.velocity = dash_direction.normalized() * end_speed
	return states.MOVE

func _on_dash_timer_timeout():
	dashing = false
