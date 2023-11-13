extends CharacterBody2D

var speed = 40
var dirt = 255

func _physics_process(delta):
	velocity.x = speed
	move_and_slide()

func _process(delta):
	$dirtlayer.modulate = dirt

func hit(cleaned):
	dirt -= cleaned
	print(dirt)
