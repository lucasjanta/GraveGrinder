extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_body_entered(body):
	if body is Player:
		UI.save_file(UI.selected_level)
		call_deferred("show_stats")

func show_stats():
	get_tree().change_scene_to_file("res://Scenes/Menus/level_results.tscn")
