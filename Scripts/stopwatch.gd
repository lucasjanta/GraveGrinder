extends Node
class_name Stopwatch

var time : float = 0.0
var stopped : bool = false

func _process(delta):
	if stopped:
		return
	if !UI.player.game_over:
		time += delta
	
func reset():
	time = 0.0
	
func time_to_string() -> String:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var minute = time / 60
	#formatting time to look like this: 00:00:000
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [minute, sec, msec]
	return actual_string
