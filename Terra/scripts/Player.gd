extends KinematicBody2D

const MOVE_SPEED = 300

const FIREBALL = preload("res://Scenes/fireball.tscn")
const MAP = preload("res://Scenes/World.tscn")
var map = MAP.instance()


onready var raycast = $RayCast2D

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)

func _physics_process(delta):
	var move_vec = Vector2()
	var direction = Vector2()
	var velocity = Vector2()
	
	$AnimationPlayer.play("Idle")
	
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
		$AnimatedSprite.play("walk_right")
		if Input.is_action_pressed("move_up"):
			$AnimatedSprite.play("walk_right")
		else:
			$AnimatedSprite.play("idle_right")
	elif Input.is_action_pressed("move_down"):
		move_vec.y += 1
		$AnimatedSprite.play("walk_right")
		if Input.is_action_pressed("move_down"):
			$AnimatedSprite.play("walk_right")
		else:
			$AnimatedSprite.play("idle_right")
	elif Input.is_action_pressed("move_left"):
		move_vec.x -= 1
		$AnimatedSprite.play("walk_left")
		if Input.is_action_pressed("move_left"):
			$AnimatedSprite.play("walk_left")
		else:
			$AnimatedSprite.play("idle_left")
	elif Input.is_action_pressed("move_right"):
		move_vec.x += 1
		$AnimatedSprite.play("walk_right")
		if Input.is_action_pressed("move_right"):
			$AnimatedSprite.play("walk_right")
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
		fireball.rotation = rotation
		fireball.velocity = look_vec.normalized()
	
	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene("res://Scenes/RotateEarths.tscn")


func kill():
	get_tree().reload_current_scene()
