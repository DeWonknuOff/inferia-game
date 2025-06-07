extends Node2D
@onready var asteroid = preload("res://scenes/objects/asteroid.tscn")
@onready var enemy = [preload("res://scenes/objects/enemy0.tscn"),preload("res://scenes/objects/enemy1.tscn"),preload("res://scenes/objects/enemy2.tscn"),preload("res://scenes/objects/boss.tscn")]
@onready var rand = 1
@onready var boss = 0
var timer :float= 0
var maxtimer :float= 0
var trueSCORE :int= 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maxtimer = randi_range(8,10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer > maxtimer:
		spawn()
		timer = 0

func spawn():
	load_data()
	if trueSCORE < 30:
		rand = 0
		maxtimer = randi_range(7,8)
	elif trueSCORE < 60:
		rand = randi_range(0,1)
		maxtimer = randi_range(6,7)
	elif trueSCORE < 120:
		rand = randi_range(0,2)
		boss = randi_range(0,30)
		maxtimer = randi_range(3,5)
	elif trueSCORE < 140:
		boss = randi_range(0,10)
		maxtimer = randi_range(2,3)
	else:
		maxtimer = 1
	
	if rand < 3 && boss != 1:
		spawn_enemy()
	elif boss == 1:
		rand = 3
		spawn_enemy()

func spawn_enemy():
	print(rand)
	var enemy_inst = enemy[rand].instantiate()
	enemy_inst.position.x = randi_range(70,1100)
	$".".get_parent().get_parent().add_child(enemy_inst)

var storage = "user://data.save"

func load_data():
	if FileAccess.file_exists(storage):
		var file = FileAccess.open(storage,FileAccess.READ)
		trueSCORE = file.get_var(trueSCORE)
		file.close()
	else:
		print("Esto está muy void!!!!!!!")
		trueSCORE = 0
