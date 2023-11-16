extends CharacterBody2D

var launched = false
var max_speed = 500
var mass = 2

var splash = preload("res://splash.tscn")
var fadeout_timer = 5
@onready var timer = $Timer

func _ready():
	timer.start(fadeout_timer)
	self.scale = self.scale * Main.ball_size 


func _process(delta):
	
	if launched:
		# Update: delta is also needed here
		velocity += Vector2(0,1)*98*mass*delta
		
		position += velocity*delta
		
		rotation = velocity.angle()
		velocity = velocity.limit_length(max_speed * Main.ball_velocity)
	

func launch(initial_velocity : Vector2, speed):
	launched = true
	velocity = initial_velocity * speed * Main.ball_velocity
	


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	var add_splash = splash.instantiate()
	get_parent().add_child(add_splash)
	add_splash.global_position = self.global_position
	body.hit(Main.ball_power)
	queue_free()



func _on_timer_timeout():
	queue_free()
