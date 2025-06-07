extends Node2D
var dR :float= 0.0
var dG :float= 0.0
var dB :float= 0.0
var A :float= 1.0
var disappear : bool= false
var rand : int= 0
	

func random_sprite():
	var texture0 = load('res://sprites/objects/ballstar.png')
	var texture1 = load('res://sprites/objects/pointstar.png')
	rand = randi_range(0,2)
	if rand == 1:
		$Sprite2D.texture = texture0
	elif rand == 2:
		$Sprite2D.texture = texture1
	else:
		pass
func random_color():
	dR = randf()
	dG = randf()
	dB = randf()
	A = 0
	$Sprite2D.self_modulate = Color(dR,dG,dB,A)
func dissapear(delta):
	A -= 0.3 * delta
	$Sprite2D.self_modulate = Color(dR,dG,dB,A)
	if A < 0:
		queue_free()
func appear(delta):
	A += 0.5 * delta
	$Sprite2D.self_modulate = Color(dR,dG,dB,A)
	if A < 0:
		queue_free()

func _ready():
	random_color()
	random_sprite()

func _process(delta):
	if disappear == true:
		dissapear(delta)
	else:
		appear(delta)
		
