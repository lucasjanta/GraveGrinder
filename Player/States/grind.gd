extends PlayerState
@onready var grind_stamina = $"../../HUD/grind_stamina"

#se a velocidade acabar no grid atualmente, vc fica PRESO
#colocar uma mecânica de controle de equilíbrio e velocidade em cima do grid
func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("grind_arrive")
	player.jump_force = -300

func physics_update(delta: float) -> void:
	if player.balance_stamina < 0:
		player.balance_stamina = 0
	else:
		player.balance_stamina -= 0.3
	#coloquei pro player ir direto pro pulo se apertar pra pular em cima do grind
	if Input.is_action_just_pressed("jump"):
		finished.emit("Ollie")
	if !player.on_grind:
		finished.emit("Stand")
	if Input.is_action_just_pressed("down"):
		player.position.y += 1
		finished.emit("Stand")
	
	if Input.is_action_just_pressed("up"):
		if player.balance >= 30 and player.balance <= 70:
			print("area verde")
			player.balance_stamina += 20
			player.velocity.x += 50
		if player.balance >= 15 and player.balance < 30 or player.balance > 70  and player.balance <= 85:
			print("area amarela")
			player.balance_stamina += 10
			player.velocity.x += 20
		if player.balance >= 0 and player.balance < 15 or player.balance > 85  and player.balance <= 100:
			print("area vermelha")
			player.balance_stamina -= 20
			player.velocity.x -= 20
		if player.balance_stamina > 100:
				player.balance_stamina = 100
	
	grind_stamina.value = player.balance_stamina
	
	if player.balance_stamina < 20:
		finished.emit("Stand")
		player.position.y += 1
	
	if player.on_grind:
		if player.balance_dir > 0:
			player.balance += player.cursor_speed
			if player.balance >= 100:
				player.balance_dir *= -1
		if player.balance_dir < 0:
			player.balance -= player.cursor_speed
			if player.balance <= 0:
				player.balance_dir *= -1


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "grind_arrive":
		player.animation_player.play("grind_balance")
