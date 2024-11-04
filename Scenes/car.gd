extends VehicleBody3D

var max_rpm = 500
var max_torque = 200
@export_range (1,15,0.1) var steering_speed = 3

func _physics_process(delta: float) -> void:
	steering = lerp(steering, Input.get_axis("Right","Left") * 0.4, steering_speed * delta)
	var acceleration = Input.get_axis("Back", "Forward")
	var rpm = $rear_left_wheel.get_rpm()
	$rear_left_wheel.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	rpm = $rear_right_wheel.get_rpm()
	$rear_right_wheel.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
