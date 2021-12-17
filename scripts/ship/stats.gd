extends Node

signal kill
signal can_attack
signal camera_shake
signal spawn_effect

onready var speed_timer: Timer = get_node("SpeedTimer")
onready var attack_timer: Timer = get_node("AttackTimer")

var coin: int = 0

var hits_blocked: float = 0

var on_speed_boost: bool = false

export(int) var health

export(float) var attack_cooldown

export(float) var speed
export(float) var initial_speed
export(float) var speed_bonus_duration

func _ready() -> void:
	get_tree().call_group("health_bar", "initialize_health_bar", health)
	
	
func attacking() -> void:
	attack_timer.start(attack_cooldown)
	
	
func update_shield(shield: int) -> void:
	hits_blocked += shield
	
	
func update_health(damage: int) -> void:
	if hits_blocked == 0:
		health -= damage
		emit_signal("camera_shake", 2, 0.4)
		get_tree().call_group("health_bar", "on_health_changed", health)
		if health <= 0:
			emit_signal("kill")
			
		return
		
	hits_blocked -= 1
	
	
func update_speed(speed_bonus: float) -> void:
	if on_speed_boost:
		speed_timer.start(speed_timer.time_left + speed_bonus_duration)
		return
		
	speed += speed_bonus
	speed_timer.start(speed_bonus_duration)
	emit_signal("spawn_effect")
	on_speed_boost = true
	
	
func update_coin(coin_amount: int) -> void:
	coin += coin_amount
	
	
func on_speed_timer_timeout() -> void:
	speed = initial_speed
	on_speed_boost = false
	emit_signal("spawn_effect")
	
	
func on_attack_timer_timeout() -> void:
	emit_signal("can_attack")
