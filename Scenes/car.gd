extends VehicleBody3D

var max_rpm = 700
var max_torque = 300
@onready var left_wheel_smoke: GPUParticles3D = get_node("left_wheel_smoke")
@onready var right_wheel_smoke: GPUParticles3D = get_node("right_wheel_smoke")

@onready var rear_left_wheel: VehicleWheel3D = get_node("rear_left_wheel")
@onready var rear_right_wheel: VehicleWheel3D = get_node("rear_right_wheel")

@onready var left_light: SpotLight3D = get_node("left_light")
@onready var right_light: SpotLight3D = get_node("right_light")

@onready var engine_sound: AudioStreamPlayer3D = get_node("engine_sound")
@export_range (1,15,0.1) var steering_speed = 3

func _physics_process(delta: float) -> void:
	steering = lerp(steering, Input.get_axis("Right","Left") * 0.4, steering_speed * delta)
	var acceleration = Input.get_axis("Back", "Forward")
	var rpm = rear_left_wheel.get_rpm()
	rear_left_wheel.engine_force = acceleration * max_torque * (1 - abs(rpm) / max_rpm)
	rpm = rear_right_wheel.get_rpm()
	rear_right_wheel.engine_force = acceleration * max_torque * (1 - abs(rpm) / max_rpm)

	handle_reset_position()
	handle_emitters(acceleration, rpm)
	handle_engine_sound(rpm)
	handle_lights()

func handle_emitters(acceleration, rpm) -> void:
	if (acceleration && rpm < 150 && rear_left_wheel.is_in_contact() && rear_right_wheel.is_in_contact()):
		left_wheel_smoke.emitting = true;
		right_wheel_smoke.emitting = true;
	else:
		left_wheel_smoke.emitting = false;
		right_wheel_smoke.emitting = false;

func handle_lights() -> void:
	if (Input.is_action_just_pressed("Lights")):
		left_light.visible = !left_light.visible
		right_light.visible = !right_light.visible

func handle_engine_sound(rpm) -> void:
	if (abs(rpm) > 0.0):
		engine_sound.pitch_scale = abs(rpm) / 200;

func handle_reset_position() -> void:
	if (Input.is_action_just_pressed("Reset")):
		self.position = Vector3(0,2,0)
		self.rotation = Vector3(0,0,0)
