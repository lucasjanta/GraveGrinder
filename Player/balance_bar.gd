extends TextureProgressBar

@onready var cursor = $cursor

func _process(delta):
	cursor.position.x = (UI.player.balance * 0.3) + 2
