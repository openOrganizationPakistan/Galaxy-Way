extends Node

export (PackedScene) var enemy_scn
export (PackedScene) var enemy_fire_scn

var enemy = 3

var enemy_health_1 = 1
var enemy_health_2 = 20
var enemy_health_3 = 100

var fire = false

onready var enemy_snc_instance = enemy_scn.instance()
onready var enemy_fire_scn_instance = enemy_fire_scn.instance()

var enemy_instance
var allow_fire = false

func _process(_delta):
	randomize()
	

func _ready():
	$rock_spawn.start()
	$mines_timer.start()
	$spawn_ship.start()
	
	$rock_spawn.one_shot = true
	$mines_timer.one_shot = true
	$spawn_ship.one_shot = true
	
	$Path2D.scale = Vector2( 1 , 1 ) * Global.screen_ratio_x
	

func _spawn_enemy(val):
	$Path2D/PathFollow2D.offset = randi()
	
	enemy_instance = enemy_snc_instance._select_enemy(val)
	
	add_child(enemy_instance)
	enemy_instance.position = $Path2D/PathFollow2D.position
#	$rock_spawn.wait_time = rand_range(5,10)
	if val == 2:
		allow_fire = true
	else: 
		allow_fire = false
		
	

func _spawn_ship():
	enemy = 2
	$spawn_ship.wait_time = rand_range(1,2)
	$spawn_ship.start()
	_spawn_enemy(enemy)
	

func _rock_enemy():
	enemy = 0
	$rock_spawn.wait_time = rand_range(5,7)
	$rock_spawn.start()
	_spawn_enemy(enemy)
	

func _mine_enemy():
	enemy = 1
	$mines_timer.wait_time = rand_range(7,10)
	$mines_timer.start()
	_spawn_enemy(enemy)
	

func _on_ship_01_fire_timeout():
	
	if allow_fire:
		var fire_instance = enemy_fire_scn_instance._select_fire(enemy-2)
		fire_instance.position = enemy_instance.global_position + Vector2(0, 15 * Global.screen_ratio_y)
		add_child(fire_instance)
		
	
