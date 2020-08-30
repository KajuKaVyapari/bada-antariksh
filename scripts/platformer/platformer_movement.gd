extends Node


func move(body):
	body.velocity.x = lerp(body.velocity.x, body.direction * body.speed, body.acceleration)
	body.velocity = body.move_and_slide(body.velocity, Vector2.UP)
