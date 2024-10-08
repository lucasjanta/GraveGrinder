extends Control

@onready var level_name = $level_name
@onready var time = $Stats/time
@onready var score = $Stats/score

@onready var zombies_killed_label = $Stats/HBoxContainer/PanelContainer/HBoxContainer/zombies_killed
@onready var tombs_destroyed_label = $Stats/HBoxContainer/PanelContainer2/HBoxContainer/tombs_destroyed
@onready var grind_time_label = $Stats/HBoxContainer/PanelContainer3/HBoxContainer/grind_time
@onready var rank = $Container/grade

var time_handle : float = 0.0
var time_points : int = 0
var zombies_points : int = 0
var tomb_points : int = 0
var final_points : float = 0.0

var time_animation : bool = false
var points_animation : bool = false

#ao ir pra essa tela salva o resultado da run
func _ready():
	#score: ponto do tempo + pontos dos zumbis - tombstones destruidas
	UI.score = get_points()
	UI.check_score(UI.selected_level)
	score.text = "Score: 0"
	time.text = "Time: 0"
	zombies_killed_label.text = str(UI.zombies_killed)
	tombs_destroyed_label.text = str(UI.tombstones_destroyed)
	
func _process(_delta):
	if time_animation:
		time_anim()
		time.text = "Time: " + UI.time_to_string(time_handle)
	if points_animation:
		final_points_anim()
		score.text = "Score: " + str(int(final_points))
	

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

func time_anim() -> void:
	if !time_animation:
		time_animation = !time_animation
		print(time_handle)
		
	if time_handle < UI.run_time:
		time_handle += 0.21
	else:
		time_handle = UI.run_time
		time_animation = false
		
func final_points_anim() -> void:
	if !points_animation:
		points_animation = !points_animation
	if final_points < UI.score:
		final_points += 81
	else:
		final_points = UI.score
		points_animation = false
	
#func zombies_killed_anim(delta) -> void:
	#if zombies_points < UI.speedrun_time:
		#zombies_points += delta * 1
	#else:
		#zombies_points = UI.speedrun_time
		#time_animation = false
		#
#func tombs_destroyed_anim(delta) -> void:
	#if tomb_points < UI.speedrun_time:
		#tomb_points += delta * 1
	#else:
		#tomb_points = UI.speedrun_time
		#time_animation = false
		
func get_points() -> int:
	time_points = int(100000 / UI.run_time)
	zombies_points = UI.zombies_killed * 100
	tomb_points = UI.tombstones_destroyed * -50
	var points = time_points + zombies_points + tomb_points
	return points
