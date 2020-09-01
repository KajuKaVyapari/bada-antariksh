extends Node

var original_planets = 1
var score = 0 setget set_score
var planets = original_planets


func _ready() -> void:
	score = 0
	planets = original_planets


func is_last_planet():
	return true if planets == 0 else false


func set_score(value):
	score = value

	get_tree().get_nodes_in_group("ui_coins")[0].text = "x " + str(score)


func win_planet():
	planets -= 1
	if not is_last_planet():
		scene_changer.change_scene("res://scenes/space/space.tscn", scene_changer.CAPTURE)
	else:
		scene_changer.change_scene("res://scenes/ui/win_screen.tscn", scene_changer.LOAD)
	yield(scene_changer.animator, "animation_finished")
	yield(scene_changer.animator, "animation_finished")
	self.score = score
