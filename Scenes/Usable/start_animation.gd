extends Node2D
@onready var animation_player = $AnimationPlayer
var ready_to_go = false

func _ready():
	get_tree().paused = true
	animation_player.play("start_anim")
	#resolve bug da posição da animação
	global_position = Vector2(145.5, 0)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "start_anim":
		get_tree().paused = false
		ready_to_go = true
		if UI.selected_level == 1:
			AudioManager.select_random_level1_music()
