extends Control

@onready var video_container = $VideoContainer
@onready var audio_container = $AudioContainer
@onready var misc_container = $MiscContainer


func _ready():
	video_container.visible = true
	audio_container.visible = false
	misc_container.visible = false


func _on_video_pressed():
	video_container.visible = true
	audio_container.visible = false
	misc_container.visible = false


func _on_audio_pressed():
	audio_container.visible = true
	video_container.visible = false
	misc_container.visible = false


func _on_misc_pressed():
	misc_container.visible = true
	audio_container.visible = false
	video_container.visible = false

func _on_return_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")


func _on_reset_score_pressed():
	UI.reset_data(1)
