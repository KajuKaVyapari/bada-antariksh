extends Node2D

onready var _planets = $planets

export var spawn_range = 40000
export var margin = 5000

var planet_objects = [
	preload("res://scenes/space/planets/planet_1.tscn"),
	preload("res://scenes/space/planets/planet_2.tscn"),
	preload("res://scenes/space/planets/planet_3.tscn"),
	preload("res://scenes/space/planets/planet_4.tscn"),
	preload("res://scenes/space/planets/planet_5.tscn"),
]
var planet_locations = []
var planets = []
var i = 0


func _ready() -> void:

	randomize()
	spawn_planets()
	global.score = global.score


func spawn_planets():

	while true:
		var proposed_spawn = Vector2(rand_range(-spawn_range, spawn_range), rand_range(-spawn_range, spawn_range))
		if is_valid(proposed_spawn):
			planet_locations.push_back(proposed_spawn)
		if planet_locations.size() == global.planets:
			break


	for planet_location in planet_locations:
		planets.push_back(planet_objects[randi() % planet_objects.size()].instance())
		planets[i].global_position = planet_location
		_planets.add_child(planets[i])
		i +=1


func is_valid(spawn):

	for planet_location in planet_locations:
		if planet_location.distance_to(spawn) < margin:
			return false
	return true


