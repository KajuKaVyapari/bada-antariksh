extends KinematicBody2D

onready var sprite = $enemy_sprite
onready var death_particles = $death_particles

export var speed = 250
export var acceleration = .2

var direction = 1
var velocity = Vector2()

var sprites = [
	preload("res://sprites/platformer/alien-ufo-pack/png/shipyellow_manned.png"),
	preload("res://sprites/platformer/alien-ufo-pack/png/shippink_manned.png"),
	preload("res://sprites/platformer/alien-ufo-pack/png/shipblue_manned.png"),
	preload("res://sprites/platformer/alien-ufo-pack/png/shipgreen_manned.png"),
	preload("res://sprites/platformer/alien-ufo-pack/png/shipbeige_manned.png")
]


func _ready() -> void:
	randomize()
	speed *= rand_range(0.8, 2)
	sprite.texture = sprites[randi() % sprites.size()]


func _physics_process(delta: float) -> void:
	move()


func _on_enemy_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_movement"):
		direction *= -1


func move():
	velocity.x = lerp(velocity.x, direction * speed, acceleration)
	velocity = move_and_slide(velocity)


func die():
	direction = 0
	velocity = Vector2.ZERO
	sprite.visible = false
	death_particles.emitting = true
	sounds.get_node("damage_effect").play()
	yield(get_tree().create_timer((0.5)), "timeout")
	queue_free()