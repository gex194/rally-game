extends Node3D

var direction = Vector3.FORWARD
@export_range (1,10,0.1) var smooth_speed = 1.5

func _physics_process(delta: float) -> void:
	var current_velocity = get_parent().get_linear_velocity()
	current_velocity.y = 0
	if (current_velocity.length_squared() > 1):
		direction = lerp(direction, -current_velocity.normalized(), smooth_speed * delta)
	global_transform.basis = get_rotation_from_direction(direction)
	
func get_rotation_from_direction(look_direction: Vector3) -> Basis:
	look_direction = look_direction.normalized()
	var x_axis = look_direction.cross(Vector3.UP)
	return Basis(x_axis,Vector3.UP, -look_direction)
