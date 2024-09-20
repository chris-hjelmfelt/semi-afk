extends Node

var filedir = "user://game_saves"
var filename = "?"
var filepath = filedir + "/" + filename + ".txt"
	

func set_filename(newname: String):
	filename = newname
	filepath = filedir + "/" + filename + ".txt"
	
	
func check_save_file() -> bool: 
	if not FileAccess.file_exists(filepath):
		create_new_save_file()
		return false
	else:
		return true


func create_new_save_file():
	var dir = DirAccess.open("user://")
	if not dir.dir_exists(filedir):
		dir.make_dir(filedir)
	var _newfile = FileAccess.open(filepath, FileAccess.WRITE)
	
	
func save_file(content):
	if not FileAccess.file_exists (filepath):
		print("something went very wrong - save file does not exist")
		var dir = DirAccess.open("user://")
		if not dir.dir_exists(filedir):
			dir.make_dir(filedir)
		create_new_save_file()
	var file = FileAccess.open(filepath, FileAccess.WRITE)		
	file.store_string(content)
	

func load_file() -> String:
	var file = FileAccess.open(filepath, FileAccess.READ)
	if file:
		var result = file.get_as_text()
		return result
	else: 
		print("something went very wrong - save file is missing")
		return ""
		
		
func list_save_files() -> PackedStringArray:
	var dir = DirAccess.open(filedir)
	if dir:
		var file_list = dir.get_files()
		return file_list
	else:
		var empty: PackedStringArray = []
		return empty
