extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var tombstone = $"."

func _on_body_entered(body):
	if body is Player:
		if body.velocity.x > 150:
			body.velocity.x -= 150
		else:
			body.velocity.x = 0
		UI.tombstones_destroyed -= 1
		animated_sprite_2d.play("break")
		set_deferred("monitoring", false)
		print("player aqui")

func _on_animated_sprite_2d_animation_finished():
	animated_sprite_2d.animation = "broken"
