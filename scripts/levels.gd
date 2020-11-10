extends Node



func _select_level(index):
	return get_child(index).duplicate()
