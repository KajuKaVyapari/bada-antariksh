extends TileMap

onready var rooms_node = get_parent().get_node("rooms")

export var size = Vector2(3, 2)

var possible_rooms = [
	preload("res://scenes/platformer/rooms/room1.tscn"),
	preload("res://scenes/platformer/rooms/room2.tscn"),
	preload("res://scenes/platformer/rooms/room3.tscn"),
	preload("res://scenes/platformer/rooms/room4.tscn"),
]
var brain_room = preload("res://scenes/platformer/rooms/brain_room.tscn")

var rooms = []
var n = 0


func _ready() -> void:
	randomize()
	spawn_rooms()
	global.score = global.score


func get_coords(cell_location):
	return map_to_world(cell_location) * 24


func spawn_rooms():
	for i in size.x:
		for j in size.y:
			if not Vector2(i, j) == Vector2(2, 1):
				rooms.push_back(possible_rooms[randi() % possible_rooms.size()].instance())
			else:
				rooms.push_back(brain_room.instance())
			rooms[n].name = "room" + str(n)
			rooms[n].position = get_coords(Vector2(i, j))
			rooms_node.add_child(rooms[n])
			n += 1
