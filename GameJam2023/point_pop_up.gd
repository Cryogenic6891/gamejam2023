extends Node2D

@onready var text = $CanvasLayer/Container/Panel/Label
@onready var timer = $Timer
@onready var box = $CanvasLayer/Container

func _ready():
	timer.start()

func set_text(message):
	text.text = message

func new_position(pos):
	box.position = pos

func _on_timer_timeout():
	queue_free()
