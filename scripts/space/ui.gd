extends CanvasLayer

export var minimap_zoom = 20

onready var space_player = get_tree().get_nodes_in_group("minimap_player")[0]
onready var space_planets = get_tree().get_nodes_in_group("minimap_planet")

onready var minimap = $minimap
onready var minimap_player = $minimap/player
onready var minimap_planets_node = $minimap/planets

var minimap_planets = []
var minimap_planet = preload("res://scenes/space/minimap/planet.tscn")

var j = 0


func _ready() -> void:

	var i = 0

	for space_planet in space_planets:
		minimap_planets.push_back(minimap_planet.instance())
		minimap_planets_node.add_child(minimap_planets[i])
		minimap_planets[i].get_node("planet").modulate = space_planet.color
		i += 1


func _physics_process(_delta: float) -> void:
	minimap_player.rect_rotation = space_player.rotation_degrees + 90
	
	for space_planet in space_planets:
		minimap_planets[j].get_node("planet").rect_scale = Vector2.ONE * space_planet.scale_multiplier
		minimap_planets[j].position = (
			(( space_planet.global_position - ((space_planet.global_position -space_player.global_position).clamped(1024 * space_planet.scale.x / 3) ) - space_player.global_position)  ) / minimap_zoom ).clamped(110)
		j +=1
	j = 0
