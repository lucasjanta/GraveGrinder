extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.animation_player.play("pushed")
