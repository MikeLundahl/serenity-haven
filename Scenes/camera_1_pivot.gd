extends Node3D


@onready var cam_pos = $"."
@onready var cam_pivot = $Camera_1
@onready var clamp_pos1: Vector3 = $"../../SwimmingPool/Clamp_cam1".get_position()
@onready var clamp_cam1: Vector3 = $"../../SwimmingPool/Clamp_cam1".get_size()


var SENSITIVITY: = 0.01

var velocity: = 1

var boost: = 3

var mouse_wheel_up: = false
var mouse_wheel_down: = false

var direction: = Vector3()



func _process(delta: float) -> void :
	direction = Vector3(
		float(Input.is_physical_key_pressed(KEY_D) or Input.is_physical_key_pressed(KEY_RIGHT)) - float(Input.is_physical_key_pressed(KEY_A)
		or Input.is_physical_key_pressed(KEY_LEFT)), 
		float(Input.is_physical_key_pressed(KEY_E) or mouse_wheel_up) - float(Input.is_physical_key_pressed(KEY_Q) or mouse_wheel_down), 
		float(Input.is_physical_key_pressed(KEY_S) or Input.is_physical_key_pressed(KEY_DOWN)) - float(Input.is_physical_key_pressed(KEY_W)
		or Input.is_physical_key_pressed(KEY_UP))
		).normalized()

	if Input.is_physical_key_pressed(KEY_SHIFT):
		translate(direction * velocity * delta * boost)
	else: translate(direction * velocity * delta)


	if cam_pos.global_position.y < 0.1:
		cam_pos.global_position.y = 0.1



	if Input.is_physical_key_pressed(KEY_C):
		cam_pivot.rotation.z -= 0.1 * SENSITIVITY
	if Input.is_physical_key_pressed(KEY_Z):
		cam_pivot.rotation.z += 0.1 * SENSITIVITY
	if Input.is_physical_key_pressed(KEY_X):
		cam_pivot.rotation.z = 0.0

func _unhandled_input(event: InputEvent) -> void :

	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		cam_pos.rotation.x -= event.relative.y * SENSITIVITY
		cam_pos.rotation.y -= event.relative.x * SENSITIVITY


	elif event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				if event.is_pressed():
					mouse_wheel_up = true
					await get_tree().create_timer(0.2).timeout
					mouse_wheel_up = false
			MOUSE_BUTTON_WHEEL_DOWN:
				if event.is_pressed():
					mouse_wheel_down = true
					await get_tree().create_timer(0.2).timeout
					mouse_wheel_down = false


	cam_pos.global_position.x = clamp(cam_pos.position.x, clamp_pos1.x - (clamp_cam1.x / 2), clamp_pos1.x + (clamp_cam1.x / 2))
	cam_pos.global_position.y = clamp(cam_pos.position.y, clamp_pos1.y - (clamp_cam1.y / 2), clamp_pos1.y + (clamp_cam1.y / 2))
	cam_pos.global_position.z = clamp(cam_pos.position.z, clamp_pos1.z - (clamp_cam1.z / 2), clamp_pos1.z + (clamp_cam1.z / 2))
