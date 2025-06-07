extends Node2D
var trueSCORE :int= 0

func show_scene():
	$".".visible = true
	load_data()
	print(trueSCORE)
	$Label2.text = "Puntaje: " + str(trueSCORE)

func _on_button_pressed() -> void:
	get_parent().audio("select")
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

var storage = "user://data.save"

func load_data():
	if FileAccess.file_exists(storage):
		var file = FileAccess.open(storage,FileAccess.READ)
		trueSCORE = file.get_var(trueSCORE)
		file.close()
	else:
		print("Esto está muy void!!!!!!!")
		trueSCORE = 0
