extends Area2D
class_name Projectile

onready var sprite: Sprite = get_node("Texture")

var direction: int

var velocity: Vector2

export(float) var damage
export(float) var speed

func _ready() -> void:
	verify_direction()
	
	
func verify_direction() -> void:
	if direction > 0:
		sprite.flip_v = true
		
		
func _physics_process(_delta: float) -> void:
	velocity.y = direction * speed
	translate(velocity)
	
	
func on_screen_exited() -> void:
	queue_free()
