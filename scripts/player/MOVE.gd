extends State


func update(delta):
	player.gravity(delta)
	player_movement()
	if player.dash:
		return states.DASH
	if player.jump:
		return states.JUMP
	if not player.is_on_floor() and player.check_wall_adjacent():
		return states.WALLJUMP
	if not player.velocity.x:
		return states.IDLE
	if player.velocity.y > 0:
		return states.FALL
	return null
	
