extends CanvasLayer

onready var buttons = [$mainmenu_button, $quit_button]

var paused = false setget set_paused


func _ready() -> void:
	resume_game()


func pause_game():
	get_tree().paused = true
	for child in get_children():
		child.visible = true
	for button in buttons:
		button.disabled = false


func resume_game():
	get_tree().paused = false
	for child in get_children():
		child.visible = false
	for button in buttons:
		button.disabled = true


func set_paused(value):
	paused = value
	if paused:
		resume_game()
	else:
		pause_game()


func _input(event: InputEvent) -> void:
	if (
		event.is_action_pressed("ui_cancel")
		and ["planet", "space"].has(get_tree().get_current_scene().get_name())
	):
		self.paused = not paused
