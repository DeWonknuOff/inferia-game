extends Node2D
const SPEED :float=.5
var acel:float=0
var reach = [70,1000]
var dir = 1

func _process(delta: float) -> void:
	acel += delta * SPEED
	
	# Reach
	if $".".position.x > reach[1]:
		dir = -dir
		$".".position.y += 50
		$".".position.x = reach[1]
	if $".".position.x < reach[0]:
		dir = -dir
		$".".position.y += 50
		$".".position.x = reach[0]
	
	if dir == 1 && $".".position.x < reach[1]:
		$".".position.x += acel
	elif dir == -1 && position.x > reach[0]:
		$".".position.x -= acel

## Death ##

var particle = preload("res://scenes/objects/explosion_particle.tscn")

func death():
	get_parent().audio("explosion")
	var particleINST = particle.instantiate()
	particleINST.position = $".".position
	get_parent().add_child(particleINST)
	$".".queue_free()
