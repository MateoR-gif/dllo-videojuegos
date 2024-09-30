extends Node

@onready var countdownLabel = $"Label-countdown"
@onready var loseLabel = $"Label-lose1"
@onready var timer = $Timer


func _ready():
	timer.start()

func setScore():
	var padre = get_parent()
	var abuelo = padre.get_parent()
	var player = abuelo.get_node("Player")
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
		else:
			countdownLabel.add_theme_color_override("font_color", Color(1, 1, 1)) 
	else:
		countdownLabel.visible = false
		get_tree().paused = true
		
