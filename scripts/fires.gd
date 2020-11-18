extends Node2D

var instance

func _select_fire(index):
	instance = get_child(index).duplicate()
	return instance

