extends Node

var selected_camera : Camera2D
var shake_dur : float
var shake_intensity : float
var is_cam_shaking : bool = false
var shake_amt : Vector2 = Vector2.ZERO

func shake_camera(camera, duration, intensity):
	selected_camera = camera
	shake_dur = duration
	shake_intensity = intensity
	is_cam_shaking = true

func _process(delta):
	if UI.player != null:
		if is_cam_shaking:
			if shake_dur > 0:
				shake_dur -= delta
				shake_amt = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake_intensity
				selected_camera.global_position += shake_amt
			else:
				is_cam_shaking = false
