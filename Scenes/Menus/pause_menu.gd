extends Control

@onready var level_node = $"../.."
var paused : bool = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_or_unpause()

func pause_or_unpause() -> void:
	if get_tree().paused == true:
		self.hide()
		get_tree().paused = false
	else:
		self.show()
		get_tree().paused = true

func _on_resume_pressed():
	pause_or_unpause()
	
func _on_retry_pressed():
	get_tree().paused = false
	UI.start_level(1)
	


func _on_settings_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
