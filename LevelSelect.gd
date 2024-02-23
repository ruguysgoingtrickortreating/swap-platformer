extends Control



func _on_world_1_pressed():
	get_tree().change_scene_to_file("res://world.tscn")


func _on_world_2_pressed():
	get_tree().change_scene_to_file("res://world2.tscn")
