extends PlayerState

var change_back_to_mount : bool = false

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("jump_prep")
	player.jump_force = -250

func physics_update(_delta: float) -> void:
	if !player.is_on_floor() and player.animation_player.current_animation == "jump_prep":
		finished.emit("Mount")
	if Input.is_action_just_released("jump") and player.animation_player.current_animation != "jump" and player.is_on_floor():
		player.animation_player.play("jump")
		player.velocity.y = player.jump_force
	if Input.is_action_just_released("jump") and player.animation_player.current_animation != "jump" and !player.is_on_floor():
		finished.emit("Mount")
	if player.is_on_floor() and change_back_to_mount:
		change_back_to_mount = false
		finished.emit("Mount")
	if Input.is_action_just_pressed("right") and player.is_on_floor():
		finished.emit("Push")
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "jump":
		change_back_to_mount = true
