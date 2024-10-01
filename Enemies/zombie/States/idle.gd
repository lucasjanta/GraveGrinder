extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.animation_player.play("idle")
	enemy.velocity.x = 0
	
func physics_update(_delta: float) -> void:
	if enemy.on_screen:
		finished.emit("Walk")
