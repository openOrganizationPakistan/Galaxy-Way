extends Node2D

func _select_enemy(index):
	return get_child(index).duplicate()
	
