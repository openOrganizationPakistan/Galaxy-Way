#rock 01
extends Area2D

var speed = Global.rock_01_speed


func _process(delta):
	rotation = lerp (rotation, rand_range(0,360), delta*0.01)
	
	position.y += speed
	
	if position.y > Global.screen_size.y:
		queue_free()
	

func _ready():
	
	
	scale = Vector2(0.2,0.2) * Global.screen_ratio_x
	
	pass

func _on_rock_01_area_entered(area):
	if area.is_in_group("enemy"):
		pass
	else:
		Global.fire_damage = 10
	
