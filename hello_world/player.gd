extends Area2D

@export var speed = 400
var screen_size

func _ready():
	# hide() # Oculta el personaje
	screen_size = get_viewport_rect().size # Almacena el tamaño de la pantalla

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	#La función clamp no permite que el personaje se salga de la pantalla
	position = position.clamp(Vector2.ZERO, screen_size) 
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
		# Línea 33 Alternativa a:
		#	if velocity.x < 0:
		#		$AnimatedSprite2D.flip_h = true
		#	else:
		#		$AnimatedSprite2D.flip_h = false
		
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
