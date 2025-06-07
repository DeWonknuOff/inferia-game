extends Node2D
var rotationspeed = -0.2

func rotate0(delta):
	$Planet2.rotation += rotationspeed*delta

func _process(delta):
	rotate0(delta)
