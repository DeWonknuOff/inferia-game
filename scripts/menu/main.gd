extends Control
@onready var star = preload("res://scenes/objects/star.tscn")
var timer : float= 0.0
var cap :int=0
## TICK
func _process(delta):
	# Star Spawning
	process_spawning(delta)
##

# BUTTONS CODE

func _on_start_pressed() -> void:
	$playerselector.reset()
	$Audio/select.play()
	get_node("playerselector").visible = true

func _on_options_pressed() -> void:
	$Audio/select.play()
	get_node("options").visible = true

func _on_exit_pressed() -> void:
	$Audio/select.play()
	get_node("exit").visible = true
#

### MISCELLANEOUS

## STARS SPAWNING
func spawn():
	if cap > 100:return FAILED
	var spawner = star.instantiate()
	$StarGenerator.add_child(spawner)
	spawner.position.x = randi_range(0,1152)
	spawner.position.y = randi_range(0,700)
	cap += 1
func process_spawning(delta):
	timer += 1*delta
	if timer >= 1:
		spawn()
		spawn()
		spawn()
		spawn()
		spawn()
		timer = 0
##
