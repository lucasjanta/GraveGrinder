extends EnemyState
#@onready var attack_cd = $attack_cd

func enter(previous_state_path: String, data := {}) -> void:
	enemy.animation_player.play("walk")
	enemy.velocity.x = -50
	#attack_cd.wait_time = randf_range(0.1,1.0)
	#attack_cd.start()

func physics_update(_delta: float) -> void:
	if enemy.player.velocity.x <= 50 and enemy.position.distance_to(enemy.player.position) < 50:
		enemy.player.velocity.x = 0
		finished.emit("Attack")
	if enemy.pushed:
		finished.emit("Pushed")
