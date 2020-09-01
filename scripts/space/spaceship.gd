extends KinematicBody2D

onready var animator = $spaceship_animator
onready var particles = $spaceship_particles
onready var camera = $spaceship_camera
onready var tween = $spaceship_tween
onready var label = $hud/enter_label

export var speed = 2200

var direction = Vector2()
var velocity = Vector2()

var animation

var zooming = false
var zoom_values = [Vector2(1, 1), Vector2(4, 4)]

var can_enter_planet = false


func _physics_process(_delta: float) -> void:
	get_input()
	set_animation()
	velocity = velocity.linear_interpolate(direction * speed, .005)
	velocity = move_and_slide(velocity)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter_planet") and can_enter_planet:
		scene_changer.change_scene("res://scenes/platformer/rooms/planet.tscn", scene_changer.LOAD)


func get_input():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("up"):
		direction = Vector2(1, 0).rotated(rotation).normalized()
	else:
		direction = Vector2.ZERO
	


func set_animation():
	if direction == Vector2.ZERO and not particles.modulate == Color("#00ffffff"):
		animator.play_backwards("engine")
	elif not particles.modulate == Color("#ffffff"):
		animator.play("engine")


func zoom(mode):
	tween.interpolate_property(camera, "zoom", camera.zoom, zoom_values[mode], 2)
	tween.start()
	tween.interpolate_property(
		label, "modulate", label.modulate, Color("#ffffff") if mode == 1 else Color("#00ffffff"), 1
	)
	tween.start()

	can_enter_planet = bool(mode)
