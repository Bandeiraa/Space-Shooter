extends Area2D

onready var animation: AnimationPlayer = get_node("Animation")
onready var weapon: Node2D = get_node("WeaponManager")
onready var sprite: Sprite = get_node("Texture")

var can_attack: bool = true

var velocity: Vector2

export(String) var ship_texture

func _ready() -> void:
	sprite.texture = load(ship_texture)
	
	
func _physics_process(_delta: float) -> void:
	move()
	attack()
	animate()
	translate(velocity)
	
	
func move() -> void:
	var input: Vector2 = Vector2.ZERO
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	velocity = input
	
	
func attack() -> void:
	if Input.is_action_just_pressed("Shoot") and can_attack:
		weapon.spawn_shoot()
		
		
func animate() -> void:
	if velocity.x > 0:
		animation.play("right")
	elif velocity.x < 0:
		animation.play("left")
	else:
		animation.play("idle")
		
		
func on_ship_area_entered(area: Object) -> void:
	if area.is_in_group("collectable"):
		match area.collectale_name:
			"double_shoot":
				pass
