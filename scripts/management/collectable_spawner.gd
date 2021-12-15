extends Node2D

onready var timer: Timer = get_node("SpawnTimer")

export(float) var spawn_cooldown

export(Array, PackedScene) var collectable_list

func _ready() -> void:
	randomize()
	timer.start(spawn_cooldown)
	
	
func select_collectable() -> void:
	var random_number: int = randi() % 100 + 1
	for object in collectable_list:
		var collectable = object.instance()
		var greater_than: bool = collectable.spawn_chance[0] <= random_number
		var smaller_than: bool = collectable.spawn_chance[1] >= random_number
		if greater_than and smaller_than: 
			spawn_collectable(collectable)
			return
			
			
func spawn_collectable(collectable: Object) -> void:
	var random_position: int = randi() % 97 + 16
	collectable.global_position = Vector2(random_position, -32)
	get_tree().root.call_deferred("add_child", collectable)
	
	
func on_timer_timeout() -> void:
	select_collectable()
	timer.start(spawn_cooldown)
