#scrip: HUD

extends CanvasLayer

export (PackedScene) var levels_scn = preload("res://scenes/levels.tscn")

export (PackedScene) var players_scn = preload("res://scenes/players.tscn")

export (PackedScene) var fires_scn = preload("res://scenes/fires.tscn")

onready var fps = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/FPS
onready var cpu_times = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/CPU_Times
onready var ram_usage = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/memory
onready var orphan_nodes = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/orphan_nodes
onready var object_count = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/objects_count
onready var play_counts = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/play_counts

onready var health = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/HBoxContainer/health
onready var score = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/HBoxContainer2/score

onready var high_score = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/high_score_clasic

onready var clasic_play_button = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer/clasic
onready var story_play_button = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer/story

onready var fire_type = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/fire_type

onready var particles_node = $CPUParticles2D

onready var player_instance
onready var scene_instance

onready var fires_scn_instance = fires_scn.instance()

func _ready():
	
	play_counts.text = "Play Counts: " + str(Global.play_counts)
	
	particles_node.scale_amount = 0.25 * Global.screen_ratio_y
	
	particles_node.position.x = Global.screen_size.x / 2
	particles_node.position.y = (-Global.screen_ratio_y)
	particles_node.lifetime = 5 * Global.screen_ratio_y
	particles_node.emission_rect_extents = Vector2(Global.screen_size.x/2,1)


func _process(_delta):
	
	orphan_nodes.text = "Orphan Nodes: " + str(Performance.get_monitor(11))
	fps.text = "FPS : " + str(Performance.get_monitor(0))
	cpu_times.text = "CPU_times: " + str(floor(Performance.get_monitor(1) * 1000 ) )
	ram_usage.text = "RAM usage: " + str(floor(Performance.get_monitor(3) / 1024 / 1024 ) ) + "MB"
	score.text = str(Global.score)
	object_count.text = "Objects Count: " + str(Performance.get_monitor(8))
	

func _on_clasic_pressed():
	
	Global.play_counts += 1
	
	_start_game()
	

func _start_game():
	Global.player_health=40
	Global.game_over = false
	Global.clasic_mode = 1
	_hide_stuff()
	var levels_scn_instance = levels_scn.instance()
	scene_instance = levels_scn_instance._select_level(Global.level)
	levels_scn_instance.queue_free()
	add_child(scene_instance)
	_add_player()
	

func _hide_stuff():
	$TextureRect2.hide()
	high_score.hide()
	fire_type.hide()
	clasic_play_button.hide()
	story_play_button.hide()
	

func _add_player():
	var players_scn_instance = players_scn.instance()
	player_instance = players_scn_instance._select_player(Global.player).duplicate()
	players_scn_instance.queue_free()
	add_child(player_instance)
	$player_fire_timer.start()
	player_instance.position = Global.screen_size/2
	

func _show_stuff():
	$TextureRect2.show()
	high_score.show()
	fire_type.show()
	clasic_play_button.show()
	story_play_button.show()
	

func _on_player_fire_timer_timeout():
	_add_fire()
	$player_fire_timer.wait_time = Global.fire_rate
	

func _add_fire():
	if !Global.game_over:
		
		health.text = "Health: " + str(player_instance.health)
		
		_match_fire_type()
		var open_fire = fires_scn_instance._select_fire(Global.fire_type)
		open_fire.position = Vector2 ( player_instance.global_position.x , player_instance.global_position.y + (- Global.screen_ratio_y * 40) )
		add_child(open_fire)
	
	else:
		
		health.text = "Health: 0"
		
		$player_fire_timer.stop()
		Global.game_over=false
		_show_stuff()
		scene_instance.queue_free()
		queue_free()
		var _temp = get_tree().change_scene("res://scenes/Game_Over.tscn")
		
	

func _on_fire_type_item_selected(index):
	match index :
		0:
			Global.fire_type = 0
		1:
			Global.fire_type = 1
		2:
			var _temp = get_tree().change_scene("res://scenes/CREDITS.tscn")
			queue_free()
		_:
			Global.fire_type = 0
		
	

func _match_fire_type():
	
	match Global.fire_type:
		0:
			Global.fire_damage = 500
			Global.fire_rate = 1
		1:
			Global.fire_damage = 50
			Global.fire_rate = 0.25
		_:
			Global.fire_damage = 500
			Global.fire_rate = 1
			
		
	

