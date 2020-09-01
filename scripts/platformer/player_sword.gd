extends Area2D


func _on_player_sword_body_entered(body):
	if body.is_in_group("enemies"):
		body.die()
