extends KinematicBody2D

onready var animator = $spaceship_animator
onready var particles = $spaceship_particles

export var speed = 2500

var direction = Vector2()
var velocity = Vector2()

var animation


func _physics_process(delta: float) -> void:

	get_input()
	set_animation()
	velocity = velocity.linear_interpolate(direction * speed, .025)
	velocity = move_and_slide(velocity)


func get_input():
	
	direction = Vector2.ZERO
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("up"):
		direction = Vector2(1, 0).rotated(rotation).normalized()


func set_animation():
	if direction == Vector2.ZERO and not particles.modulate == Color("#00ffffff"):
		animator.play_backwards("engine")		
	elif not particles.modulate == Color("#ffffff"):
		animator.play("engine")
		
