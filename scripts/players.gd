extends Node2D

var instance

func _select_player(index):
	instance = get_child(index).duplicate()
	return instance

