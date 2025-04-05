extends Node

func _ready():
	FileHandler.set_filename("testing")
	load_game()


func save_game():
	var content = get_save_data()
	var json_string = JSON.stringify(content, "\t")
	FileHandler.save_file(json_string)


func load_game():
	if FileHandler.check_save_file():
		var result = FileHandler.load_file()
		var json = JSON.new()
		var error = json.parse(result)
		if error == OK:
			var data = json.data
			set_data(data)
		else:
			print("JSON Parse Error: ", json.get_error_message(), " in ", result, " at line ", json.get_error_line())


func get_save_data() -> Dictionary:
	var data = PlayerData.items
	return data


func set_data(data):
	print(data)
	PlayerData.items = data
