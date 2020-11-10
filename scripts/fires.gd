extends Node2D



func _select_fire(index):
	return get_child(index).duplicate()
	

