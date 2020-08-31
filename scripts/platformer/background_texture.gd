extends TextureRect

var possible_backgrounds = [
    load("res://sprites/platformer/backgrounds/autumn_background.png"),
    load("res://sprites/platformer/backgrounds/desert/1/background.png"),
    load("res://sprites/platformer/backgrounds/desert/2/background.png"),
    load("res://sprites/platformer/backgrounds/desert/3/background.png"),
    load("res://sprites/platformer/backgrounds/desert/4/background.png")
]


func _ready() -> void:
    randomize()
    texture = possible_backgrounds[randi() % possible_backgrounds.size()]