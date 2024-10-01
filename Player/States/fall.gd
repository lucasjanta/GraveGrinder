extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("fall")
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fall":
		UI.level_results(false)
