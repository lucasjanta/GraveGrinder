extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("mounted")

func physics_update(_delta: float) -> void:
	#Ir para a animação de morte
	if player.game_over:
		finished.emit("Fall")
	#Remar pros lados
	if Input.is_action_just_pressed("right") and player.velocity.x >= 0 and player.is_on_floor():
		if player.stamina > 20:
			finished.emit("Push")
		else:
			player.show_status("no stamina")
	#if Input.is_action_just_pressed("left") and player.velocity.x <= 0 and player.is_on_floor():
		#player.direction = -1
		#finished.emit("Push")
	#Frear aumentando a fricção
	if Input.is_action_pressed("down") and player.velocity.x > 0 and player.is_on_floor():
		player.friction = 350
	if Input.is_action_just_released("down"):
		player.friction = 10
	#Pulo
	if Input.is_action_pressed("jump") and player.is_on_floor():
		finished.emit("Ollie")
