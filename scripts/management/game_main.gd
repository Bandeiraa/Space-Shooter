extends Node

onready var player_stats: Node = get_node("MatelaShip/ShipStats")
onready var enemy: Node2D = get_node("Enemy")
onready var collectable: Node2D = get_node("Collectable")

func _ready() -> void:
	var _enemy = player_stats.connect("kill", enemy, "game_over")
	var _collectable = player_stats.connect("kill", collectable, "game_over")
