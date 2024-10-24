extends Control

@onready var label = $Label

func _ready():
	if !AudioManager.main_menu.playing:
		AudioManager.main_menu.play()

func _process(delta):
	if get_viewport().get_mouse_position().x > 160:
		label.rotation_degrees = lerp_angle(label.rotation_degrees, deg_to_rad(45), 2.0 * delta)
	elif get_viewport().get_mouse_position().x < 160:
		label.rotation_degrees = lerp_angle(label.rotation_degrees, deg_to_rad(-45), 2.0 * delta)
	
	
func _on_startgame_pressed():
	AudioManager.button_click.play()
	get_tree().change_scene_to_file("res://Scenes/Menus/level_selection.tscn")
	
func _on_start_mouse_entered():
	AudioManager.button_hover.play()
	
func _on_tutorial_pressed():
	AudioManager.button_click.play()
	pass # Replace with function body.
	
func _on_tutorial_mouse_entered():
	AudioManager.button_hover.play()

func _on_settings_pressed():
	AudioManager.button_click.play()
	get_tree().change_scene_to_file("res://Scenes/Menus/settings.tscn")
	
func _on_options_mouse_entered():
	AudioManager.button_hover.play()
	
func _on_quit_pressed():
	AudioManager.button_click.play()
	get_tree().quit()

func _on_quit_mouse_entered():
	AudioManager.button_hover.play()
	
