extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.velocity.x = 0
	enemy.animation_player.play("pushed")
