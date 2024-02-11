extends State


func update(delta):
	player.gravity(delta)
	player_movement_air()
	if player.dash:
		return states.DASH
	if player.velocity.y > 0:
		return states.FALL 
	if player.check_wall_adjacent():
		return states.WALLJUMP
	return null
func enter_state():
	if player.last_state == states.WALLJUMP:
		player.velocity = Vector2(-states.WALLJUMP.direction.x * 800, -800)
	else:
		player.velocity.y = player.MAX_JUMP_VELOCITY
