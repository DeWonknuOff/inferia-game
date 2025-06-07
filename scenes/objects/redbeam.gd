extends Node2D
var timer :float= 0

func _ready() -> void:
	$".".scale.x = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var scale_ = $".".scale.x
	timer += delta
	if timer < 2 && scale_ < 2:
		# MAKE BIG
		$".".scale.x += delta
	elif scale_ > 0 && timer > 3:
		$".".scale.x -= delta
	
	if timer > 3 && scale_ <= 0:
		$".".queue_free()
	
