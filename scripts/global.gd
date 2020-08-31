extends Node

var score = 0 setget set_score
var planets = 12


func is_last_planet():
	return true if planets == 1 else false


func set_score(value):
	score = value
	
	get_tree().get_nodes_in_group("ui_coins")[0].text = "x " + str(score)


func win_planet():
	planets -= 1
	if not planets == 0:
		scene_changer.change_scene("res://scenes/space/space.tscn")
	else:
		scene_changer.change_scene("res://scenes/")
