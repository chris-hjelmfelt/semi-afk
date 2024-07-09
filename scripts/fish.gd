extends Area3D

@export var item1: ItemData
@export var quantity: int = 1
@export var new_color = Color(1, 1, 1, 1)
@export var first_color = Color(0, 1, 1, 1)
var material = preload("res://textures/water_material.tres")
var active: bool = false
var last: int = 0


func _process(_delta):
	if active:
		if last >= 20:
			material.albedo_color = first_color
			$MeshInstance3D.set_surface_override_material(0, material)
			last = 0
		elif last >= 10:
			material.albedo_color = new_color
			$MeshInstance3D.set_surface_override_material(0, material)
			last += 1
		else:
			last += 1
	
	
func getItem():
	for i in range(PlayerData.items.size()):
		if PlayerData.items[i][0] == item1.name:
			PlayerData.items[i][1] += quantity
	print("Collect " + item1.name)


func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		active = true
		$CollectTimer.start()
		


func _on_collect_timer_timeout():
	active = false
	getItem()
