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
	position -= transform.y * speed
	
	
func on_screen_exited() -> void:
	queue_free()


func on_area_entered(area) -> void:
	if area.is_in_group("enemy_ship"):
		area.update_health(damage)
		
		queue_free()
