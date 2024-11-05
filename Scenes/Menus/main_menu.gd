extends Control

@onready var startbutton = $VBoxContainer/Start
@onready var tutorialbutton = $VBoxContainer/Tutorial
@onready var optionsbutton = $VBoxContainer/Options
@onready var quitbutton = $VBoxContainer/Quit
@onready var color_rect = $ColorRect

var title_arrived : bool

func _ready():
	change_bg_color(0.3,0.5,0.7)
	#code to change shader parameter
	#color_rect.material.set_shader_parameter("red", 0.5)
	AudioManager.main_menu.stop()
	title_arrived = false
	#change audio settings to saved settings from the start
	var audio_settings = ConfigFileHandler.load_audio_settings()
	AudioServer.set_bus_volume_db(0, linear_to_db(audio_settings.master_volume * 100))
	AudioServer.set_bus_volume_db(1, linear_to_db(audio_settings.music_volume * 100))
	AudioServer.set_bus_volume_db(2, linear_to_db(audio_settings.sfx_volume * 100))
	#change binding settings to saved settings from the start
	var keybindings = ConfigFileHandler.load_keybindings()
	for action in keybindings.keys():
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, keybindings[action])
	startbutton.grab_focus()
	
func _process(delta):
	if title_arrived:
		if !AudioManager.main_menu.playing:
			AudioManager.main_menu.play()
	#if get_viewport().get_mouse_position().x > 160:
		#label.rotation_degrees = lerp_angle(label.rotation_degrees, deg_to_rad(45), 2.0 * delta)
	#elif get_viewport().get_mouse_position().x < 160:
		#label.rotation_degrees = lerp_angle(label.rotation_degrees, deg_to_rad(-45), 2.0 * delta)
	
	
func _on_startgame_pressed():
	AudioManager.button_click.play()
	get_tree().change_scene_to_file("res://Scenes/Menus/level_selection.tscn")
	
func _on_start_mouse_entered():
	AudioManager.button_hover.play()
	startbutton.grab_focus()
	
func _on_tutorial_pressed():
	AudioManager.button_click.play()
	
func _on_tutorial_mouse_entered():
	AudioManager.button_hover.play()
	tutorialbutton.grab_focus()

func _on_settings_pressed():
	AudioManager.button_click.play()
	get_tree().change_scene_to_file("res://Scenes/Menus/settings.tscn")
	
func _on_options_mouse_entered():
	AudioManager.button_hover.play()
	optionsbutton.grab_focus()
	
func _on_quit_pressed():
	AudioManager.button_click.play()
	get_tree().quit()

func _on_quit_mouse_entered():
	AudioManager.button_hover.play()
	quitbutton.grab_focus()

func _on_start_focus_entered():
	AudioManager.button_hover.play()

func _on_tutorial_focus_entered():
	AudioManager.button_hover.play()

func _on_options_focus_entered():
	AudioManager.button_hover.play()

func _on_quit_focus_entered():
	AudioManager.button_hover.play()

func play_title_sound():
	AudioManager.title.play()
	title_arrived = true

func change_bg_color(r : float, g : float, b : float):
	color_rect.material.set_shader_parameter("red", r)
	color_rect.material.set_shader_parameter("green", g)
	color_rect.material.set_shader_parameter("blue", b)
