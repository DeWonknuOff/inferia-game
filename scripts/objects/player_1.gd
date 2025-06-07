extends Node2D
const SPEED = 1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	move(delta)
	print($".".position.x)

func move(delta):
	var direction = Input.get_axis("p1left","p1right")
	if direction:
		if $".".position.x < 100: return FAILED
		$".".position.x += direction * SPEED * delta
	else:
		if $".".position.x > 100: return FAILED
		$".".position.x += ((direction * SPEED) * -1) * delta
