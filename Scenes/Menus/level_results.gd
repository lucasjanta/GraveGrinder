extends Control

@onready var level_name = $Stats/level_name
@onready var score = $Stats/score
@onready var time = $Stats/time
@onready var zombies_killed_label = $Stats/HBoxContainer/PanelContainer/HBoxContainer/zombies_killed
@onready var tombs_destroyed_label = $Stats/HBoxContainer/PanelContainer2/HBoxContainer/tombs_destroyed
@onready var grind_time_label = $Stats/HBoxContainer/PanelContainer3/HBoxContainer/grind_time

#ao ir pra essa tela salva o resultado da run
func _ready():
	UI.check_score(UI.selected_level)
	score.text = "Score: " + str(int(UI.score))
	time.text = "Time: " + str(UI.speedrun_time)
	zombies_killed_label.text = str(UI.zombies_killed)
	tombs_destroyed_label.text = str(UI.tombstones_destroyed)

func _on_retry_pressed():
	UI.start_level(UI.selected_level)

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")

func _on_next_level_pressed():
	if UI.selected_level < 3:
		UI.selected_level += 1
	else:
		print("configurar tela de game zerado")
		return
	UI.start_level(UI.selected_level)
