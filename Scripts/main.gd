extends Node3D

@onready var checkpoints = get_node("checkpoints").get_children()
@onready var car = get_node("Car")
var checkpoint_index = 0;
var current_checkpoint = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.checkpoint_passed.connect(_on_checkpoint_pass)
	checkpoints[checkpoint_index].checkpoint_enabled = true
	current_checkpoint = checkpoints[checkpoint_index]

func _on_checkpoint_pass() -> void:
	if (checkpoint_index < checkpoints.size() - 1):
		checkpoint_index += 1
		if (checkpoints[checkpoint_index - 1] != null):
			checkpoints[checkpoint_index - 1].checkpoint_enabled = false
		checkpoints[checkpoint_index].checkpoint_enabled = true
		current_checkpoint = checkpoints[checkpoint_index]
	elif (checkpoint_index == checkpoints.size() - 1):
		checkpoint_index = 0
		checkpoints[checkpoint_index - 1].checkpoint_enabled = false
		checkpoints[checkpoint_index].checkpoint_enabled = true
		current_checkpoint = checkpoints[checkpoint_index]
		
