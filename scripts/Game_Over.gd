extends Control



func _on_Timer_timeout():
	return get_tree().change_scene("res://scenes/HUD.tscn")
	
