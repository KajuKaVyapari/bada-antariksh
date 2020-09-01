extends state_machine


func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("attack")
	add_state("dead")
	call_deferred("set_state", states.idle)


func state_logic(delta):
	parent.apply_gravity()
	if [states.idle, states.run, states.jump, states.fall, states.attack].has(state):
		if [states.idle, states.run, states.jump, states.fall].has(state):
			parent.handle_move_input()
		parent.apply_movement()


func get_transition(delta):
	match state:
		states.idle:
			if parent.death_particles.is_emitting():
				return states.dead
			if not parent.is_grounded:
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.is_grounded:
				if Input.is_action_just_pressed("fire"):
					return states.attack
				if not parent.velocity.x == 0:
					return states.run
		states.run:
			if parent.death_particles.is_emitting():
				return states.dead
			if not parent.is_grounded:
				if parent.velocity.y < 0:
					return states.jump
				if parent.velocity.y > 0:
					return states.fall
			elif parent.is_grounded:
				if Input.is_action_just_pressed("fire"):
					return states.attack
				if parent.velocity.x == 0:
					return states.idle
		states.jump:
			if parent.death_particles.is_emitting():
				return states.dead
			if not parent.is_grounded:
				if parent.velocity.y > 0:
					return states.fall
			elif parent.is_grounded:
				if Input.is_action_just_pressed("fire"):
					return states.attack
				if not parent.velocity.x == 0:
					return states.run
				elif parent.velocity.x == 0:
					return states.idle
		states.fall:
			if parent.death_particles.is_emitting():
				return states.dead
			if parent.is_grounded:
				if Input.is_action_just_pressed("fire"):
					return states.attack
				if parent.velocity.x == 0:
					return states.idle
				elif not parent.velocity.x == 0:
					return states.run
		states.attack:
			if parent.death_particles.is_emitting():
				return states.dead
			if (
				parent.animator.assigned_animation == "attack"
				and (
					parent.animator.current_animation_position
					== parent.animator.current_animation_length
				)
			):
				return states.idle

	return null


func enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.animator.play("idle")
		states.run:
			parent.animator.play("run")
		states.jump:
			if not sounds.get_node("jump_effect").is_playing():
				sounds.get_node("jump_effect").play()
			parent.animator.play("jump")
		states.fall:
			parent.animator.play("fall")
		states.attack:
			sounds.get_node("sword_effect").play()
			parent.direction = 0
			parent.animator.play("attack")
			parent.hurtbox.disabled = false
		states.dead:
			parent.body.visible = false


func exit_state(old_state, new_state):
	match old_state:
		states.attack:
			parent.hurtbox.disabled = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if [states.idle, states.run].has(state):
			parent.velocity.y = -parent.jump_power
