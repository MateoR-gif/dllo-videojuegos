extends Area2D
signal hit

# Referencia al nodo de sonido
@onready var sonido_caminar = $sonido_caminar

@export var speed = 300
var time = 20
var screen_size
var sprite_size
var umbral = 50
var score = 0


func _ready():
	# Almacena el tamaño de la pantalla
	screen_size = get_viewport_rect().size
	sprite_size = $AnimatedSprite2D

	# Inicializa posiciones
	initialize_positions()

func _process(delta):
	pursue_banana(delta)
	
	handle_animations()

	position = position.clamp(Vector2.ZERO, screen_size - sprite_size.position)

func initialize_positions():
	$AnimatedSprite2D.position = Vector2(115, 45)
	$CollisionShape2D.position = Vector2(115, 45)

func pursue_banana(delta):
	var banana = $Collectable/Banana
	var distancia = position.distance_to(banana.position)
	var scoreTable = get_node("CountdownTimer3")
	var direction = (banana.position - position).normalized()

	if distancia > umbral:
		position += direction * speed * delta
	else:
		$Collectable/AnimationPlayer.play("pickup")
		banana.set_randomly()
		score += 1
		scoreTable.setScore()
		print("Puntaje: ", score)

func handle_animations():
	# Controla animaciones y sonidos según el movimiento
	if position != Vector2.ZERO:
		if not sonido_caminar.playing:
			sonido_caminar.play()
		$AnimatedSprite2D.play("walk")
	else:
		sonido_caminar.stop()
		$AnimatedSprite2D.play("default")
