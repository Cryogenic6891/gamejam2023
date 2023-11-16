extends CanvasLayer

@onready var total = $PanelContainer/Panel/VBoxContainer/HBoxContainer3/total
@onready var size = $"PanelContainer/Panel/VBoxContainer/HBoxContainer/size cost"
@onready var velocity = $"PanelContainer/Panel/VBoxContainer/HBoxContainer2/velocity cost"
@onready var rate = $"PanelContainer/Panel/VBoxContainer/HBoxContainer4/rate cost"
@onready var power = $"PanelContainer/Panel/VBoxContainer/HBoxContainer5/power cost"
@onready var combo = $PanelContainer3/Panel/VBoxContainer/HBoxContainer/combo
@onready var dirt_current = $"PanelContainer2/Panel/VBoxContainer/HBoxContainer2/dirt current"
@onready var dirt_max = $"PanelContainer2/Panel/VBoxContainer/HBoxContainer/dirt max"
@onready var timer = $Timer

@onready var size_button = $PanelContainer/Panel/VBoxContainer/HBoxContainer/size
@onready var velocity_button = $PanelContainer/Panel/VBoxContainer/HBoxContainer2/velocity
@onready var rate_button = $PanelContainer/Panel/VBoxContainer/HBoxContainer4/rate
@onready var power_button = $PanelContainer/Panel/VBoxContainer/HBoxContainer5/power
# Called when the node enters the scene tree for the first time.
func _ready():
	dirt_max.text = str(Main.dirt_max)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	total.text = str(Main.total_points)
	size.text = str(Main.size_cost)
	velocity.text = str(Main.velocity_cost)
	rate.text = str(Main.rate_cost)
	power.text = str(Main.power_cost)
	combo.text = str(Main.combo)
	dirt_current.text = str(Main.dirt_current)


func _on_size_pressed():
	if Main.total_points > Main.size_cost:
		Main.ball_size += 0.75
		Main.total_points -= Main.size_cost
		Main.size_cost = Main.size_cost * 2
		if Main.ball_size >= Main.ball_size_max:
			size_button.disabled = true
			Main.size_cost = "Max"


func _on_velocity_pressed():
	if Main.total_points > Main.velocity_cost:
		Main.ball_velocity += 0.1
		Main.total_points -= Main.velocity_cost
		Main.velocity_cost = Main.velocity_cost *2
		if Main.ball_velocity >= Main.ball_velocity_max:
			velocity_button.disabled = true
			Main.velocity_cost = "Max"


func _on_rate_pressed():
	if Main.total_points > Main.rate_cost:
		Main.ball_rate -= 0.1
		Main.total_points -= Main.rate_cost
		Main.rate_cost = Main.rate_cost *2
		if Main.ball_rate <= Main.ball_rate_max:
			rate_button.disabled = true
			Main.rate_cost = "Max"


func _on_power_pressed():
	if Main.total_points > Main.power_cost:
		Main.ball_power += 7
		Main.total_points -= Main.power_cost
		Main.power_cost = Main.power_cost *2
		if Main.ball_power >= Main.ball_power_max:
			power_button.disabled = true
			Main.power_cost = "Max"


func _on_timer_timeout():
	if Main.dirt_current != 0:
		Main.dirt_current -= 10
	if Main.dirt_current < 0:
		Main.dirt_current = 0
	timer.start()
