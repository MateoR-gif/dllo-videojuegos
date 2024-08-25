extends Node

@onready var countdownLabel = $"Label-countdown"
@onready var loseLabel = $"Label-lose"
@onready var timer = $Timer


func _ready():
	timer.start()
	loseLabel.visible = false

func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute,second]
	
func _process(delta):
	var padre = get_parent()
	var abuelo = padre.get_parent()
	var player = abuelo.get_node("Player")
	
	if timer.time_left > 0:
		countdownLabel.text = "%02d:%02d" % time_left_to_live()
		
		if timer.time_left <= 10:
			countdownLabel.add_theme_color_override("font_color", Color(1, 0, 0))
		else:
			countdownLabel.add_theme_color_override("font_color", Color(1, 1, 1)) 
	else:
		countdownLabel.visible = false
		loseLabel.text = "Puntaje: " + str(player.score)
		loseLabel.visible = true
		get_tree().paused = true
