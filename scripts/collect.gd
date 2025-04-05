extends StaticBody3D

@export var item1: ItemData
@export var quantity: int = 1
var repeat: int = 0
@onready var progress_bar = $"../../UI/Progress/ProgressBar"


func _process(_delta):
	if Globals.is_collecting == true and Globals.current_site == $".":
		$"../../UI/Progress/ProgressBar".value = $CollectTimer.time_left


func getItem():
	PlayerData.items[item1.name] += quantity


func start_collection():
	Globals.is_collecting = true
	Globals.isbusy = true
	Globals.current_site = $"."
	progress_bar.show()
	if repeat == 0:
		$AudioStreamPlayer.play()
		$CollectTimer.start()
		$SoundTimer.start()
	elif repeat < PlayerData.max_repeat:
		repeat += 1
	


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
