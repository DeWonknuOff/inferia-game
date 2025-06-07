extends Node2D
### Global Vars ###
var player1 :bool= false
var SCORE :float= 0
var death_players :int=0
var game :bool= true
var trueSCORE :int=0
var maxscore :int=0

var players :int=1

### ready ###
func _ready() -> void:
	random_background()
	load_data()
	load_score()
	if player1 == true:
		get_node("player2").visible = true
		$player2.position.y = 560
		players = 2
	else:
		print("No hay jugador 2")

func audio(sound):
	if sound == "select":
		$sound_manager/select.play()
	elif sound == "explosion":
		$sound_manager/explosion.play()
	elif sound == "shootbeam":
		$sound_manager/shootbeam.play()
	elif sound == "shoot":
		$sound_manager/shoot.play()
	elif sound == "resetbeam":
		$sound_manager/resetbeam.play()
	else:
		print("[ERROR] No audio defined")

func _process(delta: float) -> void:
	if game:
		score(delta)

### Process Functions ###

func score(delta):
	var printSCORE :int= 0
	SCORE += delta
	printSCORE = SCORE
	trueSCORE = printSCORE
	if trueSCORE > maxscore:
		maxscore = trueSCORE
	save_data()
	$game_obj/score.text = str(printSCORE)
	$game_obj/maxscore.text = str(maxscore)

### Another Functions ###

func endgame():
	save_data()
	$"endscene".show_scene()
	game = false

### Init Functions ###

func random_background():
	var texts = [load("res://sprites/backgrounds/background0.png"),load("res://sprites/backgrounds/background1.png"),load("res://sprites/backgrounds/background2.png"),load("res://sprites/backgrounds/background3.png"),load("res://sprites/backgrounds/background4.png"),load("res://sprites/backgrounds/background5.png")]
	var rand :int= randi_range(0,5)
	$background.texture = texts[rand]
	

func die():
	death_players += 1
	if death_players >= players:
		$game_obj.queue_free()
		endgame()
	

func _on_options_pressed() -> void:
	$optionsingame.visible = true

### LOAD DATA ###

var storage = "user://data.save"
var scorefile = "user://score.save"

func save_data():
	var file = FileAccess.open(storage,FileAccess.WRITE)
	var filescore = FileAccess.open(scorefile,FileAccess.WRITE)
	file.store_var(trueSCORE)
	filescore.store_var(maxscore)
	file.close()

func load_data():
	if FileAccess.file_exists(storage):
		var file = FileAccess.open(storage,FileAccess.READ)
		player1 = file.get_var(player1)
			
		file.close()
	else:
		print("Esto está muy void!!!!!!!")
		player1 = false
		maxscore = 0

func load_score():
	if FileAccess.file_exists(scorefile):
		var file = FileAccess.open(scorefile,FileAccess.READ)
		maxscore = file.get_var(maxscore)
			
		file.close()
	else:
		print("Esto está muy void!!!!!!!")
		maxscore = 0
