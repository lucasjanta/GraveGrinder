extends Node2D

@onready var pause_menu = $PauseMenu

func pause():
	print("pause funcionando")
	get_tree().paused = true
	pause_menu.show()

func unpause():
	print("unpause funcionando")
	get_tree().paused = false
	pause_menu.hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause()
