extends CharacterBody2D

var speed = 40
var dirt = 250
var starting_dirt : int
var points_per_dirt = 1
var clean_points : int

func _ready():
	starting_dirt = dirt

func _physics_process(delta):
	velocity.x = speed
	move_and_slide()

func _process(delta):
	$dirtlayer.modulate = dirt

func hit(cleaned):
	dirt -= cleaned
	if dirt < 0:
		dirt = 0
		$sparkle.emitting = true
	clean_points = int(round(float(starting_dirt-dirt)/5)) * points_per_dirt
	if clean_points == null:
		clean_points = 0
