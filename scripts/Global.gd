extends Node

var game_over = false

var clasic_mode = 0

var level = 0

var player = 0
var player_health = 40
var player_damage = 0
var player_fire_speed = 1

var rock_01_speed = 3
var mine_01_speed = 2

var ship_01_speed = 4
var ship_01_health = 20

var fire_type = 0

var plane_type = 0

var fire_damage = 0

var fire_rate = 1

var score = 0

onready var screen_size = get_viewport().size
onready var screen_ratio_x = screen_size.x / 480
onready var screen_ratio_y = screen_size.y / 720
onready var screen_ratio_avg = ( screen_ratio_x + screen_ratio_y ) / 2

func _ready():
	pass # Replace with function body.
