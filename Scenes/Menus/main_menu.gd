extends Control

@onready var startbutton = $VBoxContainer/Start

func _ready():
	var audio_settings = ConfigFileHandler.load_audio_settings()
	AudioServer.set_bus_volume_db(0, linear_to_db(audio_settings.master_volume * 100))
	AudioServer.set_bus_volume_db(1, linear_to_db(audio_settings.music_volume * 100))
	AudioServer.set_bus_volume_db(2, linear_to_db(audio_settings.sfx_volume * 100))
	if !AudioManager.main_menu.playing:
		AudioManager.main_menu.play()
	startbutton.grab_focus()
	
func _process(delta):
	pass
	#if get_viewport().get_mouse_position().x > 160:
		#label.rotation_degrees = lerp_angle(label.rotation_degrees, deg_to_rad(45), 2.0 * delta)
	#elif get_viewport().get_mouse_position().x < 160:
		#label.rotation_degrees = lerp_angle(label.rotation_degrees, deg_to_rad(-45), 2.0 * delta)
	
	
func _on_startgame_pressed():
	AudioManager.button_click.play()
	get_tree().change_scene_to_file("res://Scenes/Menus/level_selection.tscn")
	
func _on_start_mouse_entered():
	AudioManager.button_hover.play()
	
func _on_tutorial_pressed():
	AudioManager.button_click.play()
	
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
	
