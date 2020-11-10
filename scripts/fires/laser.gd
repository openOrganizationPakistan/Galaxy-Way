extends Area2D

export var laser_speed = 5

onready var laser_beam_loop = $laser_beam.stream as AudioStreamOGGVorbis

func _ready():
	Global.fire_damage = 0
	
	laser_beam_loop.loop = false
	$laser_beam.play()
#	scale = Vector2(0.5,1) * Global.screen_ratio_x
	Global.fire_rate = 1
	show()
	



func _process(_delta):
	scale.y += laser_speed
	
	

func _on_laser_area_entered(_area):
	Global.fire_damage = 100
	

func _on_laser_beam_finished():
	queue_free()
