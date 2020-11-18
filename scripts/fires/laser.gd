extends Area2D

onready var laser_speed = 150 * Global.screen_ratio_y

onready var laser_beam_loop = $laser_beam.stream as AudioStreamOGGVorbis

func _ready():
	
	Global.fire_type = 0
#	Global.fire_damage = 500
	laser_beam_loop.loop = false
	$laser_beam.play()
#	scale = Vector2(0.5,1) * Global.screen_ratio_x
#	Global.fire_rate = 1
	show()
	

func _process(delta):
	scale.y = lerp (scale.y , laser_speed , delta)
	

func _on_laser_area_entered(area):
	if area.is_in_group("player"):
		pass
	else:
		Global.fire_damage = 100
		$shape.set_deferred("disabled",true)
		hide()
	

func _on_laser_beam_finished():
	queue_free()
