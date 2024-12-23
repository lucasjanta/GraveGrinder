extends Node

#WIN/LOSE SOUNDS
@onready var youwin = $youwin
@onready var youlose = $youlose

#MUSIC
@onready var main_menu = $MainMenu
#LV1 TRACKS
@onready var l1_track1 = $Level1Track1
@onready var l1_track2 = $Level1Track2
@onready var l1_track3 = $Level1Track3
@onready var l1_track4 = $Level1Track4

#UI SOUNDS
@onready var button_hover = $UI_sounds/button_hover
@onready var button_click = $UI_sounds/button_click
@onready var points = $UI_sounds/points
@onready var title = $UI_sounds/title



var selected_track : AudioStreamPlayer

func select_random_level1_music():
	#se ja tiver uma selected_track e estiver tocando, parar
	if selected_track:
		if selected_track.playing:
			selected_track.stop()
	selected_track = get_node("Level1Track" + str(randi_range(1,4)))
	selected_track.play()

func stop_level_music():
	if selected_track:
		if selected_track.playing:
			selected_track.stop()
