extends Timer

var fish = preload("res://fish.tscn")

func _on_timer_timeout():
	randomize()
	var fish = fish.instance()
	fish.position = Vector2(randf_range(10,998),randf_range(10,998))
	add_child(fish)
