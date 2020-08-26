extends KinematicBody2D

onready var animator = $spaceship_animator
onready var particles = $spaceship_particles
onready var camera = $spaceship_camera

export var speed = 1000

var direction = Vector2()
var velocity = Vector2()

var animation
var zooming = false


func _physics_process(_delta: float) -> void:

	get_input()
	set_animation()
	velocity = velocity.linear_interpolate(direction * speed, .025)
	velocity = move_and_slide(velocity)


func get_input():
	look_at(get_global_mouse_position())
	direction = Vector2(1, 0).rotated(rotation).normalized() if Input.is_action_pressed("up") else Vector2.ZERO

	
	

func set_animation():
	if direction == Vector2.ZERO and not particles.modulate == Color("#00ffffff"):
		animator.play_backwards("engine")		
	elif not particles.modulate == Color("#ffffff"):
		animator.play("engine")
		

func zoom_out_req():
	if not zooming:
		zoom_out()
	else:
		yield(animator, "animation_finished")
		zoom_out()
		


func zoom_out():
	zooming = true
	animator.play("zoom")
	yield(animator, "animation_finished")
	zooming = false


func zoom_in_req():
	if not zooming:
		zoom_in()
	else:
		yield(animator, "animation_finished")
		zoom_in()


func zoom_in():
	zooming = true
	animator.play_backwards("zoom")
	yield(animator, "animation_finished")
	zooming = false