extends Control

@onready var ganador = $"Label_Ganador"

# Called when the node enters the scene tree for the first time.
func _ready():
	print(GlobalData.final_score)
	print(GlobalData.final_score_2)
	if GlobalData.final_score > GlobalData.final_score_2:
		ganador.text = "¡Jugador P1 ganó"
	elif GlobalData.final_score < GlobalData.final_score_2:
		ganador.text = "¡Jugador P2 ganó!"
	else:
		ganador.text = "¡Empate!"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
