extends Node3D
@export var main: Node3D
@onready var checkpoint = main.get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (checkpoint.current_checkpoint):
		var global_pos = global_transform.origin
		var player_pos = checkpoint.current_checkpoint.global_transform.origin
		var rotation_speed = 0.5
		var wtransform = global_transform.looking_at(Vector3(player_pos.x,global_pos.y,player_pos.z),Vector3(0,1,0))
		var wrotation = Quaternion(global_transform.basis).slerp(Quaternion(wtransform.basis), rotation_speed)
		global_transform = Transform3D(Basis(wrotation), global_transform.origin)
