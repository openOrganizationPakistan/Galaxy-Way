extends Area2D

onready var laser_speed = 10 * Global.screen_ratio_y

onready var laser_beam_loop = $laser_beam.stream as AudioStreamOGGVorbis

func _ready():
	
	laser_beam_loop.loop = false
	$laser_beam.play()
	show()
	

func _process(_delta):
	position.y += laser_speed
	if position.y > Global.screen_size.y:
		queue_free()
	

func _on_laser_area_entered(area):
	if area.is_in_group("enemy"):
		pass
	else:
		Global.fire_damage = 100
		$shape.set_deferred("disabled",true)
		hide()
	

#func _on_laser_beam_finished():
#	queue_free()
