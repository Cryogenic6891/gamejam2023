extends CharacterBody2D

var water_jet = preload("res://oil_jet.tscn")
@onready var cooldown_timer = $Timer
@onready var power_timer = $power_timer
var power_length = 10
var jet_speed = 2
var shoot_cooldown = false
@export var point_follow : Path2D

var hp = 150
@onready var damage_timer = $Timer2

var max_speed = 400
var speed = 400
var accel = 1500
var friction = 600

var triple_shot = false
var ricochet = false
var chaotic = false
var piercing = false

var input = Vector2.ZERO

func _ready():
	point_follow = get_tree().get_nodes_in_group("path")[0]
	cooldown_timer.start(0.1)

func _physics_process(delta):
	boss_movement(delta)
	fire_jet()

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized()

func fire_jet():
	if shoot_cooldown == false:
		var shoot_jet = water_jet.instantiate()
		shoot_jet.position = global_position
		get_parent().add_child(shoot_jet)
		shoot_jet.ignore = 1
		shoot_jet.launch(velocity,jet_speed)
		if triple_shot == true:
			pass
		shoot_jet.ricochet = ricochet
		shoot_jet.make_chaotic(chaotic)
		shoot_jet.piercing = piercing
		shoot_cooldown = true
		start_shoot_cooldown()

func start_shoot_cooldown():
	cooldown_timer.start(0.3)

func boss_movement(delta):
	rotation = velocity.angle() + 30
	if position.distance_to(point_follow.path.position) > 100:
		velocity += global_position.direction_to(point_follow.path.global_position) * speed
		velocity = velocity.limit_length(max_speed)
	move_and_slide()

func hit(_x):
	hp -= 1
	damage_timer.start(0.1)
	modulate = Color.RED
	if hp == 0:
		get_tree().quit()

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


func _on_timer_2_timeout():
	modulate = Color.WHITE
