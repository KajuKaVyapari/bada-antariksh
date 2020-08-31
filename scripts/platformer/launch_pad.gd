extends Area2D


func _on_launch_pad_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.velocity.y = -body.jump_power * 2
