extends Node
class_name State

var states
var player

func enter_state():
	pass
func exit_state():
	pass
func update(delta):
	return null
func player_movement():
	if player.input_direction:
		#player.velocity.x = lerp (player.velocity.x, player.input_direction.x * player.SPEED, 0.3)
		player.velocity.x = move_toward(player.velocity.x, player.input_direction.x * player.SPEED, 120)
		
		if player.input_direction.x > 0:
			player.last_direction = Vector2.RIGHT
		elif player.input_direction.x < 0:
			player.last_direction = Vector2.LEFT
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, 75)

func player_movement_air():
	if player.input_direction:
		#player.velocity.x = lerp (player.velocity.x, player.input_direction.x * player.SPEED, 0.3)
		player.velocity.x = move_toward(player.velocity.x, player.input_direction.x * player.SPEED, 100)
		
		if player.input_direction.x > 0:
			player.last_direction = Vector2.RIGHT
		elif player.input_direction.x < 0:
			player.last_direction = Vector2.LEFT
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, 50)
	
