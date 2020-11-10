extends CanvasLayer

export (PackedScene) var levels_scn = preload("res://scenes/levels.tscn")

export (PackedScene) var players_scn = preload("res://scenes/players.tscn")

export (PackedScene) var fires_scn = preload("res://scenes/fires.tscn")

onready var fps = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/FPS
onready var cpu_times = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/CPU_Times

onready var health = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/HBoxContainer/health
onready var score = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/HBoxContainer2/score

onready var clasic_high_score = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/high_score_clasic
onready var story_high_score = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/high_score_story

onready var clasic_play_button = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer/clasic
onready var story_play_button = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer/VBoxContainer/story

var player_instance

onready var particles_BG = $CPUParticles2D.process_material as ParticlesMaterial

func _ready():
	
	particles_BG.scale = 0.25 * Global.screen_ratio_y
	
	$CPUParticles2D.position.x = Global.screen_size.x / 2
	$CPUParticles2D.position.y = (-Global.screen_ratio_y)
	$CPUParticles2D.lifetime = 5 * Global.screen_ratio_y
	particles_BG.emission_box_extents = Vector3(Global.screen_size.x / 2,1,1)
	

func _process(_delta):
	
	health.text = "Health" + str(Global.player_health)
	fps.text = "FPS: " + str(Performance.get_monitor(0))
	cpu_times.text = "CPU_times: " + str(floor(Performance.get_monitor(1) * 1000 ) )
	
	score.text = str(Global.score)
	

func _add_fire():
	var open_fire = fires_scn.instance()._select_fire(Global.fire_type).duplicate()
	open_fire.position = Vector2 ( player_instance.global_position.x , player_instance.global_position.y + (-Global.screen_ratio_y*60) )
	add_child(open_fire)


func _on_clasic_pressed():
	Global.clasic_mode = 1	
	_hide_stuff()
	var scene_instance = levels_scn.instance()
	scene_instance._select_level(Global.level)
	add_child(scene_instance)
	_add_player()
	

func _hide_stuff():
	$TextureRect2.hide()
	clasic_high_score.hide()
	story_high_score.hide()
	clasic_play_button.hide()
	story_play_button.hide()
	

func _add_player():
	player_instance = players_scn.instance()._select_player(Global.player).duplicate()
	add_child(player_instance)
	$player_fire_timer.start()
	

func _on_player_fire_timer_timeout():
	_add_fire()
	
