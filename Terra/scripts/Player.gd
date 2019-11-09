extends KinematicBody2D

const MOVE_SPEED = 300

const FIREBALL = preload("res://Scenes/fireball.tscn")

var looksLeft = false

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)

func _physics_process(delta):
	var move_vec = Vector2()
	var direction = Vector2()
	var velocity = Vector2()
	
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
		$AnimatedSprite.play("walk_right")
	elif Input.is_action_pressed("move_down"):
		move_vec.y += 1
		$AnimatedSprite.play("walk_right")
	elif Input.is_action_pressed("move_left"):
		looksLeft=true
		move_vec.x -= 1
		$AnimatedSprite.play("walk_left")
	elif Input.is_action_pressed("move_right"):
		looksLeft=false
		move_vec.x += 1
		$AnimatedSprite.play("walk_right")
	else:
		if (looksLeft==true):
			$AnimatedSprite.play("idle_left")
		else:
			$AnimatedSprite.play("idle_right")


	move_vec = move_vec.normalized()
	move_and_collide(move_vec * MOVE_SPEED * delta)

	var look_vec = get_global_mouse_position() - global_position
	#global_rotation = atan2(look_vec.y, look_vec.x)

	if Input.is_action_just_pressed("shoot"):
		var fireball = FIREBALL.instance()
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
		fireball.velocity = look_vec.normalized()
	
	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene("res://Scenes/RotateEarths.tscn")


func kill():
	get_tree().reload_current_scene()
