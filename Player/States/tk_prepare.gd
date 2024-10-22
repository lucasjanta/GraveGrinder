extends PlayerState

var change_back_to_mount : bool = false

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("trick_prep")
	
func physics_update(_delta: float) -> void:
	if Input.is_action_just_released("jump") and player.is_on_floor():
		finished.emit("Ollie")
	if !player.is_on_floor() and player.animation_player.current_animation == "trick_prep":
		finished.emit("Stand")
	if !player.is_on_floor() and Input.is_action_just_released("jump"):
		finished.emit("Stand")
	#if Input.is_action_just_released("jump") and player.animation_player.current_animation != "jump" and player.is_on_floor():
		#player.animation_player.play("jump")
		#player.velocity.y = player.jump_force
	#if Input.is_action_just_released("jump") and player.animation_player.current_animation != "jump" and !player.is_on_floor():
		#finished.emit("Stand")
	#if player.is_on_floor() and change_back_to_mount:
		#change_back_to_mount = false
		#finished.emit("Stand")
	#if Input.is_action_just_pressed("right") and player.is_on_floor():
		#finished.emit("Push")
