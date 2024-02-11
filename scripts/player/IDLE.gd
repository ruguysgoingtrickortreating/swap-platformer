extends State


func update(delta):
	player.gravity(delta)
	if player.dash:
		return states.DASH
	if player.input_direction.x or player.velocity.x:
		return states.MOVE
	if player.jump:
		return states.JUMP
	if player.velocity.y > 0:
		return states.FALL
	return null

