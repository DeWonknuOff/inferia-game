extends Node2D
var timer :float= 0

func _ready() -> void:
	$".".scale.x = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var scale_ = $".".scale.x
	timer += delta
	if timer < 1 && scale_ < 2:
		# MAKE BIG
		$".".scale.x += delta * 1.5
	elif scale_ > 0:
		$".".scale.x -= delta
	
	if timer > 1 && scale_ <= 0:
		get_parent().get_parent().stopbeam()
		get_parent().get_parent().get_parent().audio("resetbeam")
		$".".queue_free()
	
