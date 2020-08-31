extends CanvasLayer

onready var animator = $animator
onready var texture = $anim/anim_texture

var loading_images = [
	load("res://loading_screen.png"),
	load("res://sprites/transition_capture.png"),
	load("res://sprites/transition_abort.png")
]

enum { LOAD, CAPTURE, ABORT }


func change_scene(path, mode, delay = 0):
	texture.texture = loading_images[mode]
	yield(get_tree().create_timer(delay), "timeout")
	animator.play("scene_change")
	yield(animator, "animation_finished")
	yield(get_tree().create_timer(0.5), "timeout")
	var _error = get_tree().change_scene(path)
	animator.play_backwards("scene_change")
