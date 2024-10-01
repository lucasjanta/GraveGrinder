extends Area2D
class_name HurtBox
@onready var state_machine = $"../StateMachine"
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	self.connect("area_entered", _on_body_entered)
	
func _on_body_entered(hitbox : HitBox) -> void:
	if owner.has_method("take_hit"):
		owner.take_hit(hitbox.slow_amount, hitbox)
	if owner.has_method("zombie_contact"):
		owner.zombie_contact()
