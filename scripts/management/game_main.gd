extends Node

onready var player: Area2D = get_node("MatelaShip")
onready var player_stats: Node = player.get_node("ShipStats")

onready var enemy: Node2D = get_node("Enemy")
onready var collectable: Node2D = get_node("Collectable")

onready var camera: Camera2D = get_node("Camera")

func _ready() -> void:
	var _enemy = player_stats.connect("kill", enemy, "game_over")
	var _camera_shake = player_stats.connect("camera_shake", camera, "shake")
	var _collectable = player_stats.connect("kill", collectable, "game_over")
