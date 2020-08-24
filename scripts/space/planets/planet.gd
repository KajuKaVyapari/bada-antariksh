extends Node2D

export(String, FILE) var scene = ""

func _on_planet_area_body_entered(body):
    if body.name == "spaceship":
        get_tree().change_scene(scene)