extends CharacterBody3D

@onready var pivot = $CamOrigin
@export var xsens = 0.25
@export var ysens = 0.35
@export var speed = 5.0
@export var jump_velocity = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


#func _ready():
#	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED   <-- this breaks your click on 3D objects


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * xsens))
		pivot.rotate_x(deg_to_rad(-event.relative.y * ysens))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-70), deg_to_rad(70))


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_just_pressed("quit"):
		SaveLoadGame.save_game()
		await get_tree().create_timer(0.5).timeout 
		get_tree().quit()
	
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
