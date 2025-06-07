extends Node2D

@export var SPEED :float
var acel:float=0
var reach = [70,1000]
var dir = 1

var timer :float= 0
var maxtime :float= randi_range(7,8)

func _process(delta: float) -> void:
	acel += delta * SPEED
	timer += delta
	
	if timer > maxtime:
		timer = 0
		shoot()
	
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

var beam_ray = preload("res://scenes/objects/redbeam.tscn")

## Shoot
func shoot():
	var beam_rayINST = beam_ray.instantiate()
	beam_rayINST.position.y += 40
	$".".add_child(beam_rayINST)
	$sound.play()

## Death ##

var particle = preload("res://scenes/objects/explosion_particle.tscn")

func death():
	get_parent().audio("explosion")
	var particleINST = particle.instantiate()
	particleINST.position = $".".position
	get_parent().add_child(particleINST)
	$".".queue_free()
