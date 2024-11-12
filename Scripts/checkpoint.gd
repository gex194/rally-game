extends Node3D
@onready var trigger_area: Area3D = get_node("checkpoint_trigger_area")
@onready var trigger_mesh: MeshInstance3D = get_node("checkpoint_trigger_mesh")

var checkpoint_enabled = false
var checkpoint_time: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	detect_collision()
	check_checkpoint()

func detect_collision() -> void:
	if (checkpoint_enabled && trigger_area.monitoring && trigger_area.has_overlapping_bodies()):
		SignalBus.checkpoint_add_time.emit(checkpoint_time)
		SignalBus.checkpoint_passed.emit()
		print("Entered trigger")
		checkpoint_time -= 1

func check_checkpoint() -> void:
	if (checkpoint_enabled):
		trigger_mesh.visible = true
		trigger_area.monitoring = true
	else:
		trigger_mesh.visible = false
		trigger_area.monitoring = false
	
