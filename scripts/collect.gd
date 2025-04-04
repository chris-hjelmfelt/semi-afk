extends Area3D

@export var item1: ItemData
@export var quantity: int = 1
@export var repeat:int  = 3
@onready var progress_bar = $"../../UI/Progress/ProgressBar"


func _process(_delta):
	if Globals.is_collecting == true and Globals.current_site == $".":
		$"../../UI/Progress/ProgressBar".value = $CollectTimer.time_left


func getItem():
	for i in range(PlayerData.items.size()):
		if PlayerData.items[i][0] == item1.name:
			PlayerData.items[i][1] += quantity


func start_collection():
	Globals.is_collecting = true
	Globals.isbusy = true
	Globals.current_site = $"."
	repeat = 3
	$AudioStreamPlayer.play()
	$CollectTimer.start()
	$SoundTimer.start()
	progress_bar.show()


#func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#if Globals.is_collecting == false:
			#start_collection()


func _on_collect_timer_timeout():	
	$SoundTimer.stop()
	getItem()
	if repeat > 0:
		repeat -= 1
		await get_tree().create_timer(1).timeout
		$CollectTimer.start()
		$SoundTimer.start()
	else:
		Globals.is_collecting = false
		Globals.isbusy = false
		progress_bar.hide()


func _on_sound_timer_timeout():
	$AudioStreamPlayer.play()
