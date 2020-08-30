extends CanvasLayer

onready var animator = $animator


func change_scene(path, delay = 0):
	
	yield(get_tree().create_timer(delay), "timeout")
	animator.play("scene_change")
	yield(animator, "animation_finished")
	yield(get_tree().create_timer(0.5), "timeout")
	var _error = get_tree().change_scene(path)
	animator.play_backwards("scene_change")

