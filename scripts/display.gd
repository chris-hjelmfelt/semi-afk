extends Control


func _process(_delta):
	$Items/VBoxContainer/Fish/Label2.text = str(PlayerData.items[1][1])
