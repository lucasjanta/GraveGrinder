extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("precisamos de uma animação pro game over")
	UI.level_results(false)
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fall":
		UI.level_results(false)
