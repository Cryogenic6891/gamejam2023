extends CharacterBody2D

@export var point_follow : CharacterBody2D
var speed = 50
var max_speed = 400
var friction = 700

func _physics_process(delta):
	if point_follow != null:
		if position.distance_to(point_follow.position) > 50:
			velocity += global_position.direction_to(point_follow.global_position) * speed
			velocity = velocity.limit_length(max_speed)
			rotation = velocity.angle() + 30
		else:
			velocity -= velocity.normalized() * (friction * delta)
		move_and_slide()

func hit(_x):
	pass
