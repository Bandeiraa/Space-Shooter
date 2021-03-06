extends Area2D

signal kill_projectile
signal camera_shake

onready var attack_timer: Timer = get_node("AttackTimer")

onready var weapon_list: Array = [
	get_node("WeaponManager/Weapon1"),
	get_node("WeaponManager/Weapon2"),
	get_node("WeaponManager/Weapon3")
]

export(PackedScene) var projectile_scene
export(PackedScene) var explosion

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
	var _kill_projectile = connect("kill_projectile", projectile, "kill")
	projectile.global_position = weapon.global_position
	projectile.direction = 1
	get_tree().root.call_deferred("add_child", projectile)
	
	
func update_health(projectile_damage: int) -> void:
	health -= projectile_damage
	if health <= 0:
		kill()
		
		
func kill() -> void:
	emit_signal("camera_shake", 2, 0.4)
	emit_signal("kill_projectile")
	instance_explosion()
	queue_free()
	
	
func instance_explosion() -> void:
	var explosion_scene: Object = explosion.instance()
	explosion_scene.global_position = global_position
	get_tree().root.call_deferred("add_child", explosion_scene)
	
	
func on_screen_exited() -> void:
	queue_free()
