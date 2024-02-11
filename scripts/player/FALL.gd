extends State


func update(delta):
	player.gravity(delta)
	player_movement_air()
	if player.dash:
		return states.DASH
	if player.check_wall_adjacent():
		return states.WALLJUMP
	if player.is_on_floor():
		if player.jump:
			return states.JUMP
		else:
			return states.IDLE
	return null
