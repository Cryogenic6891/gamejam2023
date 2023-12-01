extends Node2D

@onready var spawner = $Spawner
@onready var jukebox = $AudioStreamPlayer
@onready var background = $AudioStreamPlayer2

var main_theme = preload("res://sounds/Main Theme.wav")
var boss_theme = preload("res://sounds/Boss Battle.wav")
var end_credits = preload("res://sounds/End Credits.wav")

var boss = preload("res://wormboss.tscn")
var thorax = preload("res://thorax.tscn")
var seg = preload("res://segment.tscn")

var level_spawner = true
var spawn_color = ["purple", "red", "blue"]
var spawn_rate = 4
var boss_end = false

var spawn_counter = 0

func _ready():
	jukebox.stream = main_theme
	background.playing = true
	jukebox.playing = true
	
func _process(delta):
	level1()

func level1():
	spawner.spawn_color = ["purple"]
	spawner.spawn_rate = 10
	if spawn_counter == 3:
		spawner.spawn_color = ["blue"]
	if spawn_counter >= 7:
		spawner.spawn_color = ["purple","red"]
		spawner.spawn_rate = 6
	if spawn_counter == 10:
		spawner.spawn_color = ["blue"]
	if spawn_counter >= 20:
		spawner.spawn_color = ["purple","red"]
		spawner.spawn_rate = 3
	if spawn_counter == 15:
		spawner.spawn_color = ["blue"]
	if spawn_counter == 25:
		spawner.spawn_color = ["blue"]
	if spawn_counter == 35:
		spawner.spawn_color = ["blue"]
	if spawn_counter == 45:
		spawner.spawn_color = ["blue"]
	if spawn_counter >= 55:
		spawner.spawn_color = ["purple","red"]
		spawner.spawn_rate = 1
	if spawn_counter == 70:
		spawner.spawn_color = ["blue"]
	if spawn_counter >= 100:
		spawner.spawn_color = ["red"]
		spawner.spawn_rate = 0.75
	if spawn_counter == 120:
		spawner.spawn_color = ["blue"]
	if spawn_counter == 130:
		if boss_end == false:
			jukebox.stream = boss_theme
			jukebox.play()
			spawn_boss()

func _on_spawner_spawn_counter():
	spawn_counter += 1

func spawn_boss():
	var spawn = boss.instantiate()
	add_child(spawn)
	spawn.position = Vector2(-300, 300)
	var s1 = thorax.instantiate()
	add_child(s1)
	s1.point_follow = spawn
	s1.position = Vector2(-300, 300)
	var s2 = seg.instantiate()
	add_child(s2)
	s2.point_follow = s1
	s2.position = Vector2(-300, 300)
	var s3 = seg.instantiate()
	add_child(s3)
	s3.point_follow = s2
	s3.position = Vector2(-300, 300)
	var s4 = seg.instantiate()
	add_child(s4)
	s4.point_follow = s3
	s4.position = Vector2(-300, 300)
	var s5 = seg.instantiate()
	add_child(s5)
	s5.point_follow = s4
	s5.position = Vector2(-300, 300)
	boss_end = true
