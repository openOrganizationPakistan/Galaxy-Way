extends Area2D

var speed = 20

func _ready():
	pass # Replace with function body.
	

func _process(_delta):
	position.y += speed
	if global_position.y > Global.screen_size.y:
		queue_free()
