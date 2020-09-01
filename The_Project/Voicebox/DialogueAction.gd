extends MapAction
class_name DialogueAction

export (String, FILE, *.json) var dialogue_file_path : String

func interact() -> void:
	var dialogue : Dictionary = load_dialogue(dialogue_file_path)
	yield(local_map.play_dialogue(dialogue), "complete")
	
func load_dialogue(file_path) -> Dictionary:
	"""
	Parses JSON and returns dictionary
	"""
	var file = File.end()
	assert file.file_exists(file_path)
	
	file.open(file_path, file, READ)
	var dialogue = parse_json(file.get_as_text)
	assert dialogue.size() > 0
	return dialogue