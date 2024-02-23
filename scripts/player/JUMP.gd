extends State


func update(delta):
	if player.velocity.x != 0:
		sprite.flip_h = player.velocity.x < 0
	else:
		sprite.flip_h = player.last_direction.x < 0
	
	player.gravity(delta)
	player_movement_air()
	
	if player.input_direction.y > 0:
		player.velocity.y += 50
		sprite.play("hardfall")
	else:
		sprite.play("jump")
	
	if player.dash:
		return states.DASH
	if player.jump:
		player.buffer_jump()
	if player.velocity.y > 0:
		return states.FALL 
	if player.check_wall_adjacent():
		return states.WALLJUMP
	return null
func enter_state():
	sprite.play("jump")
	if player.last_state == states.WALLJUMP:
		player.velocity = Vector2(-states.WALLJUMP.direction.x * 600, -600)
	else:
		player.velocity.y = player.MAX_JUMP_VELOCITY
