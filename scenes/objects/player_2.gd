extends Node2D
const SPEED = 20
var direction :float= 0
var rot :float=0
var charge :float=0
var beaming :bool= false
var texts = [load("res://sprites/ui/charge4.png"),load("res://sprites/ui/charge3.png"),load("res://sprites/ui/charge2.png"),load("res://sprites/ui/charge1.png"),load("res://sprites/ui/charge0.png")]

var beam_ray = preload("res://scenes/objects/bluebeam.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	input(delta)
	

func input(delta):
	move(delta)
	collision()
	
	if Input.is_action_pressed("p2left"):
		direction -= SPEED * delta
	elif Input.is_action_pressed("p2right"):
		direction += SPEED * delta
	
	if Input.is_action_pressed("p2action") && charge < 10 && beaming == false:
		charge += delta * 3.5
		$charge.visible = true
		chargebar()
	elif charge < 10 && charge > 0 && beaming == false:
		charge -= delta * 1
		$charge.visible = false
	
	if Input.is_action_just_released("p2action") && charge > 10 && beaming == false:
		charge = 0
		beaming = true
		$charge.visible = false
		get_parent().audio("shootbeam")
		# LOAD BEAM
		var beam_rayINST = beam_ray.instantiate()
		beam_rayINST.position = $"CharacterBody2D/location".position
		$"CharacterBody2D".add_child(beam_rayINST)
		
		chargebar()

func stopbeam():
	beaming = false
	charge = 0

func chargebar():
	if charge < 2:
		$charge.texture = texts[0]
	elif charge < 4:
		$charge.texture = texts[1]
	elif charge < 6:
		$charge.texture = texts[2]
	elif charge < 8:
		$charge.texture = texts[3]
	elif charge >= 10:
		$charge.texture = texts[4]
func move(delta):
	if direction:
		$".".position.x += direction
		direction -= direction * delta
	else:
		$".".position.x += direction
		direction += direction * delta

func collision():
	if $".".position.x < -40:
		$".".position.x = 1199
	if $".".position.x > 1200:
		$".".position.x = -39

var particle = preload("res://scenes/objects/explosion_particle.tscn")

## DEATH

func _on_jitbacsnave_area_entered(area: Area2D) -> void:
	get_parent().audio("explosion")
	get_parent().die()
	var particleINST = particle.instantiate()
	particleINST.position = $".".position
	get_parent().add_child(particleINST)
	$".".queue_free()
