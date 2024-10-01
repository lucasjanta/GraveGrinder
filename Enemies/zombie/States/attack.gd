extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.animation_player.play("attack")
	enemy.velocity.x = 0

func physics_update(_delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		finished.emit("Walk")
