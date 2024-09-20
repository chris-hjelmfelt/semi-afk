extends Area3D

@export var item1: ItemData
@export var quantity: int = 1

func _process(_delta):
	if Globals.is_collecting == true:
		$"../../UI/Progress/ProgressBar".value = $CollectTimer.time_left
	
	if Input.is_action_just_pressed("collect"):
		if Globals.is_collecting == false and Globals.current_site == $".":
			start_collection()


func getItem():
	for i in range(PlayerData.items.size()):
		if PlayerData.items[i][0] == item1.name:
			PlayerData.items[i][1] += quantity


func start_collection():
	Globals.is_collecting = true
	Globals.current_site = $"."
	$AudioStreamPlayer.play()
	$CollectTimer.start()
	$SoundTimer.start()


func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if Globals.is_collecting == false:
			start_collection()


func _on_collect_timer_timeout():	
	$SoundTimer.stop()
	Globals.is_collecting = false
	getItem()


func _on_sound_timer_timeout():
	$AudioStreamPlayer.play()
