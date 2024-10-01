extends Node

@onready var loseLabel = $"Label-lose2"
@onready var timer = $Timer


func _ready():
	timer.start()
	
func setScore():
	var padre = get_parent()
	var abuelo = padre.get_parent()
	var player2 = abuelo.get_node("Player2")
	loseLabel.text = "P2: " + str(player2.score)
	
func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute,second]
	
func _process(delta):
	if timer.time_left > 0:
		pass
	else:	
		loseLabel.visible = true
