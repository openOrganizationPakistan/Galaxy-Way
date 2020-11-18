extends Node

var instance

func _select_level(index):
	
	instance = get_child(index).duplicate()
	return instance
	
