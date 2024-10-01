extends Control

# Conecta las señales de los botones a estas funciones en el editor de Godot.

# Función para iniciar el juego
func _on_play_pressed():
	if not get_tree().change_scene_to_file("res://player.tscn"):
		print("Error: No se pudo cargar la escena. Verifica la ruta.")

# Función para abrir las opciones (puedes implementar algo aquí)
func _on_options_pressed():
	get_tree().change_scene_to_file("res://menuoptions.tscn")
	

# Función para salir del juego
func _on_quit_pressed():
	get_tree().quit()
