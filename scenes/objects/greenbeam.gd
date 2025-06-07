extends Node2D
var timer :float= 0

func _ready() -> void:
	$".".scale.x = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var scale_ = $".".scale.x
	timer += delta
	if timer < 1 && scale_ < 1:
		# MAKE BIG
		$".".scale.x += delta
	elif scale_ > 0:
		$".".scale.x -= delta
	
	if timer > 1 && scale_ <= 0:
		$".".queue_free()
	
