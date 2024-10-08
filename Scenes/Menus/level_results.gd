extends Control

@onready var level_name = $Stats/level_name
@onready var score = $Stats/score
@onready var time = $Stats/time
@onready var zombies_killed_label = $Stats/HBoxContainer/PanelContainer/HBoxContainer/zombies_killed
@onready var tombs_destroyed_label = $Stats/HBoxContainer/PanelContainer2/HBoxContainer/tombs_destroyed
@onready var grind_time_label = $Stats/HBoxContainer/PanelContainer3/HBoxContainer/grind_time

var time_points : int
var zombies_points : int
var tomb_points : int

#ao ir pra essa tela salva o resultado da run
func _ready():
	#score: ponto do tempo + pontos dos zumbis - tombstones destruidas
	UI.score = get_points()
	UI.check_score(UI.selected_level)
	score.text = "Score: " + str(int(UI.score))
	time.text = "Time: " + UI.time_to_string(UI.speedrun_time)
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

func randomize_time() -> float:
	var random_time = randf_range(0.0, 5999.99)
	return random_time
	
func get_points() -> int:
	time_points = int(100000 / UI.speedrun_time)
	zombies_points = UI.zombies_killed * 100
	tomb_points = UI.tombstones_destroyed * -50
	var points = time_points + zombies_points + tomb_points
	return points
