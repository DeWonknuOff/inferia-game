extends Node2D
const SPEED = 15
var direction :float= 0
var rot :float=0
var cooldown :float=0

var bullet = preload("res://scenes/objects/projectile.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	input(delta)

func input(delta):
	move(delta)
	rota(delta)
	
	if cooldown > 0: cooldown -= delta
	if Input.is_action_pressed("p1left"):
		direction -= SPEED * delta
	elif Input.is_action_pressed("p1right"):
		direction += SPEED * delta
	if Input.is_action_just_pressed("p1action") && cooldown <=0:
		cooldown = 0.35
		shoot()
	if Input.is_action_pressed("p1action") && cooldown <=0:
		cooldown = 0.35
		shoot()
	
	collision()

func shoot():
	get_parent().audio("shoot")
	var bulletINST = bullet.instantiate()
	var bulletINST2 = bullet.instantiate()
	bulletINST.position = $CharacterBody2D/Sprite2D/fire0.global_position
	get_parent().add_child(bulletINST)
	bulletINST2.position = $CharacterBody2D/Sprite2D/fire1.global_position
	get_parent().add_child(bulletINST2)

func move(delta):
	if direction:
		$".".position.x += direction
		direction -= direction * delta
	else:
		$".".position.x += direction
		direction += direction * delta

func rota(delta):
	$"CharacterBody2D/Sprite2D".rotation = direction * 0.1

func collision():
	if $".".position.x < -40:
		$".".position.x = 1199
	if $".".position.x > 1200:
		$".".position.x = -39

var particle = preload("res://scenes/objects/explosion_particle.tscn")

## DEATH

func _on_jitbocs_area_entered(area: Area2D) -> void:
	get_parent().audio("explosion")
	get_parent().die()
	var particleINST = particle.instantiate()
	particleINST.position = $".".position
	get_parent().add_child(particleINST)
	$".".queue_free()
