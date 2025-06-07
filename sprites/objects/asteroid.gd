extends Node2D
var VELOCITY :float= 1
var direction :float= 0
var text1 = load("res://sprites/objects/asteroid2.png")
var text2 = load("res://sprites/objects/asteroid3.png")

func _ready() -> void:
	var rand = randi_range(0,2)
	if rand == 0:
		$Sprite2D.texture = text1
	elif rand == 1:
		$Sprite2D.texture = text2
	else:
		pass

### Processs

func _process(delta: float) -> void:
	direction += delta * VELOCITY
	$".".position.y += direction
	$".".rotation += direction * .01
	
	if $".".position.y > 750:
		death2()

var particle = preload("res://scenes/objects/explosion_particle.tscn")

func death():
	get_parent().get_parent().audio("explosion")
	var particleINST = particle.instantiate()
	particleINST.position = $".".position
	get_parent().add_child(particleINST)
	$".".queue_free()

func death2():
	$".".queue_free()
