extends Control

onready var progress_bar: TextureProgress = get_node("ProgressBar")
onready var progress_bar_aux: TextureProgress = get_node("ProgressBarAux")

onready var tween: Tween = get_node("Tween")

var on_tween: bool = false

var current_health: int 

func initialize_health_bar(health: int) -> void:
	progress_bar.max_value = health
	progress_bar_aux.max_value = health
	current_health = health
	
	
func on_health_changed(health: int) -> void:
	animate_value(current_health, health)
	current_health = health
	
	
func animate_value(start: int, end: int) -> void:
	var _initial = tween.interpolate_property(
		progress_bar, 
		"value", 
		start, 
		end,
		0.3,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	
	var _final = tween.interpolate_property(
		progress_bar_aux, 
		"value", 
		start,
		end,
		0.3,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT,
		0.3
	)
	
	var _start = tween.start()
