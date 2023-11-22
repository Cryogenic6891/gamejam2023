extends Node

@onready var purple_fish = load("res://assets/__cartoon_fish_06_purple_swim.png")
@onready var red_fish = load("res://assets/__cartoon_fish_06_red_swim.png")
@onready var blue_fish = load("res://assets/__cartoon_fish_06_blue_swim.png")

var fish_sprites = {}

func _ready():
	fill_fish_sprites()
	
func fill_fish_sprites():
	fish_sprites["purple"] = purple_fish
	fish_sprites["red"] = red_fish
	fish_sprites["blue"] = blue_fish
