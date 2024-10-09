extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("grind_arrive")

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		finished.emit("TkPrepare")
	if !player.on_grind:
		finished.emit("Stand")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "grind_arrive":
		player.animation_player.play("grind_balance")
