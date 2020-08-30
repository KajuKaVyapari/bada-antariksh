extends KinematicBody2D


onready var sprite = $enemy_sprite

export var speed = 200
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
	sprite.texture = sprites[randi() % sprites.size()]


func _physics_process(delta: float) -> void:
	move()

func _on_enemy_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_movement"):
		direction *= -1


func move():
	velocity.x = lerp(velocity.x, direction * speed, acceleration)
	velocity = move_and_slide(velocity)
