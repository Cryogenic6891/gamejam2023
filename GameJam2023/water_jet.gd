extends CharacterBody2D

var launched = false
var max_speed = 500
var mass = 2
var ricochet = false
var piercing = false
var ignore = 0
var random = ["change_direction","speed_up","slow_down"]

var splash = preload("res://splash.tscn")
var water_jet = preload("res://water_jet.tscn")
var fadeout_timer = 5
@onready var timer = $Timer
@onready var timer2 = $Timer2

func _ready():
	timer.start(fadeout_timer)
	self.scale = self.scale * Main.ball_size

func make_chaotic(result):
	if result == true:
		timer2.start()


func _process(delta):
	
	if launched:
		# Update: delta is also needed here
		rotation = velocity.angle()
		velocity += Vector2(0,1)*98*mass*delta
		position += velocity*delta
		velocity = velocity.limit_length(max_speed * Main.ball_velocity)
	

func launch(initial_velocity : Vector2, speed):
	launched = true
	velocity = initial_velocity * speed * Main.ball_velocity
	


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if ignore == 0:
		var add_splash = splash.instantiate()
		get_parent().add_child(add_splash)
		add_splash.global_position = self.global_position
		body.hit(Main.ball_power)
		if ricochet == true:
			var shoot_jet = water_jet.instantiate()
			add_splash.call_deferred("add_child", shoot_jet)
			shoot_jet.launch(velocity.bounce(velocity.normalized()),0.5)
			shoot_jet.ignore = 1
		if piercing == false:
			queue_free()
	else:
		ignore -= 1


func _on_timer_timeout():
	queue_free()


func _on_timer_2_timeout():
	var result = random.pick_random()
	if result == "change_direction":
		velocity.x = -velocity.x
	elif result == "speed_up":
		velocity += velocity
	elif result == "slow_down":
		velocity = -velocity

