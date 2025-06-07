extends Node2D
var timer :float= 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer > 0.8:
		$".".queue_free()
