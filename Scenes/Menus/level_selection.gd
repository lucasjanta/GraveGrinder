extends Control

@onready var level_name = $level_name
@onready var level_texture = $level_texture
@onready var best_score = $best_score
@onready var best_time = $best_time
@onready var play = $play

@export var level1_img : CompressedTexture2D
@export var level2_img : CompressedTexture2D
@export var level3_img : CompressedTexture2D


func _ready():
	UI.selected_level = 1
	load_level_data()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		AudioManager.button_click.play()
		get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
	
func load_level_data():
	if !UI.load_file(UI.selected_level):
		if UI.selected_level == 1:
			play.disabled = false
			best_score.text = "Score: None"
			best_time.text = "Best time: None"
			return
		play.disabled = true
		best_score.text = "Score: None"
		best_time.text = "Best time: None"
	else:
		play.disabled = false
		best_time.text = "Best time: " + UI.time_to_string(UI.recordtime)
		best_score.text = "Score: " + str(int(UI.highscore))
		

func _on_previous_pressed():
	AudioManager.button_click.play()
	if UI.selected_level > 1:
		UI.selected_level -= 1
	else:
		UI.selected_level = 3
	load_level_data()

func _on_next_pressed():
	AudioManager.button_click.play()
	if UI.selected_level < 3:
		UI.selected_level += 1
	else:
		UI.selected_level = 1
	load_level_data()

func _on_play_pressed():
	AudioManager.button_click.play()
	UI.start_level(UI.selected_level)
	AudioManager.main_menu.stop()

func _on_back_pressed():
	AudioManager.button_click.play()
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")

func _on_infinite_pressed():
	AudioManager.button_click.play()
	if UI.selected_level == 1:
		print("nivel 1 no modo infinito")
	if UI.selected_level == 2:
		print("nivel 2 no modo infinito")
	if UI.selected_level == 3:
		print("nivel 3 no modo infinito")

func _on_previous_mouse_entered():
	AudioManager.button_hover.play()

func _on_next_mouse_entered():
	AudioManager.button_hover.play()

func _on_play_mouse_entered():
	AudioManager.button_hover.play()

func _on_back_mouse_entered():
	AudioManager.button_hover.play()

func _on_infinite_mouse_entered():
	AudioManager.button_hover.play()
