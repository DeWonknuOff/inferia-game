class_name AsteroidHurtbox
extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_asteroidhurtzone_area_entered(area: Area2D) -> void:
	get_parent().death()
