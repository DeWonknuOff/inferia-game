extends Node2D
var rotationspeed = 0.2

func rotate0(delta):
	$Sprite2D.rotation += rotationspeed*delta

func _process(delta):
	rotate0(delta)
