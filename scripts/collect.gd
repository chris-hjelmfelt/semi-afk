extends Area3D

@export var item1: ItemData
@export var quantity: int = 1

func getItem():
	for i in range(PlayerData.items.size()):
		if PlayerData.items[i][0] == item1.name:
			PlayerData.items[i][1] += quantity
	print("Collect - " + item1.name)


func _on_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print(str(name) + " clicked")
		$CollectTimer.start()


func _on_collect_timer_timeout():
	getItem()
