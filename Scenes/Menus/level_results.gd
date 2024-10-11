extends Control

@onready var level_name = $level_name
@onready var time = $Stats/time
@onready var score = $Stats/score

@onready var zombies_killed_label = $Stats/HBoxContainer/PanelContainer/HBoxContainer/zombies_killed
@onready var tombs_destroyed_label = $Stats/HBoxContainer/PanelContainer2/HBoxContainer/tombs_destroyed
@onready var grind_time_label = $Stats/HBoxContainer/PanelContainer3/HBoxContainer/grind_time
@onready var rank = $rank
@onready var rank_animation_player = $RankAnimation


var time_handle : float = 0.0
var time_points : int = 0
var zombie_handle : float = 0
var zombie_points : int = 0
var tomb_handle : float = 0
var tomb_points : int = 0
var final_points : float = 0.0

var time_animation : bool = false
var time_points_animation : bool = false
var zombie_animation : bool = false
var zombie_points_animation : bool = false
var tomb_animation : bool = false
var tomb_points_animation : bool = false
var rank_animation : bool = false

#ao ir pra essa tela salva o resultado da run
func _ready():
	#score: ponto do tempo + pontos dos zumbis - tombstones destruidas
	UI.score = get_points()
	UI.check_score(UI.selected_level)
	score.text = "Score: 0"
	time.text = "Time: 0"
	zombies_killed_label.text = "0"
	tombs_destroyed_label.text = "0"
	
func _process(_delta):
	if time_animation:
		time_anim()
		time.text = "Time: " + UI.time_to_string(time_handle)
	if time_points_animation:
		time_points_anim()
		score.text = "Score: " + str(int(final_points))
	if zombie_animation:
		zombies_killed_anim()
		zombies_killed_label.text = str(int(zombie_handle))
	if zombie_points_animation:
		zombie_points_anim()
		score.text = "Score: " + str(int(final_points))
	if tomb_animation:
		tombs_destroyed_anim()
		tombs_destroyed_label.text = str(int(tomb_handle))
	if tomb_points_animation:
		tomb_points_anim()
		score.text = "Score: " + str(int(final_points))
	if rank_animation:
		rank_anim()

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
		time_points_animation = true
		
func time_points_anim() -> void:
	if final_points < time_points:
		final_points += 51
	else:
		final_points = time_points
		time_points_animation = false
		zombie_animation = true
		
func zombies_killed_anim() -> void:
	if zombie_handle < float(UI.zombies_killed):
		zombie_handle += 0.1
	else:
		zombie_handle = float(UI.zombies_killed)
		zombie_animation = false
		tomb_animation = true

func zombie_points_anim() -> void:
	if final_points < time_points + zombie_points:
		final_points += 0.1
	else:
		final_points = time_points + zombie_points
		zombie_points_animation = false
		tomb_animation = true
		
func tombs_destroyed_anim() -> void:
	if tomb_handle > float(UI.tombstones_destroyed):
		tomb_handle -= 0.1
	else:
		tomb_handle = float(UI.tombstones_destroyed)
		tomb_animation = false
		tomb_points_animation = true
		
func tomb_points_anim() -> void:
	if final_points > UI.score:
		final_points -= 0.81
	else:
		final_points = UI.score
		tomb_points_animation = false
		rank_animation = true
		
func rank_anim() -> void:
	if UI.score >= 10000:
		rank.text = "S"
	elif UI.score >= 9000:
		rank.text = "A"
	elif UI.score >= 8000:
		rank.text = "B"
	elif UI.score >= 7000:
		rank.text = "C"
	else:
		rank.text = "D"
	rank_animation = false
	rank_animation_player.play("show_rank")
		
func get_points() -> int:
	time_points = int(100000 / UI.run_time)
	zombie_points = UI.zombies_killed * 100
	tomb_points = UI.tombstones_destroyed * 50
	var points = time_points + zombie_points + tomb_points
	return points
