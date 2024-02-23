extends State


func update(delta):
	sprite.flip_h = player.last_direction.x < 0
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

func enter_state():
	sprite.play("idle")
	if player.bufferjump:
		player.bufferjump = false
		player.bufferjump_timer.stop()
		return states.JUMP
