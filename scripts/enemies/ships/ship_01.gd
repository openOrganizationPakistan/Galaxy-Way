#script ship_01

extends Area2D

#export (PackedScene) var fire = preload("res://scenes/enemies/ships/ship_01_fire.tscn")

onready var speed = Global.ship_01_speed
onready var health = Global.ship_01_health
onready var damage = Global.fire_damage

var distroyed = false

var x_direction = 1
var playing = false

export (PackedScene) var laser_bullet_scn = preload ("res://scenes/fires/laser_bullets.tscn")

onready var sound_loop = $distroy_sound.stream as AudioStreamOGGVorbis

func _ready():
	
#	position.x = Global.screen_size.x/2
	
	x_direction = rand_range(-1,1) 
	
	scale = Vector2(1,1) * Global.screen_ratio_x
	
	sound_loop.loop = false
	

func _process(delta):
	
	position += Vector2(
		speed * x_direction *2 ,
		speed
	)
	
	if (position.x > Global.screen_size.x - (20 * Global.screen_ratio_x )
		or 
		position.x < 20*Global.screen_ratio_x
	):
		x_direction *=-1
		
	
	if position.y > (720 * Global.screen_ratio_y):
		queue_free()
		
	
	if distroyed:
		rotation = lerp(rotation, 360 , delta * 0.01)
		
	

func _on_ship_01_area_entered(area):
	if area.is_in_group("enemy"):
		pass
#	elif area.is_in_group("fire"):
#		health -= damage
#	elif area.is_in_group("player"):
#		Global.player_damage = 5
	else:
		
		health -= damage
		
	
	
	if health <=0 and !playing and !$shape.disabled:
		$shape.set_deferred("disabled",true)
		$sprite.hide()
		$distroy_sprite.show()
		
		$distroy_sound.play()
		playing = true
		distroyed = true
		Global.score += 1
	

func _on_distroy_sound_finished():
	
	queue_free()
	

