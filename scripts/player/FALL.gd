extends State

@onready var timer = $CoyoteTimer
var coyote_jump

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
		sprite.play("fall")
	
	if player.dash:
		return states.DASH
	if player.check_wall_adjacent():
		return states.WALLJUMP
	if player.jump:
		if coyote_jump:
			return states.JUMP
		else:
			player.buffer_jump()
	if player.is_on_floor():
		if player.jump or player.bufferjump:
			player.bufferjump_timer.stop()
			player.bufferjump = false
			return states.JUMP
		else:
			return states.IDLE
	return null

func enter_state():
	sprite.play("fall")
	match player.last_state:
		states.MOVE:
			pass
		states.WALLJUMP:
			pass
		_:
			print(player.last_state)
			return null
	timer.start(0.08)
	coyote_jump = true

#func exit_state():
	#timer.stop()

func _on_coyote_timer_timeout():
	coyote_jump = false
