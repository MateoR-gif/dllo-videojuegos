extends CharacterBody2D
signal hit

const GRAVITY = 10
const JUMP_POWER = -800

var can_jump = true
var controls_flipped = 1 # -1 to flip

@export var speed = 500
var time = 20
var screen_size
var sprite_size
var umbral = 100
var score = 0

@export var is_player2 = false

func _ready():
	# hide() # Oculta el personaje
	
	screen_size = get_viewport_rect().size # Almacena el tamaño de la pantalla
	#sprite_size = $AnimatedSprite2D # Obtiene el tamaño del sprite
	
	# Se actualiza posición inicial
	#$"Player2/AnimatedSprite2D-Mariel".position = Vector2(45, 45)
	#$"Player2/CollisionShape2D-Mariel".position = Vector2(45, 45)
	#$"Player2/AnimatedSprite2D".position = Vector2(115,45)
	#$"Player2/CollisionShape2D".position = Vector2(115,45)
	#$"Player2/AnimatedSprite2D-Camilo".position = Vector2(185, 45)
	#$"Player2/CollisionShape2D-Camilo".position = Vector2(185, 45)
	

	
func _physics_process(delta):
	var fish = get_node("../Collectable/Fish2D")
	var timer = get_node("Player2/CountdownTimer/Timer")
	var distancia = position.distance_to(fish.position)
	velocity.y += GRAVITY
	
	if distancia < umbral:
		fish.set_randomly()
		score += 1
		timer.start(timer.time_left + 0.05)
	
	#if Input.is_action_just_pressed("jump_player" if not is_player2 else "jump_player2"):
		#velocity.y = JUMP_POWER
	#
		#
	#if Input.is_action_pressed("move_right_player2" if is_player2 else "move_right_player"):
		#velocity.x += 1
	#if Input.is_action_pressed("move_left_player2" if is_player2 else "move_left_player"):
		#velocity.x -= 1
	#if Input.is_action_pressed("move_down_player2" if is_player2 else "move_down_player"):
		#velocity.y += 1
	#if Input.is_action_pressed("move_up_player2" if is_player2 else "move_up_player"):
		#velocity.y -= 1
	#if Input.is_action_just_pressed("left_clic_action2" if is_player2 else "left_clic_action"):
		#if speed < 0:
			#speed -= 500
		#else:
			#speed += 500
		#print("Velocidad actual: ", speed)
	#if Input.is_action_just_released("left_clic_action2" if is_player2 else "left_clic_action"):
		#speed = 500
		#print("Velocidad actual: ", speed)
	#if Input.is_action_just_pressed("right_clic_action2" if is_player2 else "right_clic_action"):
		#speed -= speed + speed
		#print("Velocidad actual: ", speed)
	#if Input.is_action_just_released("right_clic_action2" if is_player2 else "right_clic_action"):
		#speed = 500
		#print("Velocidad actual: ", speed)

	if not is_player2:
		if Input.is_action_just_pressed("right_clic_action"):
			controls_flipped *= -1
		
		var input_dir = Input.get_axis("move_left_player", "move_right_player")
		velocity.x = input_dir * speed * controls_flipped
		
		if Input.is_action_just_pressed("jump_player"):		
			if can_jump:
				$JumpTimer.start()
				can_jump = false
				velocity.y = JUMP_POWER
				
	else:
		if Input.is_action_just_pressed("left_clic_action"):
			controls_flipped *= -1
		
		var input_dir = Input.get_axis("move_left_player2", "move_right_player2")
		velocity.x = input_dir * speed * controls_flipped
		
		if Input.is_action_just_pressed("jump_player2"):
			if can_jump:
				$JumpTimer.start()
				can_jump = false
				velocity.y = JUMP_POWER

	if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		$"Player2/AnimatedSprite2D".play()
		$"Player2/AnimatedSprite2D-Mariel".play()
		$"Player2/AnimatedSprite2D-Camilo".play()
	else:
		$"Player2/AnimatedSprite2D".stop()
		$"Player2/AnimatedSprite2D-Mariel".stop()
		$"Player2/AnimatedSprite2D-Camilo".stop()
		
	
	#La función clamp no permite que el personaje se salga de la pantalla
	# Se resta con la posición del primer personaje para evitar que salga de la pantalla
	#position = position.clamp(Vector2.ZERO, screen_size - $"AnimatedSprite2D-Camilo".position)
	
	if velocity.x != 0:
		$"Player2/AnimatedSprite2D".animation = "walk"
		#$"Player2/AnimatedSprite2D".flip_v = false
		#$"Player2/AnimatedSprite2D".flip_h = velocity.x < 0
		$"Player2/AnimatedSprite2D-Camilo".animation = "walk"
		#$"Player2/AnimatedSprite2D-Camilo".flip_v = false
		#$"Player2/AnimatedSprite2D-Camilo".flip_h = velocity.x < 0
		$"Player2/AnimatedSprite2D-Mariel".animation = "walk"
		#$"Player2/AnimatedSprite2D-Mariel".flip_v = false
		#$"Player2/AnimatedSprite2D-Mariel".flip_h = velocity.x < 0
		# Línea 33 Alternativa a:
		#	if velocity.x < 0:
		#		$AnimatedSprite2D.flip_h = true
		#	else:
		#		$AnimatedSprite2D.flip_h = false
		
	elif velocity.y != 0:
		$"Player2/AnimatedSprite2D".animation = "up"
		#$"Player2/AnimatedSprite2D".flip_v = velocity.y > 0
		
	move_and_slide()


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


func _on_jump_timer_timeout() -> void:
	can_jump = true
