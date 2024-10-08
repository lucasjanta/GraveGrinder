extends Node

var player : Player
var selected_level : int
#var finished_level : bool

var score : float = 0
var run_time : float
var zombies_killed : int
var tombstones_destroyed : int
var time_in_grind

var highscore : float
var recordtime : float
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
		print("o arquivo não existe")
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

func reset_data(level):
	# 0 = tudo 1 = nivel 1...
	#if level == 0:
		#var file_path = "res://pasta_seu_arquivo/arquivo.txt"
	if FileAccess.file_exists("user://level" + str(level) + ".dat"):
		var err = DirAccess.remove_absolute("user://level" + str(level) + ".dat")
		if err == OK:
			print("Arquivo apagado com sucesso.")
		else:
			print("Erro ao tentar apagar o arquivo.")
	else:
		print("Arquivo não encontrado.")

func check_score(level):
	var file = FileAccess.open("user://level" + str(level) + ".dat", FileAccess.READ)
	if FileAccess.file_exists("user://level" + str(level) + ".dat"):
		var loaded_level_data = file.get_var()
		if score > loaded_level_data.HIGHSCORE:
			highscore = score
			recordtime = run_time
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

func time_to_string(time) -> String:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var minute = time / 60
	#formatting time to look like this: 00:00:000
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [minute, sec, msec]
	return actual_string
