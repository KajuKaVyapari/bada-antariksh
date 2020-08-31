extends Node2D

onready var player = get_tree().get_nodes_in_group("minimap_player")[0]

export (String, FILE) var scene = ""
export (Color) var color

var scale_multiplier = rand_range(1, 1.5)


func _ready() -> void:
	scale *= scale_multiplier


func _on_planet_area_body_entered(body):
	if body.name == "spaceship":
		player.zoom(1)


func _on_planet_area_body_exited(body):
	if body.name == "spaceship":
		player.zoom(0)
