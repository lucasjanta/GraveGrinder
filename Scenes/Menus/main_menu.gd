extends Control

@onready var label = $Label

func _ready():
	AudioManager.main_menu.play()
	
func _exit_tree():
	AudioManager.main_menu.stop()

func _process(delta):
	if get_viewport().get_mouse_position().x > 160:
		label.rotation_degrees = lerp_angle(label.rotation_degrees, deg_to_rad(45), 2.0 * delta)
	elif get_viewport().get_mouse_position().x < 160:
		label.rotation_degrees = lerp_angle(label.rotation_degrees, deg_to_rad(-45), 2.0 * delta)
	
	
func _on_startgame_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/level_selection.tscn")

func _on_tutorial_pressed():
	pass # Replace with function body.

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/settings.tscn")

func _on_quit_pressed():
	get_tree().quit()
