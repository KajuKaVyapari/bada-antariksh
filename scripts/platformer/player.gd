extends KinematicBody2D


onready var animator = $player_animator
onready var raycasts = $raycasts
onready var body = $body
onready var hurtbox = $body/player_sword/player_hurtbox

export var speed = 380
export var acceleration = 0.2
export var gravity = 20
export var jump_power = 690
export var slope_stop = 64

var direction = 0
var velocity = Vector2()

var anim = "idle"
var is_grounded = true


func _physics_process(delta: float) -> void:
	is_grounded = check_is_grounded()


func apply_gravity():
	velocity.y += gravity


func apply_movement():
	if not direction == 0:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, direction * speed, 0.5)
	velocity = move_and_slide(velocity, Vector2.UP, slope_stop)


func handle_move_input():
	direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	body.scale.x = direction if not direction == 0 else body.scale.x



func check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding() and not raycast.get_collider().is_in_group("player"):
			return true
	return false
