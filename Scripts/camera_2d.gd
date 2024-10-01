extends Camera2D

@export var shake_magnitude: float = 3.0

@onready var phantom_camera_2d = %PhantomCamera2D

var is_shaking : bool = false
var shake_amt : Vector2 = Vector2.ZERO

func _process(delta):
	if Input.is_action_just_pressed("left"): is_shaking = !is_shaking
	
	if !is_shaking: return
	
func shake_camera(duration, intensity, delta):
	is_shaking = true
	if duration > 0:
		duration -= delta
	else:
		is_shaking = false
	if is_shaking:
		shake_amt = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * intensity
		phantom_camera_2d.global_position += shake_amt
