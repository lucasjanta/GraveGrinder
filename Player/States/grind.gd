extends PlayerState

#se a velocidade acabar no grid atualmente, vc fica PRESO
#colocar uma mecânica de controle de equilíbrio e velocidade em cima do grid
func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("grind_arrive")
	player.jump_force = -300

func physics_update(_delta: float) -> void:
	#coloquei pro player ir direto pro pulo se apertar pra pular em cima do grind
	if Input.is_action_just_pressed("jump"):
		finished.emit("Ollie")
	if !player.on_grind:
		finished.emit("Stand")
	if Input.is_action_just_pressed("down"):
		player.position.y += 1
		finished.emit("Stand")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "grind_arrive":
		player.animation_player.play("grind_balance")
