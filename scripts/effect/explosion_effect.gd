extends Sprite

onready var animation: AnimationPlayer = get_node("Animation")

export(Array, String) var texture_list

func _ready() -> void:
	randomize()
	var random_number: int = randi() % texture_list.size()
	texture = load(texture_list[random_number])
	animation.play("explosion")
	
	
func on_animation_finished(_anim_name: String) -> void:
	queue_free()
