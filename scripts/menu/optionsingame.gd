extends Control
var music_bus = AudioServer.get_bus_index("music")
var sfx_bus = AudioServer.get_bus_index("sfx")
var music_volume :float= 0.0
var sfx_volume :float=0.0

# LOAD
func _ready() -> void:
	load_data()
	$VBoxContainer/music.value = music_volume
	$VBoxContainer/sfx.value = sfx_volume
# Return
func _on_button_pressed() -> void:
	get_node(".").visible = false
	$"back".play()
# On Changed
func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus,linear_to_db(value))
	if value == 0:
		AudioServer.set_bus_mute(music_bus,true)
	else:
		AudioServer.set_bus_mute(music_bus,false)
	music_volume = value
	save()
func _on_sfx_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(sfx_bus,linear_to_db(value))
	if value == 0:
		AudioServer.set_bus_mute(sfx_bus,true)
	else:
		AudioServer.set_bus_mute(sfx_bus,false)
	sfx_volume = value
	save()
# Save Data
var storage = "user://storage.save"
func save():
	var file = FileAccess.open(storage,FileAccess.WRITE)
	file.store_var(music_volume)
	file.store_var(sfx_volume)
	file.close()

func load_data():
	if FileAccess.file_exists(storage):
		var file = FileAccess.open(storage,FileAccess.READ)
		music_volume = file.get_var(music_volume)
		sfx_volume = file.get_var(sfx_volume)
		file.close()
	else:
		print("No data saved")
		music_volume = 1
		sfx_volume = 1
