extends Control


func _process(_delta):
	$Items/VBoxContainer/Wood/Label2.text = str(PlayerData.items["Wood"])
	$Items/VBoxContainer/Stone/Label2.text = str(PlayerData.items["Stone"])
	$Items/VBoxContainer/Fish/Label2.text = str(PlayerData.items["Fish"])
