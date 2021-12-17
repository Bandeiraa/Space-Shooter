extends AudioStreamPlayer

var bgm_list: Dictionary = {
	"outer_space": ["res://assets/sound/bgm/entering_the_outer_space.wav", 0],
	"spring": ["res://assets/sound/bgm/spring.wav", 0]
}

func _ready() -> void:
	randomize()
	pick_song()
	
	
func pick_song() -> void:
	var random_key: Array = bgm_list[get_random_key()]
	stream = load(random_key[0])
	volume_db = random_key[1]
	play()
	
	
func get_random_key() -> String:
	var dict_keys: Array = bgm_list.keys()
	var random_number: int = randi() % dict_keys.size()
	return dict_keys[random_number]
