extends Control

func _on_resume_pressed():
	get_parent().unpause()


func _on_retry_pressed():
	pass # Replace with function body.


func _on_settings_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
