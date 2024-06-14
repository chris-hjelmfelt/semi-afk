extends MeshInstance3D

@export var item1: ItemData
@export var quantity: int = 1

func getItem():
	for i in range(PlayerData.items.size()):
		if PlayerData.items[i][0] == item1.name:
			PlayerData.items[i][1] += quantity
	print("Collect - " + item1.name)


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		$CollectTimer.start()


func _on_collect_timer_timeout():
	getItem()
