extends KinematicBody2D

onready var animator = $spaceship_animator
onready var particles = $spaceship_particles
onready var camera = $spaceship_camera
onready var tween = $spaceship_tween

export var speed = 1000

var direction = Vector2()
var velocity = Vector2()

var animation

var zooming = false
var zoom_values = [Vector2(1, 1), Vector2(4, 4)]


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
		

func zoom(mode):

	tween.interpolate_property(camera, "zoom", camera.zoom, zoom_values[mode], 2)
	tween.start()	
