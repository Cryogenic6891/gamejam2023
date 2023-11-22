extends CharacterBody2D

var fish_color = ["purple", "red", "blue"]

var random_fish = true
var fish_type = "purple"
var speed = 40
var points_per_dirt = 1
var hp_multiplyer = 1
var scale_multiplyer = 1
var starting_dirt : int
var dirt = 250
var clean_points : int
var powerup_check = false

var rng = RandomNumberGenerator.new()
var powerup_spawn = preload("res://powerup.tscn")

@onready var anim_clean = $AnimationPlayer
@onready var anim_dirt = $AnimationPlayer2
@onready var sprite = $fish

var fish_dict = {
	"purple" : {"speed" : 40,"points" : 1,"dmg" : 1,"scale" : 1},
	"red" : {"speed" : 100,"points" : 2,"dmg" : 4,"scale" : 0.5},
	"blue" : {"speed" : 20,"points" : 1.5,"dmg" : 0.25,"scale" : 2}
}

func _ready():
	starting_dirt = dirt
	anim_clean.play("swim")
	anim_dirt.play("swim")
	if random_fish == true:
		fish_color = fish_color.pick_random()
	else:
		fish_color = "purple"
	var fish_stats = fish_dict[fish_color]
	speed = fish_stats["speed"]
	points_per_dirt = fish_stats["points"]
	hp_multiplyer = fish_stats["dmg"]
	scale = scale * fish_stats["scale"]
	sprite.texture = Sprites.fish_sprites[fish_color]

func _physics_process(delta):
	velocity.x = speed
	move_and_slide()

func _process(_delta):
	$dirtlayer.modulate = dirt

func hit(cleaned):
	dirt -= int(round(cleaned * hp_multiplyer))
	if dirt < 0:
		dirt = 0
		$sparkle.emitting = true
		var random_number = rng.randi_range ( 1, 100)
		if random_number <= 10 and powerup_check == false:
			var powerup = powerup_spawn.instantiate()
			get_parent().call_deferred("add_child", powerup)
			powerup.global_position = global_position
		powerup_check = true
	clean_points = int(round(float(starting_dirt-dirt)/5)) * points_per_dirt
	if clean_points == null:
		clean_points = 0
