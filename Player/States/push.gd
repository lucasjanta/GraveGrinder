extends PlayerState


# Called when the node enters the scene tree for the first time.
func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("push")
	player.jump_force = -250
	if player.velocity.x < player.MAX_SPEED:
		player.velocity.x += player.acceleration
	if player.velocity.x > player.MAX_SPEED:
		player.velocity.x = player.MAX_SPEED
	player.stamina -= 20
	
func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		finished.emit("TkPrepare") #Adicionar esse estado


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "push":
		finished.emit("Stand")
