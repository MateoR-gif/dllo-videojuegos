extends Node

@onready var countdownLabel = $"Label-countdown"
@onready var loseLabel = $"Label-lose1"
@onready var timer = $Timer
@onready var addTimeLabel = $"Label"
@onready var sound_time_running_out = $time_running_out
@onready var sound_time_out = $time_out
var player


func _ready():
	var padre = get_parent()
	var abuelo = padre.get_parent()
	player = abuelo.get_node("Player")
	timer.start()

func setScore():
	
	loseLabel.text = "P1: " + str(player.score)

func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute,second]
	
func _process(delta):
	if timer.time_left > 0:
		countdownLabel.text = "%02d:%02d" % time_left_to_live()
		
		if timer.time_left <= 10:
			countdownLabel.add_theme_color_override("font_color", Color(1, 0, 0))
			if not sound_time_running_out.playing:
				sound_time_running_out.play()
		else:
			countdownLabel.add_theme_color_override("font_color", Color(1, 1, 1))

	else:
		GlobalData.final_score = player.score
		countdownLabel.text = "Se acabó el tiempo"
		get_tree().change_scene_to_file("res://game_over.tscn")
		
			
			
		


func _on_button_pressed():
	pass # Replace with function body.
