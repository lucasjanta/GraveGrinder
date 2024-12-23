extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.jump_force = -250
	player.animation_player.play("stand")

func physics_update(_delta: float) -> void:
	if player.balance_stamina < 100:
		player.balance_stamina += 1
	else:
		player.balance_stamina = 100
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
	#Frear aumentando a fricção BUGADO (adicionar estado)
	if Input.is_action_pressed("down") and player.velocity.x > 0 and player.is_on_floor():
		player.friction = 350
	if Input.is_action_just_released("down"):
		player.friction = 10
	#Pulo
	if Input.is_action_pressed("jump") and player.is_on_floor():
		finished.emit("TkPrepare")
