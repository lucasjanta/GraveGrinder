extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.animation_player.play("death")
	UI.zombies_killed += 1

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
