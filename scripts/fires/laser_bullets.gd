extends Area2D

var speed = 20
var delete = false

onready var sound_loop = $sound.stream as AudioStreamOGGVorbis

func _ready():
	Global.fire_type = 1
	sound_loop.loop = false
	$sound.play()
#	Global.fire_damage=50
#	Global.fire_rate=0.25
	show()
	

func _process(_delta):
	position.y -= speed
	if global_position.y < -Global.screen_size.y :
		queue_free()
	
	if delete and !$sound.playing:
		queue_free()
	

func _on_laser_bullets_area_entered(area):
	if area.is_in_group("player"):
		pass
	else:
		delete = true
	

