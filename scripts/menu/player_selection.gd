extends Control

var texture0 = load("res://sprites/ui/closed_character_card.png")
var texture1 = load("res://sprites/ui/character_card.png")

@onready var card0 = get_node("card0")
@onready var card1 = get_node("card1")
@onready var tplayer0 = get_node("tplayer0")
@onready var tplayer1 = get_node("tplayer1")
@onready var nextscene = load("res://scenes/select_planet.tscn")

var data_control = "user://data.save"
var player0 :bool= false
var player1 :bool= false

# READY
func _ready() -> void:
	player1 = false

## RESET
func reset() -> void:
	player0 = false
	player1 = false
	
	tplayer0.visible = false
	tplayer1.visible = false
	
	card0.texture = texture0
	card1.texture = texture0
	
	card0.scale.x = 5.689
	card0.scale.y = 6.102
	
	card1.scale.x = 5.689
	card1.scale.y = 6.102

## BUTTON PRESSED
func _on_button_pressed() -> void:
	get_node(".").visible = false
	$"back".play()

func _on_continue_pressed() -> void:
	save()
	if player0 == true:
		$"select".play()
		get_tree().change_scene_to_file("res://scenes/levels/level0.tscn")
	else:
		$"error".play()
	

func _on_player_0_pressed() -> void:
	get_node("select").play()
	card0.texture = texture1
	card0.scale.x = 5
	card0.scale.y = 5
	tplayer0.visible = true
	player0 = true

func _on_player_1_pressed() -> void:
	activateplayer2()

## PLAYER MANAGER
func activateplayer2():
	if player0 == true:
		get_node("select").play()
		card1.texture = texture1
		card1.scale.x = 5
		card1.scale.y = 5
		tplayer1.visible = true
		player1 = true
	else:
		get_node("error").play()

## PLAY

## DATA MANAGER
func save():
	var file = FileAccess.open(data_control,FileAccess.WRITE)
	file.store_var(player1)
	
	file.close()
