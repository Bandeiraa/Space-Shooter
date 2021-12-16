extends Area2D

onready var attack_timer: Timer = get_node("AttackTimer")

onready var weapon_list: Array = [
	get_node("WeaponManager/Weapon1"),
	get_node("WeaponManager/Weapon2"),
	get_node("WeaponManager/Weapon3")
]

export(PackedScene) var projectile_scene

export(float) var speed
export(float) var health
export(float) var damage
export(float) var attack_cooldown

export(Array, int) var spawn_chance

func _physics_process(_delta: float) -> void:
	position.y += speed
	
	
func on_screen_entered() -> void:
	attack_timer.start(attack_cooldown)


func on_attack_timer_timeout() -> void:
	verify_weapon()
	
	
func verify_weapon() -> void:
	for weapon in weapon_list:
		if weapon.visible:
			spawn_projectile(weapon)
			
	attack_timer.start(attack_cooldown)
	
	
func spawn_projectile(weapon: Position2D) -> void:
	var projectile: Projectile = projectile_scene.instance()
	projectile.global_position = weapon.global_position
	projectile.direction = 1
	get_tree().root.call_deferred("add_child", projectile)
	
	
func update_health(projectile_damage: int) -> void:
	health -= projectile_damage
	if health <= 0:
		queue_free()
		
		
func on_screen_exited() -> void:
	queue_free()
