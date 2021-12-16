extends Node2D

signal kill

onready var timer: Timer = get_node("SpawnTimer")

export(float) var spawn_cooldown

export(Array, PackedScene) var ojects_list

func _ready() -> void:
	randomize()
	timer.start(spawn_cooldown)
	
	
func select_object() -> void:
	var random_number: int = randi() % 100 + 1
	for object in ojects_list:
		var oject_scene = object.instance()
		var greater_than: bool = oject_scene.spawn_chance[0] <= random_number
		var smaller_than: bool = oject_scene.spawn_chance[1] >= random_number
		if greater_than and smaller_than: 
			spawn_object(oject_scene)
			return
			
			
func spawn_object(object: Object) -> void:
	var _kill = connect("kill", object, "kill")
	var random_position: int = randi() % 97 + 16
	object.global_position = Vector2(random_position, -32)
	get_tree().root.call_deferred("add_child", object)
	
	
func on_timer_timeout() -> void:
	select_object()
	timer.start(spawn_cooldown)
	
	
func game_over() -> void:
	emit_signal("kill")
	timer.stop()
