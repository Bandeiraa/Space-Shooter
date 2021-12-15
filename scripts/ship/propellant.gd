extends Position2D

onready var propellant: Sprite = get_node("Propellant")

export(Array, String) var propellant_list

func _ready() -> void:
	randomize()
	var random_number: int = randi() % propellant_list.size()
	propellant.texture = load(propellant_list[random_number])
