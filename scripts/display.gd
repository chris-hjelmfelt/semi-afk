extends Control


func _process(_delta):
	$Items/VBoxContainer/Wood/Label2.text = str(PlayerData.items[0][1])
	$Items/VBoxContainer/Fish/Label2.text = str(PlayerData.items[1][1])
