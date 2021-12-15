extends ParallaxBackground

onready var parallax_layer: ParallaxLayer = get_node("Layer")
onready var parallax_texture: TextureRect = parallax_layer.get_node("Texture")

export(float) var layer_speed
export(Array, String) var texture_list

func _ready() -> void:
	randomize()
	var random_number: int = randi() % texture_list.size()
	parallax_texture.texture = load(texture_list[random_number])
	
	
func _physics_process(delta: float) -> void:
	parallax_layer.motion_offset.y += layer_speed * delta
