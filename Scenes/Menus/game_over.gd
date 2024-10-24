extends Control

@onready var animation_player = $AnimationPlayer
@onready var best_score = $"best score"

func _ready():
	AudioManager.stop_level_music()
	AudioManager.youlose.play()
	best_score.text = "Highscore: " + str(int(UI.highscore))
	#animation_player.play("show_transition")

func _on_retry_pressed():
	AudioManager.button_click.play()
	UI.start_level(UI.selected_level)

func _on_main_menu_pressed():
	AudioManager.button_click.play()
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")

func _on_retry_mouse_entered():
	AudioManager.button_hover.play()

func _on_main_menu_mouse_entered():
	AudioManager.button_hover.play()
