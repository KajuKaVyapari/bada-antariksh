extends Area2D


func _on_brain_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		global.win_planet()
