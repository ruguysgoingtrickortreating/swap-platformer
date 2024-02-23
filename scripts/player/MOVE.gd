extends State


func update(delta):
	sprite.flip_h = player.velocity.x < 0
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

func enter_state():
	sprite.play("run")
	if player.bufferjump:
		player.bufferjump = false
		player.bufferjump_timer.stop()
		return states.JUMP
