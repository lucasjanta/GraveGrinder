extends PlayerState

var trick_finished : bool

func enter(previous_state_path: String, data := {}) -> void:
	trick_finished = false
	player.animation_player.play("ollie_up")
	player.velocity.y = player.jump_force

func physics_update(_delta: float) -> void:
	if player.on_grind:
		finished.emit("Grind")
	if player.velocity.y > 0:
		player.animation_player.play("ollie_down")
	if player.is_on_floor() and trick_finished:
		finished.emit("Stand")
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "ollie_down":
		trick_finished = true
