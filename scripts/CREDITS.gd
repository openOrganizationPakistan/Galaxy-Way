#SCRIPT: CREDITS
extends MarginContainer




func _on_Button_pressed():
	get_tree().change_scene("res://scenes/HUD.tscn")
	queue_free()
	
