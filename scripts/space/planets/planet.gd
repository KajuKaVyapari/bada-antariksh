extends Node2D

onready var player = get_tree().get_nodes_in_group("minimap_player")[0]
onready var tween = $planet_tween
onready var popup = $popup/popup_label

export(String, FILE) var scene = ""
export(Color) var color 

var scale_multiplier = rand_range(1, 1.5)

func _ready() -> void:

	scale *= scale_multiplier

func _on_planet_area_body_entered(body):
	if body.name == "spaceship":
		player.zoom(1)
		tween.interpolate_property(popup, "modulate", popup.modulate, Color("#00ffffff"), 1)
		tween.start()


func _on_planet_area_body_exited(body):
	if body.name == "spaceship":
		player.zoom(0)
		tween.interpolate_property(popup, "modulate", popup.modulate, Color("#ffffff"), 1)
		tween.start()
