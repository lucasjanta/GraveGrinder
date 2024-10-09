extends StaticBody2D

var player : Player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:
		if player.is_on_floor():
			#muda a variável on_grind para true
			if !player.on_grind:
				player.on_grind = !player.on_grind
	else:
		#muda a variável on_grind para false
		if UI.player.on_grind:
				UI.player.on_grind = !UI.player.on_grind

#Entrada e saída do grind
func _on_grindarea_body_entered(body):
	if body is Player:
		player = body

func _on_grindarea_body_exited(body):
	if body is Player:
		player = null
		print("saiu do grind")
