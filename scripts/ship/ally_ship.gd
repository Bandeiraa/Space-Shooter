extends Area2D

onready var x_screensize: int = get_viewport().get_visible_rect().size.x

onready var animation: AnimationPlayer = get_node("Animation")
onready var weapon: Node2D = get_node("WeaponManager")
onready var sprite: Sprite = get_node("Texture")

onready var stats: Node = get_node("ShipStats")

var attack_flag: bool = true
var effect_flag: bool = false

var velocity: Vector2

export(PackedScene) var explosion
export(PackedScene) var ship_effect

export(String) var ship_texture

func _ready() -> void:
	var _attack = stats.connect("can_attack", self, "can_attack")
	var _kill = stats.connect("kill", self, "kill")
	var _effect = stats.connect("spawn_effect", self, "spawn_effect_flag")
	sprite.texture = load(ship_texture)
	
	
func _physics_process(_delta: float) -> void:
	move()
	attack()
	animate()
	verify_position()
	translate(velocity)
	if effect_flag:
		instance_ship_effect()
		
		
func move() -> void:
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	velocity = (direction * stats.initial_speed) * stats.speed
	
	
func attack() -> void:
	if Input.is_action_just_pressed("Shoot") and attack_flag:
		weapon.shoot()
		stats.attacking()
		attack_flag = false
		
		
func animate() -> void:
	if velocity.x > 0:
		animation.play("right")
	elif velocity.x < 0:
		animation.play("left")
	else:
		animation.play("idle")
		
		
func verify_position() -> void:
	var x_form = get_transform()
	
	if x_form.origin.x > x_screensize:
		x_form.origin.x = 0
		
	if x_form.origin.x < 0:
		x_form.origin.x = x_screensize
		
	set_transform(x_form)
	
	
func on_ship_area_entered(area: Object) -> void:
	if area.is_in_group("collectable"):
		match area.collectable_name:
			"double_shoot":
				weapon.enable_double_shoot(area.collectable_value)
				
			"shield":
				stats.update_shield(area.collectable_value)
				
			"speed":
				stats.update_speed(area.collectable_value)
				instance_ship_effect()
				
			"coin":
				stats.update_coin(area.collectable_value)
				
		area.queue_free()
				
				
	if area.is_in_group("enemy_projectile"):
		stats.update_health(area.damage)
		area.queue_free()
		
	if area.is_in_group("enemy_ship"):
		stats.update_health(area.damage)
		area.kill()
		
		
func instance_ship_effect() -> void:
	var effect: Object = ship_effect.instance()
	effect.frame = sprite.frame
	effect.texture = sprite.texture
	effect.global_position = global_position
	get_tree().root.call_deferred("add_child", effect)
	
	
func spawn_effect_flag() -> void:
	effect_flag = !effect_flag
	
	
func can_attack() -> void:
	attack_flag = true
	
	
func kill() -> void:
	instance_explosion()
	queue_free()
	
	
func instance_explosion() -> void:
	var explosion_scene: Object = explosion.instance()
	explosion_scene.global_position = global_position
	get_tree().root.call_deferred("add_child", explosion_scene)
