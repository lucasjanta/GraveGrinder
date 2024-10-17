extends StaticBody2D

@onready var area_2d = $Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D


var player_on_ramp : bool = false
var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player:
		print("player na rampa")
		player = body
		player_on_ramp = true
		player.jump_force = -350


func _on_area_2d_body_exited(body):
	if body is Player:
		print("player saiu da rampa")
		player = null
		player_on_ramp = false
		if body.velocity.x > 200:
			animated_sprite_2d.play("cut_hand")
		

func _on_up_logic_body_entered(body):
	if body is Player:
		body.animated_sprite_2d.rotation_degrees = -25
		body.animated_sprite_2d.offset = Vector2(10, 0)


func _on_up_logic_body_exited(body):
	if body is Player:
		body.animated_sprite_2d.rotation_degrees = 0
		body.animated_sprite_2d.offset = Vector2(0, 0)
