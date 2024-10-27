extends Sprite2D

# Referencia al nodo de sonido
@onready var sound_player = $spawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	
	# Llama a la función de spawn con un timeout
	await spawn_with_timeout()

# Función que maneja el spawn con timeout
func spawn_with_timeout() -> void:
	# Esperar 2 segundos
	await get_tree().create_timer(2.0).timeout
	
	set_randomly()

func set_randomly():
	print("A")
	
	var viewport_size = get_viewport_rect().size
	var new_position = Vector2(
		randf_range(0, viewport_size.x - texture.get_width()),
		randf_range(0, viewport_size.y - texture.get_height())
	)
	# Asigna la nueva posición al sprite (a sí mismo)
	position = new_position
	# Muestra el sprite
	visible = true

	# Reproduce el sonido
	sound_player.play()
