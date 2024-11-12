extends Label

@onready var timer : Timer = get_node("Timer")
var time = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	SignalBus.checkpoint_add_time.connect(_on_checkpoint_passed)
	timer.start()
	self.text = str(time)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_checkpoint_passed(add_time_value: int) -> void:
	time += add_time_value

func _on_timer_timeout():
	if (time > 0):
		time -= 1
		self.text = str(time);
	else:
		self.text = "Time's Up!"
		timer.stop()
