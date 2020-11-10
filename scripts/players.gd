extends Node2D

func _select_player(index):
	return get_child(index).duplicate()

