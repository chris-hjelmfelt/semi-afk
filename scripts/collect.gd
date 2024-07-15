extends Area3D

@export var item1: ItemData
@export var quantity: int = 1
	
func getItem():
	for i in range(PlayerData.items.size()):
		if PlayerData.items[i][0] == item1.name:
			PlayerData.items[i][1] += quantity


func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$CollectTimer.start()
		$SoundTimer.start()


func _on_collect_timer_timeout():	
	$SoundTimer.stop()
	getItem()


func _on_sound_timer_timeout():	
	$AudioStreamPlayer.play()
