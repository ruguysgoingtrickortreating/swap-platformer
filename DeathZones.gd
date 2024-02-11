extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Area2D:
			child.body_entered.connect(die)

func die(charbody):
	owner.get_node("Char").position = $spawnpoint.position
	print("DIE")
