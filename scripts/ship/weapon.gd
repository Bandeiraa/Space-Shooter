extends Node2D

#const PROJECTILE = preload("")

onready var double_shoot: Timer = get_node("DoubleShoot")

onready var weapons_list: Array = [
	get_node("SingleWeapon/Weapon"),
	get_node("DoubleWeapon/Weapon1"),
	get_node("DoubleWeapon/Weapon2")
]

onready var single_weapon: Node2D = get_node("SingleWeapon")
onready var double_weapon: Node2D = get_node("DoubleWeapon")

var can_double_shoot: bool = false

export(float) var double_shoot_time

export(Array, Vector2) var spawn_position

func _ready() -> void:
	update_weapon_position()
	
	
func update_weapon_position() -> void:
	for weapon in weapons_list.size():
		weapons_list[weapon].position = spawn_position[weapon]
		
		
func shoot() -> void:
	if can_double_shoot:
		var index: int = 1
		for _i in spawn_position.size():
			spawn_shoot(spawn_position[index])
			index += 1
			
		return
		
	spawn_shoot(weapons_list[0].global_position)
		
		
func spawn_shoot(_shoot_position: Vector2) -> void:
	#var projectile: Object = PROJECTILE.instance()
	#projectile.global_position = shoot_position
	#get_tree().root.call_deferred("add_child", projectile)
	pass
	
	
func enable_double_shoot() -> void:
	can_double_shoot = true
	var time_left: float = double_shoot.time_left
	double_shoot.start(time_left + double_shoot_time)
	
	
func on_double_shoot_timeout() -> void:
	can_double_shoot = false
	double_weapon.visible = !double_weapon.visible
	single_weapon.visible = !single_weapon.visible
