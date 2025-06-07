extends Node2D

@export var SPEED :float
@export var type :int
var acel:float=0
var reach = [40,1100]
var dir = 1

var timer :float= 0

func _process(delta: float) -> void:
	acel += delta * SPEED
	rota(delta)
	
	timer += delta
	if timer > 4 && type == 1:
		timer = 0
		shoot()
	
	# Reach
	if $".".position.x > reach[1]:
		dir = -dir
		acel /= 2
		$".".position.y += 50
		$".".position.x = reach[1]
	if $".".position.x < reach[0]:
		dir = -dir
		acel /= 2
		$".".position.y += 50
		$".".position.x = reach[0]
	
	if dir == 1 && $".".position.x < reach[1]:
		$".".position.x += acel
	elif dir == -1 && position.x > reach[0]:
		$".".position.x -= acel

func rota(delta):
	$"Enemy0".rotation = acel * 0.1 * dir

var bullet = load("res://scenes/objects/greenbullet.tscn")

func shoot():
	var bulletINST = bullet.instantiate()
	bulletINST.position = $".".position
	get_parent().get_parent().add_child(bulletINST)

## Death ##

var particle = preload("res://scenes/objects/explosion_particle.tscn")

func death():
	get_parent().audio("explosion")
	var particleINST = particle.instantiate()
	particleINST.position = $".".position
	get_parent().add_child(particleINST)
	$".".queue_free()
