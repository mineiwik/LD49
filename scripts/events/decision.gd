class_name LGameDecision
extends LGameEvent

class Option:
	var id: String
	var text: String
	var character: String
	# String -> int (stat -> change)
	var consequences: Dictionary

	func from_dict(data: Dictionary) -> void:
		if "id" in data:
			self.id = data["id"] as String
		else:
			self.id = ""
		self.text = data["text"] as String
		if "character" in data:
			self.character = data["character"] as String
		else:
			self.character = ""

		self.consequences = data["consequences"]
		for stat in self.consequences:
			assert(stat is String)
			assert(self.consequences[stat] is int)

var prompt: String
# Option[]
var options: Array

var chosen_option: int = -1

func get_chosen_option() -> Option:
	assert(self.chosen_option != -1, "no option chosen yet")
	return self.options[self.chosen_option]

func has_option_with_id(id: String) -> bool:
	for option in self.options:
		if option.id == id:
			return true
	return false

func execute_consequence(manager) -> void:
	var option := self.get_chosen_option()
	for stat in option.consequences:
		manager.change_stat(stat, option.consequences[stat])

func from_dict(data: Dictionary) -> void:
	.from_dict(data)

	self.prompt = data["prompt"] as String
	self.options = []
	for option in data["options"]:
		var opt := Option.new()
		opt.from_dict(option)
		self.options.append(opt)
	assert(!self.options.empty(), "decision with gid %d doesn't provide any options" % self.gid)

