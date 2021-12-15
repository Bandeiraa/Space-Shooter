extends Node

onready var speed_timer: Timer = get_node("SpeedTimer")

var hits_blocked: int = 0

export(float) var health

export(float) var speed
export(float) var initial_speed
export(float) var speed_bonus_duration

func update_shield(shield: int) -> void:
	hits_blocked += shield
	
	
func update_health(damage: int) -> void:
	if hits_blocked > 0:
		health -= damage
		if health <= 0:
			queue_free()
			
		return
		
	hits_blocked -= 1
	
	
func update_speed(speed_bonus: float) -> void:
	if speed_timer.time_left != 0:
		speed_timer.start(speed_timer.time_left + speed_bonus_duration)
		return
		
	speed += speed_bonus
	speed_timer.start()
	
	
func on_speed_timer_timeout() -> void:
	speed = initial_speed
