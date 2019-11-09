extends MeshInstance

export var speed=3.5
var rotate_left
var rotate_right
var rotate_up
var rotate_down
var moveForward
var rotateValue

func _physics_process(delta):
	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene("res://Scenes/Player.tscn")

func _process(delta):
	rotate_left= Input.is_action_pressed("ui_left")
	rotate_right=Input.is_action_pressed("ui_right")
	rotate_up=Input.is_action_pressed("ui_up")
	rotate_down= Input.is_action_pressed("ui_down")
	
	if rotate_left:
		rotateValue = speed*delta
		rotate_x(rotateValue)
	
	if rotate_right:
		rotateValue=-speed*delta
		rotate_x(rotateValue)
	
	if rotate_up:
		rotateValue=speed*delta
		rotate_y(rotateValue)
	
	if rotate_down:
		rotateValue=-speed*delta
		rotate_y(rotateValue)