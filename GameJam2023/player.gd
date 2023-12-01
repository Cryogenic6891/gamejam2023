extends CharacterBody2D

var water_jet = preload("res://water_jet.tscn")
@onready var cooldown_timer = $Timer
@onready var power_timer = $power_timer
@onready var SE = $AudioStreamPlayer
var power_length = 10
var jet_speed = 2
var shoot_cooldown = false

var max_speed = 400
var accel = 1500
var friction = 600

var triple_shot = false
var ricochet = false
var chaotic = false
var piercing = false

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)
	if Input.is_action_pressed("shoot") and shoot_cooldown == false:
		fire_jet()
		SE.play()
		

func get_input():
	if self.name == "bottomTurret":
		input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
		return input.normalized()
	if self.name == "topTurret":
		input.x = int(Input.is_action_pressed("left")) - int(Input.is_action_pressed("right"))
		return input.normalized()

func fire_jet():
	var shoot_jet = water_jet.instantiate()
	shoot_jet.position = $barrel/Marker2D.global_position
	owner.add_child(shoot_jet)
	shoot_jet.launch(get_local_mouse_position(),jet_speed)
	if triple_shot == true:
		var shoot_jet2 = water_jet.instantiate()
		var shoot_jet3 = water_jet.instantiate()
		shoot_jet2.position = $barrel/Marker2D.global_position
		shoot_jet3.position = $barrel/Marker2D.global_position
		owner.add_child(shoot_jet2)
		owner.add_child(shoot_jet3)
		shoot_jet2.launch(get_local_mouse_position() * Vector2(0.5,1),jet_speed)
		shoot_jet2.ricochet = ricochet
		shoot_jet2.make_chaotic(chaotic)
		shoot_jet2.piercing = piercing
		shoot_jet3.launch(get_local_mouse_position() * Vector2(1.5,1),jet_speed)
		shoot_jet3.ricochet = ricochet
		shoot_jet3.make_chaotic(chaotic)
		shoot_jet3.piercing = piercing
	shoot_jet.ricochet = ricochet
	shoot_jet.make_chaotic(chaotic)
	shoot_jet.piercing = piercing
	shoot_cooldown = true
	start_shoot_cooldown()

func start_shoot_cooldown():
	cooldown_timer.start(Main.ball_rate)

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

func hit(_x):
	pass

func powerup(type,node):
	if type == "triple":
		triple_shot = true
	elif type == "chaotic":
		chaotic = true
	elif type == "ricochet":
		ricochet = true
	elif type == "piercing":
		piercing = true
	power_timer.start(power_length)
	node.queue_free()

func _on_timer_timeout():
	shoot_cooldown = false


func _on_power_timer_timeout():
	triple_shot = false
	chaotic = false
	ricochet = false
	piercing = false
