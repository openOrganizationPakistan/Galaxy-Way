extends Area2D

var health = Global.player_health

export var movement_weight = 0.5

var touch

func _input(event):
	if ( 
		event is InputEventScreenTouch
	):
		touch = true
	if (
		event is InputEventScreenDrag
		and 
		touch
	):
		position = lerp(position,event.position,movement_weight)
	

func _ready():
	scale = Vector2(1,1) * Global.screen_ratio_x
	

func _process(_delta):
	if health<=0 :
		queue_free()
	

func _on_player_0_area_entered(area):
	if area.is_in_group("enemy"):
		health -= Global.player_damage
		
	Global.player_health = health
	







