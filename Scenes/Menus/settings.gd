extends Control

@onready var video_container = $VideoContainer
@onready var audio_container = $AudioContainer
@onready var input_settings_container = $InputSettings
@onready var misc_container = $MiscContainer

#Sound slider vars
@onready var master_slider = $AudioContainer/Master/master_slider
@onready var music_slider = $AudioContainer/Music/music_slider
@onready var sfx_slider = $"AudioContainer/Sound Effects/SFX_slider"

func _ready():
	#set_sliders_values()
	#SETA OS SLIDERS DE SOM
	var audio_settings = ConfigFileHandler.load_audio_settings()
	master_slider.value = min(audio_settings.master_volume, 1.0) * 100
	music_slider.value = min(audio_settings.music_volume, 1.0) * 100
	sfx_slider.value = min(audio_settings.sfx_volume, 1.0) * 100
	
	video_container.visible = true
	audio_container.visible = false
	misc_container.visible = false
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		AudioManager.button_click.play()
		get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")

func _on_video_pressed():
	video_container.visible = true
	audio_container.visible = false
	input_settings_container.visible = false
	misc_container.visible = false
	AudioManager.button_click.play()

func _on_audio_pressed():
	audio_container.visible = true
	video_container.visible = false
	input_settings_container.visible = false
	misc_container.visible = false
	AudioManager.button_click.play()
	
func _on_controls_pressed():
	input_settings_container.visible = true
	audio_container.visible = false
	video_container.visible = false
	misc_container.visible = false
	AudioManager.button_click.play()

func _on_misc_pressed():
	misc_container.visible = true
	audio_container.visible = false
	video_container.visible = false
	input_settings_container.visible = false
	AudioManager.button_click.play()

func _on_return_pressed():
	AudioManager.button_click.play()
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
	
func _on_reset_score_pressed():
	UI.reset_data(1)

func _on_video_mouse_entered():
	AudioManager.button_hover.play()

func _on_audio_mouse_entered():
	AudioManager.button_hover.play()
	
func _on_controls_mouse_entered():
	AudioManager.button_hover.play()
	
func _on_misc_mouse_entered():
	AudioManager.button_hover.play()

func _on_return_mouse_entered():
	AudioManager.button_hover.play()

#AUDIO CONFIGS ⬇

#func set_sliders_values() -> void:
	#master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	#music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	#sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear_to_db(value))

func _on_master_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_settings("master_volume", master_slider.value / 100)

func _on_music_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_settings("music_volume", music_slider.value / 100)

func _on_sfx_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_settings("sfx_volume", sfx_slider.value / 100)
