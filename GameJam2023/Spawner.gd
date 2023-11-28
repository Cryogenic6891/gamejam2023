extends Node2D

var fish = preload("res://fish.tscn")
var pop_up = preload("res://point_pop_up.tscn")
var spawn_points = []
var spawn_rate = 4
var spawn_ok = true
var level_spawner = true
var spawn_color = ["purple", "red", "blue"]

signal spawn_counter

@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in self.get_children():
		if i.is_in_group("spawn"):
			spawn_points.append(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawn_ok == true and level_spawner == true:
		spawn()

func spawn(fish_color = spawn_color):
	var spawn_fish = fish.instantiate()
	add_child(spawn_fish)
	spawn_fish.position = spawn_points.pick_random().position
	spawn_fish.spawn(fish_color)
	spawn_counter.emit()
	spawn_ok = false
	timer.start(spawn_rate)

func _on_timer_timeout():
	spawn_ok = true

func _on_despawner_body_entered(body):
	if body.is_in_group("fish"):
		var spawn_pop_up = pop_up.instantiate()
		add_child(spawn_pop_up)
		spawn_pop_up.set_text(str(body.clean_points * Main.combo))
		spawn_pop_up.new_position(body.global_position - Vector2(80,0))
		Main.update_points(body.clean_points * Main.combo)
		if body.dirt <= 0:
			Main.combo += 1
		else:
			Main.combo = 1
			Main.dirt_current += body.dirt
		body.queue_free()
