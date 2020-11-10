#script ship_01

extends Area2D

var speed = Global.ship_01_speed
var health = Global.ship_01_health
var damage = Global.fire_damage

var distroyed = false

var x_direction = 1
var playing = false

export (PackedScene) var laser_bullet_scn = preload ("res://scenes/fires/laser_bullets.tscn")

onready var sound_loop = $distroy_sound.stream as AudioStreamOGGVorbis

func _ready():
	
	x_direction = rand_range(-1,1) 
	
	scale = Vector2(0.2,0.2) * Global.screen_ratio_x
	
	sound_loop.loop = false
	

func _process(delta):
	position += Vector2(
		speed * x_direction *2 ,
		speed
	)
	
	if (position.x > Global.screen_size.x 
		or 
		position.x < 0
	):
		x_direction *=-1
	
	if health <=0 and !playing:
		$sprite.hide()
		scale = Vector2(2,2)
		$distroy_sprite.show()
		
		$distroy_sound.play()
		playing = true
		distroyed = true
		Global.score += 1
	
	if position.y > Global.screen_size.y:
		queue_free()
	
	if distroyed:
		rotation = lerp(rotation, 360 , delta * 0.01)
	

func _on_ship_01_area_entered(area):
	if area.is_in_group("enemy"):
		pass
	elif area.is_in_group("fire"):
		health -= damage
	else:
		Global.player_damage = 5
	

func _on_distroy_sound_finished():
	
	queue_free()
	
