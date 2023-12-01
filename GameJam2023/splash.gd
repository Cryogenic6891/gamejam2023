extends AudioStreamPlayer

var splash1 = preload("res://sounds/SE Fish Hit 1.wav")
var splash2 = preload("res://sounds/SE Fish Hit 2.wav")
var splash3 = preload("res://sounds/SE Fish Hit 3.wav")
var splash4 = preload("res://sounds/SE Fish Hit 4.wav")

var all_splashes = []
# Called when the node enters the scene tree for the first time.
func _ready():
	all_splashes.append(splash1)
	all_splashes.append(splash2)
	all_splashes.append(splash3)
	all_splashes.append(splash4)
	stream = all_splashes.pick_random()
	playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
