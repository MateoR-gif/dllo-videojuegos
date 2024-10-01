extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
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
