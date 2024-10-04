class_name Enemy extends CharacterBody2D

var player : Player
var on_screen : bool = false
var pushed = false

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

func _physics_process(_delta):
	if player == null:
		player = UI.player
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_entered():
	on_screen = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
