extends Area2D

var health = Global.player_health
var damage = 5

export var movement_weight = 0.2

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
	scale = Vector2( 0.75 , 0.75 ) * Global.screen_ratio_y
	

func _process(_delta):
	if health<=0 :
		Global.game_over = true
		queue_free()
	

func _on_player_0_area_entered(area):
	if area.is_in_group("enemy"):
		health -= damage
	

