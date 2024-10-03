extends Node

var player : Player
var selected_level : int
#var finished_level : bool

var score : float = 0
var speedrun_time : String
var zombies_killed : int
var tombstones_destroyed : int
var time_in_grind


var highscore : float
var recordtime : String
var zombies_killed_record : int
var tombstones_destroyed_record : int
var time_in_grind_record


func save_file(level):
	var file = FileAccess.open("user://level" + str(level) + ".dat", FileAccess.WRITE)
	var level_data = create_level_data()
	file.store_var(level_data)
	
func load_file(level):
	var file = FileAccess.open("user://level" + str(level) + ".dat", FileAccess.READ)
	if FileAccess.file_exists("user://level" + str(level) + ".dat"):
		print("o arquivo existe")
		var loaded_level_data = file.get_var()
		highscore = loaded_level_data.HIGHSCORE
		recordtime = loaded_level_data.RECORDTIME
		return true
	else:
		print("o arquivo n existe")
		return false
		
func create_level_data():
	
	var level_dict = {
		"HIGHSCORE" : highscore,
		"RECORDTIME" : recordtime,
		"ZOMBIESKILLED" : zombies_killed,
		"TOMBSTONESDESTROYED" : tombstones_destroyed,
		"TIMEINGRIND" : time_in_grind
	}
	return level_dict

func check_score(level):
	var file = FileAccess.open("user://level" + str(level) + ".dat", FileAccess.READ)
	if FileAccess.file_exists("user://level" + str(level) + ".dat"):
		var loaded_level_data = file.get_var()
		if score > loaded_level_data.HIGHSCORE:
			highscore = score
			recordtime = speedrun_time
			zombies_killed_record = zombies_killed
			tombstones_destroyed_record = tombstones_destroyed
			time_in_grind_record = time_in_grind
			save_file(level)
			
func start_level(level):
	if level == 1:
		get_tree().change_scene_to_file("res://Scenes/Levels/test_room.tscn")
	if level == 2:
		print("sem level 2")
	if level == 3:
		print("sem level 3")
	score = 0

func level_results(finished_level : bool):
	if finished_level:
		get_tree().change_scene_to_file("res://Scenes/Menus/level_results.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Menus/game_over.tscn")
