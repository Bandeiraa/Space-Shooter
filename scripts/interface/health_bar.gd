extends Control

onready var progress_bar: TextureProgress = get_node("ProgressBar")
onready var progress_bar_aux: TextureProgress = get_node("ProgressBarAux")

func initialize_health_bar(health: int) -> void:
	progress_bar.max_value = health
	progress_bar_aux.max_value = health
	
	
func update_health_bar(new_value: int) -> void:
	progress_bar.value = new_value
	progress_bar_aux.value = new_value
