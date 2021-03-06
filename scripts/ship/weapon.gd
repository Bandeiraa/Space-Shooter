extends Node2D

onready var stats: Node = get_parent().get_node("ShipStats")

onready var double_shoot: Timer = get_node("DoubleShoot")
onready var double_weapon_list: Array = [
	get_node("DoubleWeapon/Weapon1"),
	get_node("DoubleWeapon/Weapon2")
]

onready var single_weapon: Node2D = get_node("SingleWeapon")
onready var double_weapon: Node2D = get_node("DoubleWeapon")

var can_double_shoot: bool = false

export(PackedScene) var projectile_scene
 
func shoot() -> void:
	if can_double_shoot:
		for weapon in double_weapon_list:
			spawn_shoot(weapon.global_position)
			
		return
		
	spawn_shoot(single_weapon.get_node("Weapon").global_position)
		
		
func spawn_shoot(shoot_position: Vector2) -> void:
	var projectile: Projectile = projectile_scene.instance()
	var _kill_projectile = stats.connect("kill", projectile, "kill")
	projectile.global_position = shoot_position
	projectile.direction = -1
	get_tree().root.call_deferred("add_child", projectile)
	
	
func enable_double_shoot(double_shoot_time: float) -> void:
	can_double_shoot = true
	var time_left: float = double_shoot.time_left
	double_shoot.start(time_left + double_shoot_time)
	
	
func on_double_shoot_timeout() -> void:
	can_double_shoot = false
	double_weapon.visible = !double_weapon.visible
	single_weapon.visible = !single_weapon.visible
