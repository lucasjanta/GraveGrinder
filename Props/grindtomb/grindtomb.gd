extends StaticBody2D

var player : Player
var able_to_grind : bool = false

func _ready():
	pass 

func _process(_delta):
	if able_to_grind:
		if UI.player.is_on_floor():
		#muda a variável on_grind para true
			if !UI.player.on_grind:
				UI.player.on_grind = !UI.player.on_grind
		else:
			#muda a variável on_grind para false
			if UI.player.on_grind:
					UI.player.on_grind = !UI.player.on_grind

#Entrada e saída do grind
func _on_grindarea_body_entered(body):
	if body is Player:
		able_to_grind = true
		print("player entrou no grind")

func _on_grindarea_body_exited(body):
	if body is Player:
		able_to_grind = false
		print("saiu do grind")
