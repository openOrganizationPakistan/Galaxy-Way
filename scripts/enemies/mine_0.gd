#script: mine_01

extends Area2D

var speed = Global.mine_01_speed

onready var sound_loop_property = $sound.stream as AudioStreamOGGVorbis

func _ready():
	
	sound_loop_property.loop = false
	
	scale = Vector2(2,2) * Global.screen_ratio_x
	

func _process(delta):
	rotation = lerp (rotation, 360 , delta * 0.005)
	
	position.y += speed
	

func _on_mine_0_area_entered(area):
	
	if area.is_in_group("enemy"):
		pass
	elif area.is_in_group("player"):
		Global.player_damage = 100
	else:
		if !$sound.playing:
			$sprite.animation = "distroy"
			$sound.play()
			Global.score += 1
		
	

func _on_sound_finished():
	queue_free()
	
