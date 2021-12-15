extends Area2D

onready var collectable_texture: Sprite = get_node("Texture")

var collectable_value: float

export(Array, String) var texture_list
export(String) var collectable_name

export(float) var min_value
export(float) var max_value

export(float) var speed

export(bool) var customize_texture = false

func _ready() -> void:
	randomize()
	collectable_value = rand_range(min_value, max_value)
	
	if customize_texture:
		var random_number: int = randi() % texture_list.size()
		collectable_texture.texture = load(texture_list[random_number])
		
		
func _physics_process(_delta: float) -> void:
	translate(Vector2(0, speed))
	
	
func on_screen_exited() -> void:
	queue_free()
