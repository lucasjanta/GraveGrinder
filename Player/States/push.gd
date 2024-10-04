extends PlayerState


# Called when the node enters the scene tree for the first time.
func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("push")
	if player.velocity.x < player.MAX_SPEED:
		player.velocity.x += player.acceleration
	if player.velocity.x > player.MAX_SPEED:
		player.velocity.x = player.MAX_SPEED
	player.stamina -= 20
	
func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		finished.emit("Ollie")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "push":
		finished.emit("Mount")
