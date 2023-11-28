extends Node2D

var total_points = 0
var combo = 1
var combo_max = 5
var dirt_max = 1200
var dirt_current = 0

var size_cost = 10
var velocity_cost = 25
var rate_cost = 50
var power_cost = 50

var ball_size = 1
var ball_size_max = 7.75
var ball_velocity = 1
var ball_velocity_max = 2
var ball_rate = 1
var ball_rate_max = 0.25
var ball_power = 10
var ball_power_max = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if combo > 5:
		combo = 5
	if dirt_current >= dirt_max:
		get_tree().reload_current_scene()

func update_points(points):
	total_points += points
