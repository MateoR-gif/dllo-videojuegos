extends Area2D
signal hit

# Referencia al nodo de sonido
@onready var sonido_caminar = $sonido_caminar

@export var speed = 500
var time = 20
var screen_size
var sprite_size
var umbral = 100
var score = 0

func _ready():
	# hide() # Oculta el personaje
	screen_size = get_viewport_rect().size # Almacena el tamaño de la pantalla
	sprite_size = $AnimatedSprite2D # Obtiene el tamaño del sprite

	# Se actualiza posición inicial
	$"AnimatedSprite2D-Mariel".position = Vector2(45, 45)
	$"CollisionShape2D-Mariel".position = Vector2(45, 45)
	$AnimatedSprite2D.position = Vector2(115,45)
	$CollisionShape2D.position = Vector2(115,45)
	$"AnimatedSprite2D-Camilo".position = Vector2(185, 45)
	$"CollisionShape2D-Camilo".position = Vector2(185, 45)


func _process(delta):
	
	var collectable = get_node("Collectable/Collectable2D")
	var scoreTable = get_node("CountdownTimer2")
	var timer = get_node("CountdownTimer2/Timer")
	var velocity = Vector2.ZERO
	var distancia = position.distance_to(collectable.position)

	if distancia < umbral:
		$Collectable/AnimationPlayer.play("pickup")
		collectable.set_randomly()
		score += 1
		scoreTable.setScore()
		timer.start(timer.time_left + 0.05)

	if Input.is_action_pressed("move_right_player2"):
		velocity.x += 1
	if Input.is_action_pressed("move_left_player2"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down_player2"):
		velocity.y += 1
	if Input.is_action_pressed("move_up_player2"):
		velocity.y -= 1
	if Input.is_action_just_pressed("left_clic_action"):
		if speed < 0:
			speed -= 500
		else:
			speed += 500
		print("Velocidad actual: ", speed)
	if Input.is_action_just_released("left_clic_action"):
		speed = 500
		print("Velocidad actual: ", speed)
	if Input.is_action_just_pressed("right_clic_action"):
		speed -= speed + speed
		print("Velocidad actual: ", speed)
	if Input.is_action_just_released("right_clic_action"):
		speed = 500
		print("Velocidad actual: ", speed)

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if not sonido_caminar.playing:
			sonido_caminar.play()
		$AnimatedSprite2D.play()
		$'AnimatedSprite2D-Mariel'.play()
		$"AnimatedSprite2D-Camilo".play()
	else:
		$AnimatedSprite2D.play("default")
		$"AnimatedSprite2D-Mariel".play("new_animation")
		$"AnimatedSprite2D-Camilo".play("camiloquieto")

	position += velocity * delta
	#La función clamp no permite que el personaje se salga de la pantalla
	# Se resta con la posición del primer personaje para evitar que salga de la pantalla
	position = position.clamp(Vector2.ZERO, screen_size - $"AnimatedSprite2D-Camilo".position)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
		$"AnimatedSprite2D-Camilo".animation = "walk"
		$"AnimatedSprite2D-Camilo".flip_v = false
		$"AnimatedSprite2D-Camilo".flip_h = velocity.x < 0
		$"AnimatedSprite2D-Mariel".animation = "walk"
		$"AnimatedSprite2D-Mariel".flip_v = false
		$"AnimatedSprite2D-Mariel".flip_h = velocity.x < 0
		# Línea 33 Alternativa a:
		#	if velocity.x < 0:
		#		$AnimatedSprite2D.flip_h = true
		#	else:
		#		$AnimatedSprite2D.flip_h = false

	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func handleTime():
	if time >= 0:
		time -= 1
		print(time)
	else:
		time = 20

func _on_body_entered(body):
	hide() # Desaparece el personaje al ser golpeado
	# Se emite una señal cuando el personaje es golpeado
	hit.emit()
	# El siguiente desabilita la colisión del personaje para que no se detecte
	# más de una vez.

# script para reiniciar el juego
func start(pos):
	position = pos
	show() # Muestra el personaje
	$CollisionShape2D.disabled = false # Rehabilita las colisiones


	$CollisionShape2D.set_deferred("disabled", true)
