extends CharacterBody2D

var water_jet = preload("res://water_jet.tscn")
@onready var cooldown_timer = $Timer
var fire_rate = 0.5
var jet_speed = 2
var shoot_cooldown = false

var max_speed = 400
var accel = 1500
var friction = 600

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)
	if Input.is_action_pressed("shoot") and shoot_cooldown == false:
		fire_jet()

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	return input.normalized()

func fire_jet():
	var shoot_jet = water_jet.instantiate()
	shoot_jet.position = $barrel/Marker2D.global_position
	owner.add_child(shoot_jet)
	shoot_jet.launch(get_local_mouse_position(),jet_speed)
	shoot_cooldown = true
	start_shoot_cooldown()

func start_shoot_cooldown():
	cooldown_timer.start(fire_rate)

func player_movement(delta):
	input = get_input()
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	move_and_slide()


func _on_timer_timeout():
	shoot_cooldown = false
