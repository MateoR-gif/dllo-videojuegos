extends Node

@onready var loseLabel = $"Label-lose3"
@onready var timer = $Timer
var player3

func _ready():
	timer.start()
	
func setScore():
	var padre = get_parent()
	var abuelo = padre.get_parent()
	player3 = abuelo.get_node("Player3")
	loseLabel.text = "P3: " + str(player3.score)
	
func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute,second]
	
func _process(delta):
	if timer.time_left > 0:
		pass
	else:
		GlobalData.final_score_3 = player3.score
		loseLabel.visible = true
