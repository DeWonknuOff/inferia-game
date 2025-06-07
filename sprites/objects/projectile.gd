extends Node2D
const SPEED = 300

func _process(delta: float) -> void:
	$".".position.y -= delta * SPEED
	if $".".position.y < -50:
		$".".queue_free()
