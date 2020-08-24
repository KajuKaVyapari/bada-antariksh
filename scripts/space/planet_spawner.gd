extends Node2D

onready var _planets = $planets

export var spawn_range = 10000
export var number = 10

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


func spawn_planets():

	for _j in range(number):
		planet_locations.append(Vector2(rand_range(-spawn_range, spawn_range), rand_range(-spawn_range, spawn_range)))

	for planet_location in planet_locations:
		planets.push_back(planet_objects[randi() % planet_objects.size()].instance())
		planets[i].global_position = planet_location
		_planets.add_child(planets[i])
		i +=1
