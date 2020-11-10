extends Node

export (PackedScene) var enemy_scn

var enemy = 3

var rock_enemy = false
var mine_enemy = false
var ship_enemy = false

var enemy_instance

func _ready():
	$rock_spawn.start()
	$mines_timer.start()
	$spawn_ship.start()
	
	$rock_spawn.one_shot = true
	$mines_timer.one_shot = true
	$spawn_ship.one_shot = true
	

func _process(_delta):
	
	if rock_enemy:
		rock_enemy = false
		enemy = 0
		$rock_spawn.wait_time = rand_range(5,7)
		$rock_spawn.start()
		_spawn_enemy(enemy)
		
		
	if mine_enemy:
		mine_enemy = false
		enemy = 1
		$mines_timer.wait_time = rand_range(7,10)
		$mines_timer.start()
		_spawn_enemy(enemy)
	if ship_enemy:
		ship_enemy = false
		enemy = 2
		$spawn_ship.wait_time = rand_range(0.75,1.5)
		$spawn_ship.start()
		_spawn_enemy(enemy)
	

func _spawn_enemy(val):
	$Path2D/PathFollow2D.offset = randi()
	var rock_instance = enemy_scn.instance()._select_enemy(val)
	add_child(rock_instance)
	rock_instance.position = $Path2D/PathFollow2D.position
	
	$rock_spawn.wait_time = rand_range(5,10)
	

func _spawn_ship():
	ship_enemy = true
	pass # Replace with function body.


func _rock_enemy():
	rock_enemy = true
	pass # Replace with function body.


func _mine_enemy():
	mine_enemy = true
	pass # Replace with function body.
