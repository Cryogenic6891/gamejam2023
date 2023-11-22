extends Node2D

var powerup_type = ["triple","chaotic","ricochet","piercing"]
var direction = ["up","down"]
# Called when the node enters the scene tree for the first time.
func _ready():
	powerup_type = powerup_type.pick_random()
	direction = direction.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction == "up":
		position.y += 1
	else:
		position.y -= 1

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.powerup(powerup_type,self)
